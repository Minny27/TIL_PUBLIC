# UIWindow
앱 화면 배경 및 뷰들의 이벤트를 전달하는 객체
storyboard는 app delegate 객체에 window 프로퍼티가 있어야하며, 
storyboard를 사용하지 않는다면, window를 만들어야만한다.

> ### Instance Property
* **rootViewController**
    - window의 첫 화면
    해당 프로퍼티에 view controller를 할당하면 window의 content view가 해당 view controller로 설치된다.
***

> ### Instance Method
* **makeKeyAndVisible()**
    - window를 화면에 렌더링하는 함수