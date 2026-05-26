# UINavigationController
계층적으로 view controller를 탐색하기 위한 스택 기반의 컨테이너 view controller  
navigation interface 기반으로 하나 이상의 자식 view controller를 관리하는 컨테이너 view controller  
하나의 자식 view controller만 볼 수 있습니다.  
새로운 view controller를 push하게 되면 애니메이션이 적용되고 이전 view controller가 숨겨집니다.  
back버튼 클릭 시, 현재 view controller를 제거되고 이전 view controller가 나타납니다.

> ### Instance Property
* **var isToolbarHidden: Bool**
    - toolbar를 보일지 말지 결정하는 불 값
    default 값은 true

* **var isNavigationBarHidden: Bool**
    - navigationbar를 보일지 말지 결정하는 불 값
    default 값은 false
***

> ### Initializer
* **init(rootViewController: UIViewController)**
    - 생성자 메서드
***

> ### Instance Method
* **pushViewController(_ viewController: UIViewController, animated: Bool)**
    - navigation stack의 top으로 밀어주어 새로운 view controller를 화면에 띄웁니다.
    ```swift
    if let controller = self.storyboard?.instantiateViewController(withIdentifier : "DetailController") {
    self.navigationController?.pushViewController(controller, animated: true)
    }
    ```

* **func popViewController(animated: Bool) -> UIViewController?**
    - navigation stack의 top view controller를 없애고 다음 view controller를 화면에 띄웁니다.
