# Adopting SwiftData for a Core Data app

Apple의 `Adopting SwiftData for a Core Data app` 문서는 기존 Core Data 앱에 SwiftData를 도입하는 방법을 SampleTrips 앱으로 설명한다.
핵심은 한 번에 전체 앱을 SwiftData로 바꾸는 방법과, Core Data와 SwiftData를 같은 저장소 위에서 함께 사용하는 방법을 비교해서 보여주는 것이다.

> 문서 기준: iOS 27.0, iPadOS 27.0, macOS 27.0, Mac Catalyst 27.0, Xcode 27.0 beta

## 샘플 앱 구성

SampleTrips 앱은 여행 목록과 여행별 일정 정보를 저장하고 표시하는 앱이다.
문서에서는 같은 기능을 세 가지 형태로 제공한다.

- Core Data 버전: Core Data 기반 구현과 권장 패턴을 보여준다.
- SwiftData 버전: Core Data 모델과 기능을 SwiftData로 완전히 전환한 형태를 보여준다.
- 공존 버전: 메인 앱은 Core Data를 사용하고, 위젯 확장은 SwiftData를 사용한다. 점진적 도입이나 일부 기능만 SwiftData로 옮기는 상황을 다룬다.

## 프로젝트 설정

샘플 코드를 실행하려면 모든 target의 developer team을 자신의 팀으로 설정해야 한다.
앱과 위젯이 같은 데이터를 공유하므로 App Group identifier도 자신의 팀에 맞게 바꿔야 한다.

예시 identifier는 다음과 같다.

```text
group.com.example.apple-samplecode.SampleTrips
```

실제 프로젝트에서는 앱과 확장이 모두 같은 App Group entitlement를 가지도록 설정해야 한다.

## Core Data 모델을 SwiftData 모델로 옮기기

SwiftData 버전은 Core Data entity에 대응하는 Swift 타입을 만든다.
각 모델 타입은 `@Model` macro를 사용하고, SwiftData가 관리할 수 있도록 `PersistentModel` 및 `Observable` 관련 동작을 얻게 된다.

Core Data에서 entity, attribute, relationship으로 표현하던 정보를 SwiftData에서는 Swift class의 property와 macro로 표현한다.

```swift
@Model
final class Trip {
    #Index<Trip>([\.name], [\.startDate], [\.endDate])
    #Unique<Trip>([\.name, \.startDate, \.endDate])

    @Attribute(.preserveValueOnDeletion)
    var name: String

    @Attribute(.preserveValueOnDeletion)
    var startDate: Date

    @Attribute(.preserveValueOnDeletion)
    var endDate: Date

    @Relationship(deleteRule: .cascade, inverse: \BucketListItem.trip)
    var bucketList: [BucketListItem] = []
}
```

정리하면 다음 항목을 Core Data 모델과 맞춰야 한다.

- entity 이름
- attribute 이름과 타입
- relationship 구조와 inverse
- delete rule
- index와 unique 제약

## ModelContainer와 ModelContext

SwiftData 앱은 `ModelContainer`를 만들어 앱 전체에서 같은 저장소 설정을 사용한다.
SwiftUI에서는 scene이나 root view에 `modelContainer`를 연결하면 기본 `ModelContext`가 environment에 들어간다.

```swift
.modelContainer(modelContainer)
```

view에서는 다음처럼 context를 가져온다.

```swift
@Environment(\.modelContext) private var modelContext
```

`ModelContext`는 Core Data의 `NSManagedObjectContext`와 비슷하게 insert, delete, fetch, save의 중심 역할을 한다.

## 데이터 생성, 저장, 삭제

새 모델 객체를 만들고 `ModelContext`에 insert하면 영속화 대상이 된다.

```swift
let trip = Trip(
    name: name,
    startDate: startDate,
    endDate: endDate
)

modelContext.insert(trip)
```

SwiftData는 implicit save를 지원한다.
문서의 샘플은 UI lifecycle event와 context 변경 이후의 timer를 통해 변경 사항을 저장한다.
자동 저장 동작은 `ModelContext.autosaveEnabled`와 관련된다.

삭제는 context에 삭제할 모델을 전달한다.

```swift
modelContext.delete(trip)
```

## 데이터 조회

SwiftUI 화면에서 단순 목록을 표시할 때는 `@Query`를 사용할 수 있다.

```swift
@Query(sort: \Trip.startDate, order: .forward)
private var trips: [Trip]
```

조건이 더 복잡하거나 코드에서 직접 조회해야 할 때는 `FetchDescriptor`와 `ModelContext.fetch(_:)`를 사용한다.

```swift
var descriptor = FetchDescriptor<BucketListItem>()
let tripName = trip.name

descriptor.predicate = #Predicate { item in
    item.title.contains(searchText) && item.trip?.name == tripName
}

let filteredList = try modelContext.fetch(descriptor)
```

`@Query`는 SwiftUI view와 잘 맞고, `FetchDescriptor`는 명시적인 조회 로직을 구성할 때 적합하다.

## 상속 모델

샘플은 `Trip`을 기반으로 `PersonalTrip`, `BusinessTrip` 같은 구체 타입을 확장하는 예시도 포함한다.
공통 속성은 상위 class에 두고, 여행 종류별 속성은 하위 class에 둔다.

