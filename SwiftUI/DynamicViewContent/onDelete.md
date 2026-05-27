# onDelete(perform:)
동적 View의 요소 삭제 동작을 설정하는 modifier  
사용자가 `List`에서 행을 삭제하면 SwiftUI가 삭제 대상 index 목록을 `IndexSet`으로 전달한다.

> ### Declaration
```swift
nonisolated
func onDelete(
    perform action: Optional<(IndexSet) -> Void>
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
    - 요소가 삭제될 때 SwiftUI가 호출하는 클로저
    - 전달값은 삭제 대상 index들의 집합인 `IndexSet`이다.
    - index는 동적 View의 기반 데이터 컬렉션을 기준으로 한다.
    - `nil`을 전달하면 삭제 동작을 비활성화할 수 있다.

> ### Return Value
- 원래 View에서 요소가 삭제될 때 `action`을 호출하는 `DynamicViewContent`

> ### 특징
- `onDelete`는 삭제 이벤트를 알려줄 뿐, 실제 데이터 삭제는 직접 처리해야 한다.
- Apple 문서 기준으로 `List`에서는 행이 이미 제거된 뒤 `action`이 호출되므로, 클로저 안에서 대응되는 데이터를 반드시 삭제해야 한다.
- 보통 `ForEach`에 적용하고, `List`의 `EditButton` 또는 swipe-to-delete 동작과 함께 사용한다.
- 배열에는 `remove(atOffsets:)`를 사용하면 `IndexSet`을 바로 적용할 수 있다.

> ### Example
```swift
struct ContentView: View {
    @State private var names = ["Juan", "Mei", "Tom", "Gita"]

    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                Text(name)
            }
            .onDelete(perform: delete)
        }
        .toolbar {
            EditButton()
        }
    }

    private func delete(at offsets: IndexSet) {
        names.remove(atOffsets: offsets)
    }
}
```

위 예시는 삭제 대상 index를 받아 `names` 배열에서 해당 요소를 제거한다.

> 참고 출처
- [Apple Developer Documentation - onDelete(perform:)](https://developer.apple.com/documentation/swiftui/dynamicviewcontent/ondelete(perform:))

