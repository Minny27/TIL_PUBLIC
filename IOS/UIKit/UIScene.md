# UIScene
앱의 UI 하나를 나타내는 객체  
UIScene 객체 대신 UIWindowScene 객체를 생성하지만, 이 클래스의 메서드와 속성을 사용하여 scene 정보에 접근할 수 있습니다.  
모든 scene 객체에는 UIsceneDelegate 프로토콜을 채택하는 delegate 객체를 가집니다. scene의 상태가 변경되면 delegate에게 알리고 등록된 observer 객체에 적절한 알림을 보냅니다.