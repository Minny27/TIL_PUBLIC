# String Catalog
String Catalog는 Xcode에서 앱의 사용자 표시 문자열을 모아 번역, 복수형, 기기별 문구 변형을 관리하는 파일이다.
파일 확장자는 `.xcstrings`이고, Xcode 15 이후 문자열 로컬라이징의 권장 방식이다.

기존에는 문자열 번역에 `.strings`, 복수형 처리에 `.stringsdict`를 나누어 사용했지만, String Catalog는 이 작업을 하나의 시각적 편집기에서 관리할 수 있게 한다.

> ### 핵심 역할
- 코드와 인터페이스 파일에서 로컬라이즈 가능한 문자열을 추출한다.
- 언어별 번역 상태를 한 곳에서 확인한다.
- 복수형, 기기별 문구, 폭에 따른 문구 변형을 관리한다.
- 번역가에게 줄 comment를 문자열 단위로 관리한다.
- Xcode가 생성한 localizable symbol을 통해 문자열 key를 코드에서 타입에 가깝게 사용할 수 있다.

> ### String Catalog 추가
Xcode에서 다음 순서로 추가한다.

1. `File` > `New` > `File from Template`
2. 검색창에 `string` 입력
3. `Resource` 아래의 `String Catalog` 선택
4. 기본 이름인 `Localizable`을 사용하거나 필요한 이름으로 변경
5. 프로젝트의 `Resources` 위치에 생성

생성되는 파일은 보통 `Localizable.xcstrings`이다.
카탈로그가 커지면 여러 개의 String Catalog를 만들 수 있고, 이때는 `tableName` 또는 `table` 파라미터로 사용할 카탈로그를 지정한다.

```swift
Text("Explore", tableName: "Navigation")

String(localized: "Gorgeous mountain peaks!", table: "LandmarkCollectionData")
```

> ### 로컬라이즈 가능한 문자열 만들기
SwiftUI의 `Text` 안에 있는 문자열 literal은 기본적으로 로컬라이즈 대상이 된다.

```swift
Text("Title")
```

일반 Swift 문자열은 `String(localized:)`를 사용한다.
오래된 플랫폼을 지원해야 하는 경우에는 `NSLocalizedString`을 사용할 수 있다.

```swift
let title = String(localized: "Add a description for your collection here.")

let legacyTitle = NSLocalizedString(
    "Add a description for your collection here.",
    comment: "Description placeholder shown in the collection editor."
)
```

번역가가 문맥을 알 수 있도록 `comment`를 함께 작성하는 것이 좋다.

```swift
Text("Edit", comment: "Button title for switching to edit mode.")

String(
    localized: "North America",
    comment: "The name of a continent."
)
```

문자열 리소스가 앱의 main bundle이 아닌 Swift Package나 framework에 있으면 `bundle`을 명시한다.

```swift
Text(
    "My Collections",
    bundle: .module,
    comment: "Section title above user-created collections."
)
```

> ### 문자열 추출과 동기화
String Catalog를 만든 뒤 `Product` > `Build`를 실행하면 Xcode가 코드에서 로컬라이즈 가능한 문자열을 찾아 catalog에 추가한다.
이후 코드에서 문구를 수정하거나 새 문자열을 추가했을 때도 build를 다시 실행하면 catalog와 앱 코드가 동기화된다.

catalog에서 특정 key를 선택한 뒤 `Editor` > `Assistant`를 열면 해당 문자열이 코드 어디에서 왔는지 확인할 수 있다.
key 옆에 나타나는 화살표 버튼을 눌러 source editor로 이동할 수도 있다.

> ### 언어 추가와 번역 입력
String Catalog editor에서 언어를 추가하는 방법은 다음과 같다.

1. Project navigator에서 `.xcstrings` 파일 선택
2. editor 하단의 `+` 버튼 클릭
3. 추가할 언어 선택
4. 각 key의 번역 칸에 번역문 입력

번역이 필요한 새 문자열은 `New` 상태로 표시된다.
번역을 입력하면 상태가 checkmark로 바뀌고, sidebar의 언어별 번역률도 함께 갱신된다.

