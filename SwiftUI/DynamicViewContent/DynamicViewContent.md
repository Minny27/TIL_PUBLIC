# DynamicViewContent
기반 데이터 컬렉션으로부터 동적인 View를 생성하는 SwiftUI 프로토콜  
주로 `ForEach`처럼 컬렉션을 순회해 여러 View를 만들고, `List` 안에서 삭제, 삽입, 이동, 드롭 삽입 같은 편집 동작을 연결할 때 사용된다.

> ### Declaration
```swift
protocol DynamicViewContent<Data> : View
```

```swift
associatedtype Data: Collection

var data: Self.Data { get }
```

> ### 지원 플랫폼
- iOS 13.0+
- iPadOS 13.0+
- Mac Catalyst 13.0+
- macOS 10.15+
- tvOS 13.0+
- visionOS 1.0+
- watchOS 6.0+

> ### 구성 요소
* **Data**
    - View를 생성하는 기반 컬렉션 타입
    - `Collection`을 준수해야 한다.

* **data**
    - View 생성에 사용되는 실제 기반 데이터 컬렉션
    - 읽기 전용 프로퍼티이다.

> ### Conforming Types
* **ForEach**
    - `Data`가 `RandomAccessCollection`, `ID`가 `Hashable`, `Content`가 `View`일 때 `DynamicViewContent`를 준수한다.
    - 일반적으로 `List` 안에서 `ForEach`에 `onDelete`, `onMove` 등을 붙이는 형태로 사용한다.

* **ModifiedContent**
    - `Content`가 `DynamicViewContent`, `Modifier`가 `ViewModifier`일 때 `DynamicViewContent`를 준수한다.
    - modifier가 적용된 뒤에도 기반 동적 데이터의 성격을 유지할 수 있다.

> ### 주요 메서드
* [onDelete(perform:)](./onDelete.md)
    - 동적 View의 요소 삭제 동작을 설정한다.

* [onInsert(of:perform:)](./onInsert.md)
    - `NSItemProvider` 기반 드래그 앤 드롭 삽입 동작을 설정한다.

* [onMove(perform:)](./onMove.md)
    - 동적 View의 요소 이동 동작을 설정한다.

* [dropDestination(for:action:)](./dropDestination.md)
    - `Transferable` 기반 드롭 삽입 동작을 설정한다.

> ### 특징
- `DynamicViewContent` 자체가 데이터를 변경하지는 않는다.
- 삭제, 이동, 삽입 이벤트가 발생하면 SwiftUI가 index 정보를 전달하고, 실제 배열이나 모델 업데이트는 개발자가 클로저 안에서 처리해야 한다.
- index는 화면 전체가 아니라 `DynamicViewContent`의 기반 컬렉션을 기준으로 전달된다.
- `ForEach`를 `List` 안에 넣고 이 프로토콜의 modifier를 붙이면 기본 편집 UI와 연결할 수 있다.

> ### Example
```swift
struct ContentView: View {
    @State private var names = ["Juan", "Mei", "Tom", "Gita"]

    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                Text(name)
            }
            .onDelete { offsets in
                names.remove(atOffsets: offsets)
            }
            .onMove { source, destination in
                names.move(fromOffsets: source, toOffset: destination)
            }
        }
        .toolbar {
            EditButton()
        }
    }
}
```

위 예시는 `ForEach`가 `DynamicViewContent`를 준수하기 때문에 삭제와 이동 이벤트를 연결할 수 있는 구조이다.

> 참고 출처
- [Apple Developer Documentation - DynamicViewContent](https://developer.apple.com/documentation/swiftui/dynamicviewcontent)

