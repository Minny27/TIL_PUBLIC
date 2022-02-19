# UIScrollView
포함된 뷰를 **스크롤 및 확대/축소할 수 있는 뷰**  
스크롤 뷰는 **손가락의 움직임을 추적하고 그에 따라 원점(0,0)을 조정**합니다.  
스크롤 뷰를 통해 **기존 컨텐츠 뷰의 손가락의 움직임 만큼 간격을 띄워 새로운 원점에 따라 해당 부분을 그립**니다. 

> ### Instance Property
* **contentOffset**
    - 컨텐츠 뷰의 원점이 스크롤 뷰의 원점에서부터 벌어진 지점
***

> ### Instance Method
* **func setContentOffset(_ contentOffset: CGPoint, animated: Bool)**
    - 수신기의 원점과 일치하는 컨텐츠 뷰의 원점으로부터의 간격띄우기를 설정합니다.