```swift
class PersonalTrip: Trip {
    var reason: Reason

    init(
        name: String,
        startDate: Date = .now,
        endDate: Date = .distantFuture,
        reason: Reason
    ) {
        self.reason = reason
        super.init(name: name, startDate: startDate, endDate: endDate)
    }
}
```

상속을 사용할 때도 저장 모델의 구조, 초기화 흐름, relationship이 실제 schema와 맞는지 확인해야 한다.

## Core Data와 SwiftData 공존

공존 버전은 두 개의 persistence stack을 둔다.

- 메인 앱: Core Data stack
- 위젯 확장: SwiftData stack

두 stack은 같은 store file에 접근한다.
이 방식은 전체 앱을 바로 SwiftData로 옮기기 어렵거나, 새 기능 또는 확장 기능부터 SwiftData를 쓰고 싶을 때 사용할 수 있다.

## 이름 충돌 피하기

Core Data의 `NSManagedObject` subclass와 SwiftData 모델 class가 같은 이름을 쓰면 충돌할 수 있다.
문서의 샘플은 Core Data class 이름에 `CD` prefix를 붙인다.

```swift
class CDTrip: NSManagedObject {
    // Core Data entity subclass
}
```

이때 중요한 점은 class 이름을 구분하는 것이며, entity 이름 자체를 반드시 바꾼다는 의미는 아니다.
메인 앱의 Core Data 코드에서는 `CDTrip`처럼 Core Data 전용 타입을 사용한다.

```swift
let newTrip = CDTrip(context: viewContext)
```

## 같은 store file 공유

Core Data와 SwiftData가 같은 데이터를 보려면 두 stack이 같은 persistent store URL을 사용해야 한다.
Core Data에서는 persistent store description에 store URL을 지정한다.

```swift
if let description = container.persistentStoreDescriptions.first {
    description.url = url
}
```

또한 Core Data stack에서는 persistent history tracking을 직접 켜야 한다.
SwiftData는 persistent history tracking을 자동으로 활성화하지만, Core Data는 기본값이 아니기 때문이다.

```swift
description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
```

SwiftData의 기본 저장 위치도 알아야 한다.

- 일반 앱: Application Support directory에 저장한다.
- App Group을 사용하는 앱: App Group container의 root directory에 저장한다.
- App Group이 없던 앱이 App Group을 도입하면 SwiftData가 기존 store를 App Group container로 복사할 수 있다.

앱과 위젯이 같은 데이터를 공유하려면 동일한 App Group container와 동일한 store 위치를 기준으로 stack을 구성해야 한다.

## 변경 감지

공존 샘플에서는 위젯에서 숙소 확인 상태를 바꾸고, 메인 앱이 foreground로 돌아왔을 때 해당 변경을 감지해 읽지 않은 변경 표시를 보여준다.

문서는 변경 감지 방법을 세 가지로 비교한다.

1. 공유 `UserDefaults`에 변경 표시를 저장한다.
2. `Trip`에 unread 같은 새 attribute를 추가한다.
3. SwiftData가 생성하는 store history를 소비해서 관련 변경만 찾는다.

샘플은 세 번째 방식을 선택한다.
`UserDefaults` 방식은 SwiftData 저장소와 별도 저장소 사이의 일관성을 관리해야 한다.
unread attribute 방식은 구현은 쉽지만, 도메인 모델에 중복 상태를 추가하고 저장 공간도 더 사용한다.

history 기반 방식은 `HistoryDescriptor<DefaultHistoryTransaction>`과 `DefaultHistoryToken`을 사용한다.
마지막으로 읽은 token 이후의 transaction만 가져오고, 그중 관심 있는 모델 변경을 찾아 UI 상태에 반영한다.

```swift
private func findTransactions(
    after historyToken: DefaultHistoryToken?,
    author: String
) -> [DefaultHistoryTransaction] {
    // token 이후의 history transaction을 조회한다.
}
```

이 방식은 앱 확장, 다른 context, CloudKit 동기화처럼 변경 주체가 여러 개인 상황에서 유용하다.

## 정리

Core Data 앱에 SwiftData를 도입할 때는 단순히 모델 코드를 `@Model`로 바꾸는 것만으로 끝나지 않는다.
저장소 위치, App Group, class 이름 충돌, persistent history tracking, 변경 감지 전략을 함께 설계해야 한다.

전체 전환이 가능하다면 SwiftData 모델, `ModelContainer`, `ModelContext`, `@Query` 중심으로 단순화할 수 있다.
점진적 도입이 필요하다면 Core Data와 SwiftData가 같은 store file을 바라보도록 구성하고, Core Data 쪽 persistent history tracking을 반드시 켜야 한다.

## 참고 출처

- [Apple Developer Documentation - Adopting SwiftData for a Core Data app](https://developer.apple.com/documentation/coredata/adopting-swiftdata-for-a-core-data-app)
- [Apple Developer Documentation - ModelContainer](https://developer.apple.com/documentation/swiftdata/modelcontainer)
- [Apple Developer Documentation - ModelContext](https://developer.apple.com/documentation/swiftdata/modelcontext)
- [Apple Developer Documentation - NSPersistentHistoryTrackingKey](https://developer.apple.com/documentation/coredata/nspersistenthistorytrackingkey)
