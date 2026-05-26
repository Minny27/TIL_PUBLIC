# dropDestination(for:action:)
`TabContent`를 드래그 앤 드롭의 목적지로 지정하는 modifier  
사용자가 특정 탭 위에 데이터를 드롭했을 때, 지정한 클로저로 드롭된 데이터를 처리할 수 있다.

> ### Declaration
```swift
@MainActor @preconcurrency
func dropDestination<T>(
    for payloadType: T.Type = T.self,
    action: @escaping ([T]) -> Void
) -> some TabContent<Self.TabValue> where T: Transferable
```

> ### 지원 플랫폼
- iOS 18.0+
- iPadOS 18.0+
- Mac Catalyst 18.0+
- macOS 15.0+
- visionOS 2.0+

> ### Parameters
* **payloadType**
    - 드롭으로 받을 모델의 타입
    - `Transferable`을 채택한 타입이어야 한다.

* **action**
    - 드롭된 데이터를 처리하는 클로저
    - 전달값은 `[T]` 형태이며, 삽입하거나 처리할 데이터 목록을 의미한다.
    - 반환값은 `Void`이다.

> ### Return Value
- 요소가 탭 위에 드롭되었을 때 `action`을 호출하는 `TabContent`

> ### 특징
- 드롭된 콘텐츠는 바이너리 데이터, 파일 URL, 파일 promise 형태로 제공될 수 있다.
- 드롭 목적지는 modifier를 적용한 탭 콘텐츠 자체이다.
- 일반 `View.dropDestination`과 달리 드롭 위치(`CGPoint`)를 받지 않고, 성공 여부(`Bool`)도 반환하지 않는다.
- 탭 간 분류, 즐겨찾기 추가, 그룹으로 이동 같은 동작을 탭 드롭으로 처리할 때 사용할 수 있다.

> ### Example
```swift
struct Profile: Identifiable {
    let givenName: String
    let familyName: String
    let image = "person.fill"
    let id = UUID().uuidString
}

@State private var profiles = [
    Profile(givenName: "Juan", familyName: "Chavez"),
    Profile(givenName: "Mei", familyName: "Chen"),
    Profile(givenName: "Tom", familyName: "Clark"),
    Profile(givenName: "Gita", familyName: "Kumar")
]

@State private var favoriteProfiles: [Profile] = []

var body: some View {
    TabView {
        Tab("All Profiles", systemImage: "list.bullet") {
            List(profiles) { profile in
                Text(profile.givenName)
                    .draggable(profile.id)
            }
        }

        Tab("Favorites", systemImage: "star.fill") {
            List(favoriteProfiles) { profile in
                Label(profile.givenName, systemImage: profile.image)
            }
        }
        .dropDestination(for: String.self) { receivedIds in
            let favoriteIds = Set(favoriteProfiles.map(\.id))
            let droppedProfiles = profiles.filter {
                receivedIds.contains($0.id) && !favoriteIds.contains($0.id)
            }

            favoriteProfiles.append(contentsOf: droppedProfiles)
        }
    }
}
```

위 예시는 `All Profiles` 탭의 프로필 `id`를 드래그하고, `Favorites` 탭에 드롭하면 `receivedIds`를 받아 즐겨찾기 목록에 추가하는 흐름이다.

> 참고 출처
- [Apple Developer Documentation - dropDestination(for:action:)](https://developer.apple.com/documentation/swiftui/tabcontent/dropdestination(for:action:))
