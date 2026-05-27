# onMove(perform:)
동적 View의 요소 이동 동작을 설정하는 modifier  
사용자가 `List`에서 행을 재정렬하면 SwiftUI가 이동 대상 index와 목적지 offset을 전달한다.

> ### Declaration
```swift
nonisolated
func onMove(
    perform action: Optional<(IndexSet, Int) -> Void>
) -> some DynamicViewContent
```

> ### 지원 플랫폼
- iOS 13.0+
- iPadOS 13.0+
- Mac Catalyst 13.0+
- macOS 10.15+
- tvOS 13.0+
- visionOS 1.0+
- watchOS 6.0+

> ### Parameters
* **action**
    - 요소가 이동될 때 SwiftUI가 호출하는 클로저
    - 첫 번째 인자 `IndexSet`은 이동할 원본 index 목록이다.
    - 두 번째 인자 `Int`는 이동할 목적지 offset이다.
    - 두 값 모두 동적 View의 기반 데이터 컬렉션을 기준으로 한다.
    - `nil`을 전달하면 이동 동작을 비활성화할 수 있다.

> ### Return Value
- 원래 View 안에서 요소가 이동될 때 `action`을 호출하는 `DynamicViewContent`

> ### 특징
- `onMove`는 이동 이벤트를 알려줄 뿐, 실제 데이터 순서 변경은 직접 처리해야 한다.
- 배열에는 `move(fromOffsets:toOffset:)`를 사용하면 SwiftUI가 전달한 값을 그대로 적용할 수 있다.
- `List`에서 편집 모드의 reorder control 또는 플랫폼별 드래그 재정렬 동작과 연결된다.
- `EditButton`을 함께 제공하면 사용자가 명시적으로 편집 모드에 들어갈 수 있다.

> ### Example
```swift
struct ContentView: View {
    @State private var names = ["Juan", "Mei", "Tom", "Gita"]

    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                Text(name)
            }
            .onMove(perform: move)
        }
        .toolbar {
            EditButton()
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        names.move(fromOffsets: source, toOffset: destination)
    }
}
```

위 예시는 사용자가 행을 이동한 순서대로 `names` 배열의 순서도 변경한다.

> 참고 출처
- [Apple Developer Documentation - onMove(perform:)](https://developer.apple.com/documentation/swiftui/dynamicviewcontent/onmove(perform:))

