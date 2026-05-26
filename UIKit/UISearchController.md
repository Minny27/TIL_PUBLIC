# UISearchController
검색창과의 상호 작용을 기반으로 검색 결과를 관리하는 view controller
검색 컨트롤러는 검색 결과 컨트롤러와 협력하여 검색 결과를 표시합니다.

> ### Initializer
* **init(searchResultsController:)**
    - 결과를 표시하기 위해 지정된 뷰 컨트롤러를 사용하여 검색 컨트롤러를 초기화하고 반환합니다.
***

> ### Instance Property
* **var searchBar: UISearchBar { get })**
    - 검색창은 콘텐츠 검색의 출발점. 검색창과의 상호 작용은 검색 정보가 변경될 때마다 searchResultUpdater 속성에 있는 객체에 알리는 UISearchController 객체에 의해 자동으로 처리됩니다.

* **weak var searchResultsUpdater: UISearchResultsUpdating? { get set }**
    - 검색 결과 컨트롤러의 내용을 업데이트하는 객체입니다.  
    UISearchResultsUpdating 프로토콜을 채택하는 객체를 할당합니다. 해당 프로토콜의 메서드를 사용하여 내용을 검색하고 view controller에 결과를 전송합니다.  