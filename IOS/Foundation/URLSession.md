# URLSession
관련된 네트워크 데이터 전송 작업 그룹을 조정하는 클래스  
URL로 표시된 endpoints에서 데이터를 다운로드하고 업로드하기 위한 API를 제공

> ### Type Property
* **shared**
    - 공유 싱글 톤 세션 객체
***

> ### Instance Method
* **dataTask(with:completionHandler:)**
    - 지정된 URL request 객체를 기반으로 URL 내용을 검색하고, 완료 시 completionHandler을 호출하는 작업을 만듦