# Activity
사용자가 액티비티내에서 수행할 수 있는 작업을 처리하는 클래스

> ### Methods
* **protected void onCreate (Bundle savedInstanceState)**
    - 앱이 시작되고 바로 실행되는 함수, 화면을 채우기 위해서 setContentView()함수를 호출.

* **public void setContentView (int layoutResID)**
    - 해당 액티비티(화면)과 연결될 layout(xml)을 설정. 해당 레이아웃을 띄운다.

* **public void startActivity (Intent intent, Bundle options)**
    - 새로운 액티비티를 실행

* **protected void onDestroy ()**
    - 액티비티를 나갔다가 다시 들어올 때 이전의 입력했던 값을 save하고 싶을 떄 사용하는 함수