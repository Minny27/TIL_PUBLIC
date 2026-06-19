# stroke, strokeBorder
SwiftUI에서 `Shape`의 외곽선을 그릴 때 사용하는 메서드입니다.
둘 다 선을 그리는 역할을 하지만, 선이 기준 path를 중심으로 그려지는지, shape의 안쪽으로만 그려지는지가 다릅니다.

> ### 핵심 차이
| 구분 | stroke | strokeBorder |
| --- | --- | --- |
| 적용 대상 | `Shape` | `InsettableShape` |
| 선 위치 | path를 중심으로 안쪽과 바깥쪽에 걸쳐 그려짐 | shape의 경계 안쪽으로만 그려짐 |
| layout 영향 | View의 layout 크기를 직접 바꾸지 않음 | View의 layout 크기를 직접 바꾸지 않음 |
| clipping 위험 | 굵은 선이 바깥쪽으로 나가 잘릴 수 있음 | 선 전체가 안쪽에 들어와 잘릴 가능성이 낮음 |
| 주 용도 | shape path 자체를 따라 선을 그림 | 버튼, 카드, 원형 이미지 등의 내부 border |

> ### 대표 Declaration
```swift
func stroke(style: StrokeStyle) -> some Shape

func stroke(lineWidth: CGFloat = 1) -> some Shape

func stroke<S>(
    _ content: S,
    style: StrokeStyle
) -> some View where S: ShapeStyle

func stroke<S>(
    _ content: S,
    lineWidth: CGFloat = 1
) -> some View where S: ShapeStyle
```

```swift
func strokeBorder(
    style: StrokeStyle,
    antialiased: Bool = true
) -> some View

func strokeBorder(
    lineWidth: CGFloat = 1,
    antialiased: Bool = true
) -> some View

func strokeBorder<S>(
    _ content: S,
    style: StrokeStyle,
    antialiased: Bool = true
) -> some View where S: ShapeStyle

func strokeBorder<S>(
    _ content: S,
    lineWidth: CGFloat = 1,
    antialiased: Bool = true
) -> some View where S: ShapeStyle
```

> ### stroke
- 모든 `Shape`에서 사용할 수 있습니다.
- shape의 path를 기준선으로 삼고, stroke 두께의 절반은 안쪽, 절반은 바깥쪽에 그려집니다.
- 예를 들어 `lineWidth`가 `20`이면 path 안쪽으로 `10`, 바깥쪽으로 `10`이 그려지는 방식입니다.
- View의 frame 자체가 커지는 것은 아니기 때문에, 바깥쪽으로 나간 stroke가 부모 View나 clipping 조건에 의해 잘릴 수 있습니다.
- 선이 shape의 실제 경계선을 중심으로 지나가야 할 때 적합합니다.

> ### strokeBorder
- `InsettableShape`에서만 사용할 수 있습니다.
- `Circle`, `Ellipse`, `Capsule`, `Rectangle`, `RoundedRectangle` 등 기본 shape 대부분은 `InsettableShape`를 준수합니다.
- stroke가 원래 shape의 경계 바깥으로 나가지 않도록 안쪽으로 inset된 path에 그려집니다.
- 외부 크기를 유지하면서 안쪽 border를 그리고 싶을 때 적합합니다.
- `antialiased` 파라미터로 경계선 antialiasing 적용 여부를 정할 수 있습니다.

> ### Example: stroke
```swift
Circle()
    .stroke(.blue, lineWidth: 20)
    .frame(width: 100, height: 100)
```

위 예시는 `Circle`의 경계 path를 중심으로 20pt 선을 그립니다.
선의 절반은 원 안쪽에, 절반은 원 바깥쪽에 위치합니다.

> ### Example: strokeBorder
```swift
Circle()
    .strokeBorder(.blue, lineWidth: 20)
    .frame(width: 100, height: 100)
```

위 예시는 20pt 선 전체를 `Circle`의 경계 안쪽에 그립니다.
같은 frame 안에서 border가 잘리지 않아야 하는 UI에는 `strokeBorder`가 더 안정적입니다.

> ### fill과 함께 사용하기
```swift
RoundedRectangle(cornerRadius: 12)
    .fill(.white)
    .overlay {
        RoundedRectangle(cornerRadius: 12)
            .strokeBorder(.gray.opacity(0.4), lineWidth: 1)
    }
```

shape에 배경색을 채우고 border만 추가하고 싶다면 `fill` 뒤에 `overlay`로 같은 shape를 올리는 방식이 일반적입니다.
이때 border가 View 안쪽에 들어와야 하므로 `strokeBorder`를 사용하면 모서리와 frame 기준을 유지하기 쉽습니다.

> ### 사용 기준
- 단순히 shape의 외곽선을 표시하고 선 두께가 얇다면 `stroke`도 충분합니다.
- 카드, 버튼, 썸네일처럼 지정된 frame 안에 border가 들어와야 하면 `strokeBorder`가 더 적합합니다.
- 커스텀 `Shape`에서 `strokeBorder`를 쓰려면 해당 shape가 `InsettableShape`를 준수하고 `inset(by:)`를 구현해야 합니다.
- `Shape`가 `InsettableShape`를 준수하지 않는다면 `stroke`를 사용해야 합니다.

> ### 정리
- `stroke`는 path 중심에 선을 그립니다.
- `strokeBorder`는 shape 안쪽에 선을 그립니다.
- UI border 용도라면 보통 `strokeBorder`가 더 예측 가능합니다.
- path 자체를 강조하거나 모든 `Shape`에 적용해야 한다면 `stroke`를 사용합니다.

> 참고 출처
- [Apple Developer Documentation - stroke(lineWidth:)](https://developer.apple.com/documentation/swiftui/shape/stroke(linewidth:))
- [Apple Developer Documentation - strokeBorder(lineWidth:antialiased:)](https://developer.apple.com/documentation/swiftui/insettableshape/strokeborder(linewidth:antialiased:))
