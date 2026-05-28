# TabView
여러 child view 중 하나를 선택해서 보여주는 SwiftUI 컨테이너
iOS에서는 일반적으로 하단 탭 바로 표시되고, 플랫폼과 style에 따라 page, sidebar, ornament 같은 형태로 표현될 수 있다.

> ### Declaration
```swift
struct TabView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View
```

> ### 지원 플랫폼
- iOS 13.0+
- iPadOS 13.0+
- Mac Catalyst 13.0+
- macOS 10.15+
- tvOS 13.0+
- watchOS 7.0+

> ### 주요 Initializer
```swift
init(content: () -> Content)
```

```swift
init(
    selection: Binding<SelectionValue>,
    content: () -> Content
)
```

> ### 구성 요소
* **Content**
    - `TabView` 안에서 전환되는 실제 화면들
    - 각 탭은 독립적인 child view를 가진다.

* **SelectionValue**
    - 선택된 탭을 식별하는 값
    - `selection`을 사용할 때 각 탭의 값과 같은 타입이어야 하고, `Hashable`을 준수해야 한다.

* **selection**
    - 현재 선택된 탭을 외부 상태와 연결하는 binding
    - 사용자가 탭을 선택하면 binding 값이 갱신되고, 코드에서 binding 값을 바꾸면 선택 탭도 바뀐다.

> ### 특징
- 앱의 주요 화면을 탭 단위로 나눌 때 사용한다.
- `selection` 없이 선언하면 SwiftUI가 탭 선택 상태를 내부적으로 관리한다.
- `selection`을 사용하면 특정 탭으로 프로그래밍 방식 전환이 가능하다.
- 최신 SwiftUI에서는 `Tab`을 `TabView` 안에 배치하는 방식을 사용할 수 있다.
- iOS 17 이하를 지원하는 코드에서는 `.tabItem`과 `.tag` 조합이 일반적이다.
- `.tabViewStyle(.page)`를 적용하면 탭 바 대신 좌우로 넘기는 page UI로 사용할 수 있다.
- iOS에서는 `badge(_:)`로 탭에 숫자나 문자열 badge를 표시할 수 있다.

> ### 최신 Tab API Example
```swift
enum AppTab: Hashable {
    case home
    case search
    case settings
}

struct ContentView: View {
    @State private var selection: AppTab = .home

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: .home) {
                HomeView()
            }

            Tab("Search", systemImage: "magnifyingglass", value: .search) {
                SearchView()
            }

            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
            }
        }
    }
}
```

위 예시는 `selection`과 각 `Tab`의 `value`를 연결해 현재 선택된 탭을 상태로 관리한다.
`Tab` 기반 API는 iOS 18.0+, macOS 15.0+, tvOS 18.0+, watchOS 11.0+, visionOS 2.0+ 환경에서 사용할 수 있다.

> ### 기존 tabItem 방식 Example
```swift
enum AppTab: Hashable {
    case home
    case search
    case settings
}

struct ContentView: View {
    @State private var selection: AppTab = .home

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(AppTab.home)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(AppTab.search)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(AppTab.settings)
        }
    }
}
```

위 방식은 `Tab` API를 쓰지 않고도 `selection`을 연결할 수 있다.
`tag` 값은 `selection`과 같은 타입이어야 하며, 각 탭마다 고유해야 한다.

> ### Page Style Example
```swift
struct OnboardingView: View {
    private let pages = ["Welcome", "Search", "Save"]

    var body: some View {
        TabView {
            ForEach(pages, id: \.self) { title in
                Text(title)
                    .font(.largeTitle)
            }
        }
        .tabViewStyle(.page)
    }
}
```

위 예시는 `TabView`를 페이지 컨테이너처럼 사용한다. 온보딩이나 이미지 캐러셀처럼 순차적으로 넘기는 UI에 적합하다.

> ### ignoresSafeArea와 함께 사용할 때
```swift
ZStack {
    Color(.systemBackground)
        .ignoresSafeArea()

    TabView {
        HomeView()
            .tabItem {
                Label("Home", systemImage: "house")
            }

        SettingsView()
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
    }
}
```

배경만 `ignoresSafeArea()`로 확장하고, `TabView` 자체는 safe area 처리를 SwiftUI에 맡기는 편이 안정적이다.

> 참고 출처
- [Apple Developer Documentation - TabView](https://developer.apple.com/documentation/SwiftUI/TabView)
