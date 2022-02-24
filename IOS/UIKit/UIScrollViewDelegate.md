# UIScrollViewDelegate
UIScrolViewDelegate 프로토콜에서 선언된 메서드를 통해 위임자를 채택하는 것이 UIScrolView 클래스의 메시지에 응답할 수 있도록 합니다. 스크롤, 줌, 스크롤 콘텐츠 감속 및 스크롤 애니메이션과 같은 작업에 응답하고 일부 영향을 미칠 수 있습니다.

<br>

> ### Declaration
```swift
    @MainActor protocol UIScrollViewDelegate
```
***

> ### Instance Method
* **scrollViewDidScroll(_:)**
    - 사용자가 수신기 내에서 content view를 **스크롤할 때 위임자에게 알려줍니다.**

* **scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)**
    - 사용자가 내용을 **스크롤한 후 위임자에게 알립니다.**

