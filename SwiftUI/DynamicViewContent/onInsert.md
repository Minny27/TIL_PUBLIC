# onInsert(of:perform:)
동적 View에 요소를 삽입하는 동작을 설정하는 modifier  
드래그 앤 드롭으로 들어온 `NSItemProvider` 데이터를 받아, 지정된 위치에 새 요소를 추가할 때 사용한다.

> ### Declaration
```swift
nonisolated
func onInsert(
    of supportedContentTypes: [UTType],
    perform action: @escaping (Int, [NSItemProvider]) -> Void
) -> some DynamicViewContent
```

> ### 지원 플랫폼
- iOS 14.0+
- iPadOS 14.0+
- Mac Catalyst 14.0+
- macOS 11.0+
- tvOS 14.0+
- visionOS 1.0+
- watchOS 7.0+

> ### Parameters
* **supportedContentTypes**
    - 동적 View가 받을 수 있는 UTI 타입 배열
    - `UTType.plainText`, `UTType.image`처럼 `UniformTypeIdentifiers`의 타입을 지정한다.

* **action**
    - 요소가 추가될 때 SwiftUI가 호출하는 클로저
    - 첫 번째 인자 `Int`는 삽입 위치 offset이다.
    - 두 번째 인자 `[NSItemProvider]`는 삽입할 데이터를 담은 item provider 목록이다.
    - offset은 동적 View의 기반 데이터 컬렉션을 기준으로 한다.

> ### Return Value
- 원래 View에 요소가 삽입될 때 `action`을 호출하는 `DynamicViewContent`

> ### 특징
- `onInsert`는 `NSItemProvider`를 직접 처리하는 방식이다.
- `NSItemProvider`에서 원하는 타입의 값을 비동기로 로드한 뒤, 실제 데이터 컬렉션에 삽입해야 한다.
- 최신 코드에서는 모델이 `Transferable`을 준수할 수 있다면 [dropDestination(for:action:)](./dropDestination.md)이 더 단순하다.
- 기존 `String` 타입 식별자 기반 `onInsert(of: [String], perform:)` 선언은 deprecated 되었고, `UTType` 기반 선언을 사용한다.

> ### Example
```swift
import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var names = ["Juan", "Mei", "Tom"]

    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                Text(name)
            }
            .onInsert(of: [.plainText]) { offset, providers in
                insertTextItems(at: offset, from: providers)
            }
        }
    }

    private func insertTextItems(at offset: Int, from providers: [NSItemProvider]) {
        for provider in providers where provider.canLoadObject(ofClass: NSString.self) {
            provider.loadObject(ofClass: NSString.self) { object, _ in
                guard let text = object as? String else { return }

                Task { @MainActor in
                    names.insert(text, at: min(offset, names.endIndex))
                }
            }
        }
    }
}
```

위 예시는 plain text 드롭을 받아 문자열로 로드한 뒤 `names` 배열에 삽입한다.

> 참고 출처
- [Apple Developer Documentation - onInsert(of:perform:)](https://developer.apple.com/documentation/swiftui/dynamicviewcontent/oninsert(of:perform:)-418bq)

