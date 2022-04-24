# UIResponder
이벤트에 응답하고 처리하기 위한 추상 인터페이스입니다.

> ### Instance Method
* **resignFirstResponder() -> Bool**
    - 윈도우에서 첫 번째 responder로서의 상태를 포기하도록 요청받았음을 해당 객체에게 알립니다.
    - 디폴트 값은 true, 현재 상태를 포기하지 않게 하려면 false를 리턴할 수 있습니다.