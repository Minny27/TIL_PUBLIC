# HistoryObserver

`HistoryObserver`는 SwiftData의 `ModelContainer`에 연결된 data store에서 remote change가 발생했는지 관찰하는 class이다.
관심 있는 history transaction이 들어오면 `eventCounter`를 증가시켜 SwiftUI view나 다른 observer가 변경을 감지할 수 있게 한다.

> 문서 기준: iOS 27.0, iPadOS 27.0, macOS 27.0, tvOS 27.0, visionOS 27.0, watchOS 27.0 beta

## 선언

```swift
final class HistoryObserver
```

`HistoryObserver`는 `Observable`을 준수한다.
따라서 SwiftUI view에서 `eventCounter`를 읽으면 관련 변경 발생 시 view가 갱신될 수 있다.

## 역할

`HistoryObserver`는 `ModelContainer/remoteChange` notification을 자동으로 듣는다.
그리고 초기화 시 지정한 모델과 author 조건을 기준으로 incoming change가 관심 대상인지 판단한다.
관심 있는 변경이면 `eventCounter` 값을 증가시킨다.

이 class가 직접 변경된 모델 목록을 UI에 제공하는 것은 아니다.
역할은 "새로운 관련 history transaction이 있다"는 신호를 observable state로 전달하는 것이다.
실제 변경 내용이 필요하면 history token 이후의 transaction을 fetch해서 처리해야 한다.

## history token

observer는 각 data store의 transaction history에서 어디까지 처리했는지 `historyTokens`로 추적한다.
이 token을 사용하면 매번 전체 history를 다시 확인하지 않고, 마지막 확인 이후에 추가된 transaction만 점진적으로 처리할 수 있다.

초기화 parameter의 형태는 다음과 같다.

```swift
historyTokens: [String: any HistoryToken]?
```

key는 store를 식별하는 문자열이고, value는 해당 store의 마지막 history token으로 이해하면 된다.

## observedModels

`observedModels`는 어떤 모델 타입의 변경을 관심 대상으로 볼지 정한다.

```swift
let observer = try HistoryObserver(
    observedModels: [Trip.self],
    modelContainer: container
)
```

비어 있지 않은 배열을 전달하면 해당 모델 타입의 변경이 포함된 transaction만 관련 변경으로 본다.
배열이 비어 있으면 container 안의 모든 history change에 반응한다.

## authors

`authors`는 transaction author를 기준으로 history transaction을 필터링할 때 사용한다.
여러 context, app extension, background process가 같은 store를 공유할 때 변경 주체를 구분하는 데 도움이 된다.

```swift
let observer = try HistoryObserver(
    observedModels: [Trip.self],
    authors: ["WidgetExtension"],
    modelContainer: container
)
```

특정 author만 보고 싶을 때는 set에 author 이름을 넣고, 모든 author를 보고 싶다면 기본 동작을 사용한다.

## 주요 property

| Property | 의미 |
| --- | --- |
| `eventCounter` | 관련 변경이 감지될 때마다 증가하는 counter |
| `modelContainer` | observer가 감시하는 `ModelContainer` |
| `observedModels` | history transaction을 평가할 때 기준으로 삼는 모델 타입 배열 |
| `authors` | history transaction을 평가할 때 기준으로 삼는 author set |

`eventCounter`는 변경 발생 여부를 알리는 값이다.
카운터 값 자체가 도메인 상태는 아니므로, 값이 바뀌면 필요한 fetch 또는 history 처리 로직을 다시 실행하는 방식으로 사용하는 것이 자연스럽다.

## ResultsObserver와의 차이

`ResultsObserver`는 fetch 조건에 맞는 현재 모델 collection을 유지한다.
목록 UI와 같이 "현재 결과"가 필요한 곳에 적합하다.

`HistoryObserver`는 data store history에 새 transaction이 생겼는지 알려준다.
다른 process, app extension, CloudKit sync 등 외부 변경을 감지하고 후속 처리를 시작해야 하는 곳에 적합하다.

정리하면 다음과 같다.

| 구분 | ResultsObserver | HistoryObserver |
| --- | --- | --- |
| 관찰 대상 | fetch 결과 collection | store history transaction |
| 주요 값 | `results`, `sections` | `eventCounter` |
| 사용 목적 | UI 목록을 최신 상태로 유지 | 외부 변경 감지 후 후속 처리 |
| 기준 | `ModelContext` 또는 `ModelContainer` | `ModelContainer` |

## 사용 흐름

1. 어떤 container의 변경을 볼지 정한다.
2. 필요한 경우 `observedModels`로 관심 모델을 제한한다.
3. 필요한 경우 `authors`로 변경 주체를 제한한다.
4. `eventCounter` 변화를 관찰한다.
5. counter가 바뀌면 history token 이후의 transaction을 fetch하거나 관련 데이터를 다시 조회한다.

## 주의할 점

- `HistoryObserver`는 변경 내용을 직접 반환하지 않는다. 변경 발생 신호를 받은 뒤 별도 fetch가 필요하다.
- `observedModels`가 비어 있으면 모든 history change에 반응하므로, 변경이 잦은 store에서는 너무 넓은 관찰이 될 수 있다.
- token을 저장하지 않으면 앱 재실행 후 어디까지 처리했는지 잃을 수 있다.
- app extension이나 CloudKit sync와 함께 쓰려면 store 공유, App Group, container 설정이 먼저 맞아야 한다.
- 문서 기준으로 beta API이므로 실제 프로젝트 도입 전 target OS와 Xcode 버전을 확인해야 한다.

## 참고 출처

- [Apple Developer Documentation - HistoryObserver](https://developer.apple.com/documentation/swiftdata/historyobserver)
- [Apple Developer Documentation - ResultsObserver](https://developer.apple.com/documentation/swiftdata/resultsobserver)
- [Apple Developer Documentation - ModelContainer](https://developer.apple.com/documentation/swiftdata/modelcontainer)