번역을 직접 입력하지 않고 외부 번역가에게 맡길 때는 `Product` > `Export Localizations`로 `.xcloc` 파일을 export하고, 번역 완료 후 import한다.

```bash
xcodebuild -exportLocalizations \
  -project <projectname> \
  -localizationPath <dirpath> \
  -exportLanguage <targetlanguage>
```

Swift 문자열을 빠짐없이 export하려면 project build setting에서 `Use Compiler to Extract Swift Strings`를 켜야 한다.

> ### 복수형 처리
수량에 따라 문구가 달라져야 하면 문자열 보간을 사용하고, catalog에서 해당 key를 `Vary by Plural`로 설정한다.

```swift
Text("\(itemCount) items")
```

String Catalog는 언어별 plural category를 생성한다.
예를 들어 영어는 보통 `One`, `Other` 형태가 필요하고, 러시아어처럼 더 많은 복수형 규칙이 필요한 언어는 `One`, `Few`, `Many`, `Other` 같은 형태가 추가될 수 있다.

번역 예시는 다음처럼 관리된다.

| Plural | Text |
| --- | --- |
| One | `%lld item` |
| Other | `%lld items` |

실행 시점에는 보간된 숫자 값과 현재 locale에 맞는 문구가 선택된다.

> ### 기기별 문구 변형
기기마다 상호작용 방식이나 화면 공간이 달라 문구를 바꿔야 할 때는 `Vary by Device`를 사용한다.

| Device | Text |
| --- | --- |
| iPhone | `Tap to learn more` |
| Mac | `Click to learn more` |

String Catalog에서 key를 선택하고 `Control-click` > `Vary by Device`를 선택한 뒤 필요한 기기별 문구를 입력한다.
앱 실행 시 현재 기기에 맞는 문자열이 표시된다.

> ### Generated Localizable Symbols
String Catalog에 직접 key를 추가하면 Xcode가 Swift symbol을 생성해서 코드에서 사용할 수 있다.
일반 문자열은 static property로 생성되고, format specifier가 있는 문자열은 parameter를 받는 function으로 생성된다.

기본 `Localizable.xcstrings`에 있는 key는 `.title`처럼 접근하고, 별도 catalog에 있는 key는 `.Discover.title`처럼 catalog 이름이 포함된다.

```swift
Text(.Discover.title)

Text(.Discover.subtitle(friendsPosts: 3, curatedPosts: 12))

let title = String(localized: .Discover.title)
```

오래된 프로젝트에서는 build setting의 `Generate String Catalog Symbols`를 `Yes`로 설정해야 할 수 있다.
String Catalog editor의 Attributes inspector에서 생성된 symbol의 예시 사용법을 확인할 수 있다.

> ### 주의할 점
- 사용자에게 보이는 문자열은 가능한 한 `Text`, `String(localized:)`, `NSLocalizedString` 같은 localization API로 감싼다.
- `NSLocalizedString`의 key가 변수이거나 빈 문자열이면 Xcode가 localization export에서 제대로 추출할 수 없다.
- Swift Package나 framework에서는 runtime에 문자열을 찾을 수 있도록 bundle을 정확히 지정한다.
- 문자열을 수정한 뒤에는 build를 실행해서 String Catalog와 source를 다시 동기화한다.
- 번역가가 오해하기 쉬운 짧은 단어에는 반드시 comment를 남긴다.
- 앱 내부 문자열과 App Store Connect의 앱 설명, 부제, What's New 같은 메타데이터 로컬라이징은 별도 관리 대상이다.
- 번역 후에는 scheme의 `Run` > `Options`에서 `App Language`를 바꿔 simulator에서 직접 확인한다.

> 참고 출처
- [Apple Developer Documentation - Localizing and varying text with a string catalog](https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog)
- [Apple Developer Documentation - Localization](https://developer.apple.com/documentation/xcode/localization/)
- [Apple Developer Documentation - Using generated localizable symbols in your code](https://developer.apple.com/documentation/xcode/using-generated-localizable-symbols-in-your-code)
- [Apple Developer Documentation - Exporting localizations](https://developer.apple.com/documentation/xcode/exporting-localizations)
