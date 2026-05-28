# ignoresSafeArea(_:edges:)
View가 SwiftUI의 safe area 제한을 무시하고 지정한 영역까지 확장되도록 하는 modifier
상태바, 홈 인디케이터, 탭 바, 키보드 같은 시스템 영역을 피해서 배치되는 기본 동작을 일부 또는 전체 edge에서 변경할 때 사용한다.

> ### Declaration
```swift
nonisolated
func ignoresSafeArea(
    _ regions: SafeAreaRegions = .all,
    edges: Edge.Set = .all
) -> some View
```

> ### 지원 플랫폼
- iOS 14.0+
- iPadOS 14.0+
- Mac Catalyst 14.0+
- macOS 11.0+
- tvOS 14.0+
- watchOS 7.0+

> ### Parameters
* **regions**
    - View가 확장될 safe area 영역의 종류
    - 기본값은 `.all`이다.
    - `.container`: 기기 가장자리나 navigation bar, tab bar 같은 컨테이너가 만드는 safe area
    - `.keyboard`: 화면 위에 표시된 소프트웨어 키보드가 만드는 safe area
    - `.all`: 모든 safe area 영역

* **edges**
    - safe area를 무시할 edge 집합
    - 기본값은 `.all`이다.
    - `.top`, `.bottom`, `.leading`, `.trailing`, `.horizontal`, `.vertical`, `.all` 등을 사용할 수 있다.
    - 포함하지 않은 edge의 safe area는 기존 동작을 유지한다.

> ### Return Value
- safe area가 확장된 View

> ### 특징
- SwiftUI는 기본적으로 시스템 UI나 기기 가장자리에 View가 가려지지 않도록 safe area 안에 배치한다.
- `ignoresSafeArea`를 적용하면 지정한 safe area 영역까지 View가 확장된다.
- 전체 화면 배경 색상이나 배경 이미지를 만들 때 자주 사용한다.
- 조작 가능한 버튼, 입력창, 리스트 콘텐츠에 무작정 적용하면 홈 인디케이터, 탭 바, 키보드 등에 가려질 수 있다.
- 보통 배경 View에만 적용하고, 실제 콘텐츠는 safe area 안에 남겨두는 방식이 안전하다.
- 기존 `edgesIgnoringSafeArea(_:)`보다 새 API이며, `regions`로 키보드 safe area까지 구분할 수 있다.

> ### Example
```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Title")
                    .font(.title)
                    .foregroundStyle(.white)

                Text("Content stays inside the safe area.")
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding()
        }
    }
}
```

위 예시는 배경인 `Color.black`만 safe area 밖까지 확장하고, 실제 텍스트 콘텐츠는 `ZStack`의 기본 layout에 따라 safe area 안에 배치한다.

> ### Edge 제한 Example
```swift
VStack {
    Text("Top background extends behind the status bar.")
        .frame(maxWidth: .infinity)
        .padding()
        .background(.blue)
        .ignoresSafeArea(edges: .top)

    Spacer()
}
```

위 예시는 위쪽 edge만 safe area를 무시한다. 아래쪽 safe area는 유지되므로 홈 인디케이터 영역까지 확장되지 않는다.

> 참고 출처
- [Apple Developer Documentation - ignoresSafeArea(_:edges:)](https://developer.apple.com/documentation/swiftui/view/ignoressafearea(_:edges:))
