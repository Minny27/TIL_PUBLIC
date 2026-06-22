# ResultsObserver

`ResultsObserver`는 SwiftData의 model context에서 특정 fetch 조건에 맞는 persistent model 목록을 관찰하는 class이다.
저장소의 데이터가 바뀌면 현재 조회 결과를 갱신하므로, UI를 persistent data와 동기화할 때 사용할 수 있다.

> 문서 기준: iOS 27.0, iPadOS 27.0, macOS 27.0, tvOS 27.0, visionOS 27.0, watchOS 27.0 beta

## 선언

```swift
final class ResultsObserver<Element, SectionName>
where Element: PersistentModel, SectionName: Hashable
```

`Element`는 관찰할 SwiftData 모델 타입이다.
`SectionName`은 section grouping에 사용할 이름 타입이다.
section이 필요 없으면 `Never`를 사용한다.

## 역할

`ResultsObserver`는 fetch 조건에 맞는 모델 collection을 유지한다.
관찰 대상 데이터가 바뀌면 observer가 변경을 반영하고, observer 자체가 `Observable`이기 때문에 SwiftUI view도 변경을 감지할 수 있다.

변경 감지 대상은 다음과 같다.

- 같은 `ModelContext` 안에서 발생한 local change
- 같은 `ModelContainer`의 다른 context에서 발생한 remote change
- 다른 process 또는 CloudKit sync를 통해 들어온 external change

즉, 단순히 현재 context에서 직접 insert/delete한 결과만 보는 것이 아니라 같은 container와 store를 통해 들어오는 변경까지 반영하는 관찰 도구이다.

## 생성 방식

생성자는 크게 두 계열로 나뉜다.

- `FetchDescriptor`를 직접 전달하는 방식
- `Predicate`와 `SortDescriptor`를 개별 인자로 전달하는 방식

또한 `ModelContext`를 기준으로 만들 수도 있고, `ModelContainer`를 기준으로 만들 수도 있다.

section이 없는 목록은 `SectionName`에 `Never`를 사용한다.

```swift
let observer = try ResultsObserver<Book, Never>(
    filterBy: #Predicate { $0.isPublished },
    sortBy: [SortDescriptor(\.title)],
    modelContext: context
)
```

section이 필요한 목록은 section key path의 값 타입을 `SectionName`으로 지정한다.
예를 들어 장르 문자열로 책을 묶는다면 `String`을 사용할 수 있다.

```swift
let observer = try ResultsObserver<Book, String>(
    sectionBy: \.genre,
    modelContext: context
)
```

문서에 나온 생성자들은 `throws`이므로 실제 코드에서는 초기화 실패를 처리해야 한다.

## 주요 property

| Property | 의미 |
| --- | --- |
| `results` | 현재 fetch 조건에 맞는 모델 collection |
| `sections` | sectioning을 사용할 때의 section collection |
| `fetchDescriptor` | observer가 사용하는 전체 fetch descriptor |
| `filterBy` | 결과를 제한하는 predicate |
| `sortBy` | 결과 정렬에 사용하는 sort descriptor 배열 |
| `sectionBy` | section grouping에 사용하는 key path |
| `modelContext` | 모델을 fetch하는 기준 context |

결과 접근에는 `results`를 직접 사용할 수 있고, section 기반 UI에서는 `sections`, `element(at:)`, `indexPath(for:)`를 함께 사용할 수 있다.

```swift
let item = observer.element(at: indexPath)
let indexPath = observer.indexPath(for: book)
```

## `@Query`와의 차이

`@Query`는 SwiftUI view 안에서 간단하게 SwiftData 결과를 가져오는 데 적합하다.
반면 `ResultsObserver`는 observer 객체 자체가 결과와 section 정보를 관리한다.

따라서 다음 상황에서는 `ResultsObserver`가 더 맞을 수 있다.

- view 바깥의 observable state object에서 fetch 결과를 관리하고 싶을 때
- sectioned result를 명시적으로 다루고 싶을 때
- 같은 fetch 조건을 여러 UI 또는 helper에서 재사용하고 싶을 때
- context, container, isolation actor를 더 직접 제어하고 싶을 때

## 사용 흐름

1. 관찰할 모델 타입을 정한다.
2. fetch 조건을 `FetchDescriptor` 또는 `Predicate`/`SortDescriptor`로 만든다.
3. section이 없으면 `SectionName`을 `Never`로 둔다.
4. section이 있으면 `String` 또는 `String?` key path 기반 생성자를 사용한다.
5. SwiftUI에서는 observer의 observable property를 읽어 UI를 구성한다.

## 주의할 점

- `ResultsObserver`는 SwiftData 모델 목록을 관찰하는 도구이지, 임의의 저장소 이벤트를 모두 처리하는 general notification system은 아니다.
- section이 필요 없는데 `String` 같은 타입을 쓰면 API 선택이 불필요하게 복잡해진다. section이 없으면 `Never`가 명확하다.
- CloudKit sync나 app extension 변경까지 반영하려면 같은 `ModelContainer`와 store 구성이 전제되어야 한다.
- 문서 기준으로 beta API이므로 실제 프로젝트 도입 전 target OS와 Xcode 버전을 확인해야 한다.

## 참고 출처

- [Apple Developer Documentation - ResultsObserver](https://developer.apple.com/documentation/swiftdata/resultsobserver)
- [Apple Developer Documentation - FetchDescriptor](https://developer.apple.com/documentation/swiftdata/fetchdescriptor)
- [Apple Developer Documentation - ModelContext](https://developer.apple.com/documentation/swiftdata/modelcontext)
