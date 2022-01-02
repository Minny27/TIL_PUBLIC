# NotificationCenter
등록된 관찰자에게 정보를 브로드캐스트할 수 있는 알림 발송 메커니즘 클래스  
객체는 notification center에 등록하여 addObserver 메서드를 사용하여 알림(NSNotification 객체)을 받습니다.  
객체가 자신을 observer로 추가할 때 수신해야 할 알림을 지정합니다.  
따라서 객체는 여러 다른 알림에 대해 자신을 observer로 등록하기 위해 이 메소드를 여러 번 호출할 수 있습니다.  
실행 중인 각 앱에는 default notification center가 있으며, 새 notification center를 만들어 특정 컨텍스트의 통신을 구성할 수 있습니다.  
notification center는 단일 프로그램 내에서만 notification을 전송할 수 있습니다. 

> ### Type Property
* **class var default: NotificationCenter { get }**
    - 앱으로 전송되는 모든 시스템 알림은 기본 default notification center에 post됩니다. 또한 자신의 알림을 post할 수도 있습니다.  
    앱에서 알림을 광범위하게 사용하는 경우 default notification center에만 post하지 않고 자신의 notification center를 만들어 post할 수 있습니다.  
    notification center에 알림이 post되면 notification center는 등록된 observser 목록을 검색하므로 앱 속도가 느려질 수 있습니다.  
    알림을 하나 이상의 notification center를 중심으로 기능적으로 구성하면 알림이 post될 때마다 작업이 덜 수행되므로 앱 전체의 성능이 향상될 수 있습니다.
***

> ### Instance Method
* **func addObserver(_:selector:name:object:)**
    - notification center에 알림과 함께 selector을 호출할 entry를 추가합니다.

* **post(name:object:userInfo:)**
    - 알림 이름, posting할 객체, 보낼 정보 등을 담는 알림을 생성하고 알림을 notification center에 post합니다.