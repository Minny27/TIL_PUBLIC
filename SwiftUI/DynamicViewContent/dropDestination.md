# dropDestination(for:action:)
`Transferable` 데이터를 동적 View의 삽입 대상으로 받는 modifier  
드롭된 모델 배열과 삽입 위치 offset을 받아, 기반 데이터 컬렉션에 새 요소를 추가할 때 사용한다.

> ### Declaration
```swift
nonisolated
func dropDestination<T>(
    for payloadType: T.Type = T.self,
    action: @escaping ([T], Int) -> Void
) -> some DynamicViewContent where T: Transferable
```

> ### 지원 플랫폼
- iOS 16.0+
- iPadOS 16.0+
- Mac Catalyst 16.0+
- macOS 13.0+
- tvOS 16.0+
- visionOS 1.0+
- watchOS 9.0+

> ### Parameters
* **payloadType**
    - 드롭으로 받을 모델 타입
    - `Transferable`을 준수해야 한다.

* **action**
    - 요소가 추가될 때 SwiftUI가 호출하는 클로저
    - 첫 번째 인자 `[T]`는 드롭된 `Transferable` 모델 목록이다.
    - 두 번째 인자 `Int`는 삽입 위치 offset이다.
    - offset은 동적 View의 기반 데이터 컬렉션을 기준으로 한다.

> ### Return Value
- 원래 View에 요소가 삽입될 때 `action`을 호출하는 `DynamicViewContent`

> ### 특징
- `onInsert`와 달리 `NSItemProvider`를 직접 해석하지 않고, `Transferable`로 변환된 모델을 받는다.
- `View.dropDestination(for:action:isTargeted:)`와 달리 위치를 `CGPoint`로 받지 않고, 컬렉션 삽입 위치인 `Int` offset을 받는다.
- 클로저는 성공 여부 `Bool`을 반환하지 않는다.
- 리스트나 동적 컬렉션에 드롭으로 항목을 추가하는 작업에 적합하다.

> ### Example
```swift
import SwiftUI
import CoreTransferable
import UniformTypeIdentifiers

struct Profile: Identifiable, Codable, Transferable {
    let id: UUID
    let givenName: String
    let familyName: String

    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .profile)
    }
}

extension UTType {
    static let profile = UTType(exportedAs: "com.example.profile")
}

struct ContentView: View {
    @State private var profiles: [Profile] = [
        Profile(id: UUID(), givenName: "Juan", familyName: "Chavez"),
        Profile(id: UUID(), givenName: "Mei", familyName: "Chen"),
        Profile(id: UUID(), givenName: "Tom", familyName: "Clark")
    ]

    var body: some View {
        List {
            ForEach(profiles) { profile in
                Text(profile.givenName)
                    .draggable(profile)
            }
            .dropDestination(for: Profile.self) { receivedProfiles, offset in
                profiles.insert(
                    contentsOf: receivedProfiles,
                    at: min(offset, profiles.endIndex)
                )
            }
        }
    }
}
```

위 예시는 드롭된 `Profile` 모델을 받아 `ForEach` 기반 컬렉션의 지정 위치에 삽입한다.

> 참고 출처
- [Apple Developer Documentation - dropDestination(for:action:)](https://developer.apple.com/documentation/swiftui/dynamicviewcontent/dropdestination(for:action:))

