# Git

> ### Git
- **소스 파일의 버전 관리를 위한 소프트웨어**
- 여러 명의 사용자들이 작업하는 소스 파일 관리를 위한 위한 분산 버전 관리 시스템.

<br>

> ### GitHub
- Git으로 저장한 데이터를 원격 전송으로 저장되도록 공간을 제공하는 서비스.

<br>

<p align = "center">
    전체 과정
    <br>
    <img src = "https://s3-ap-northeast-2.amazonaws.com/opentutorials-user-file/module/3963/10395.png" width = "450" height = "300">
    <br>
    출처: <a href = "https://www.opentutorials.org/module/3963/24425">opentutorials.org</a>
</p>

<br>


> ### 관련 용어
* **저장소(Repository)**  
소스코드가 저장되어 있는 여러 개의 브랜치(Branch)들이 모여 있는 디스크상의 물리적 공간을 의미한다.  
저장소는 로컬 저장소(Local Repository)와 원격 저장소(Remote Repository)로 나뉜다.  
원격 저장소에 저장하는 전체 과정은 원격 저장소의 소스코드 복사해서 가져오기(clone) -> 변경된 소스 변경 후 commit -> push

<br>

* **로컬 저장소(Local Repository)**  
내 PC에 파일이 저장되는 개인 전용 저장소.

<br>

* **원격 저장소(Remote Repository)**  
파일이 원격 저장소 전용 서버에서 관리되며 여러 사람이 함께 공유하기 위한 저장소.

<br>

* **Checkout**  
특정 시점이나 브랜치의 소스코드로 이동하는 것. 체크아웃 대상은 브랜치, 커밋, 태그.

<br>

* **Stage**  
작업한 내용이 올라가는 임시 저장 영역.

<br>

* **Add**  
작업 내용을 스테이지에 올리는 과정.

<br>

* **Commit**  
작업한 내용을 로컬 저장소에 저장하는 과정.

<br>

* **Push**  
로컬 저장소의 내용 중 원격 저장소에 반영되지 않은 커밋을 원격 저장소로 보내는 과정.

<br>

* **Pull**  
원격 저장소에 있는 내용 중 로컬 저장소에 반영되지 않은 내용을 가져와서(Fetch) 로컬 저장소에 병합(merge)하는 과정.  
Push를 하기전에 항상 Pull을 먼저 해야 충돌이 발생하지 않을 수 있다.

<br>

* **Fetch**  
원격 저장소의 내용을 확인만 하고 로컬 데이터와 병합은 하고 싶지 않은 경우, 병합은 하지 않고 원격 저장소의 내용을 가져오는 과정

<br>

* **Merge**  
브랜치와 반대되는 개념으로, 하나의 브랜치를 다른 브랜치와 합치는 과정을 의미합니다.(주종 관계 존재)  
병합 과정에서 두 개의 브랜치에서 파일의 같은 부분을 서로 다른게 수정한 경우 충돌(Collision)이 발생하며, 병합이 일시정지됨.


<br>

* **Branch**  
브랜치란 독립적으로 어떤 작업을 진행하기 위한 개념.  
각각의 브랜치는 다른 브랜치의 영향을 받지 않기 때문에, 여러 작업을 동시에 진행할 수 있다.  
브랜치는 다른 브랜치와 병합(Merge)함으로써, 작업한 내용을 다시 새로운 하나의 브랜치로 모을 수 있다.

<br>

* **Fork**  
다른 사람의 Github repository를 자신의 Github repository로 그대로 복제하는 과정.

<br>

* **Tag**  
커밋의 임의 위치에 쉽게 찾아갈 수 있도록 붙여놓은 이정표를 태그라고 한다. 태그가 붙여진 커밋은 Commit ID 대신 태그명을 입력하여 쉽게 체크아웃 할 수 있다.

<br>
<br>

> ### 자주 사용하는 명령어
* **git clone [url]**
    - 원격 저장소를 로컬 저장소에 복제

    <br>

* **git add [파일명]**
    - 변경된 파일 스테이징

    <br>
    
* **git add .**
    - 변경된 모든 파일 스테이징

    <br>
    
* **git commit -m ["메시지"]** 
    - 커밋

    <br>
    
* **git push**
    - 푸시

    <br>
    
* **git push - u**
    - 풀 후 푸시

    <br>
    
* **git push [리모트 저장소 이름] [브랜치 이름]**
    - 해당 저장소의 브랜치 푸시

    <br>
    
* **git push -f**
    - 강제 푸시

    <br>
    
* **git status**
    - 깃 상태 확인

    <br>
    
* **git rm [파일명]**
    - 파일 삭제

    <br>

* **git restore --staged [파일명]**
    - 파일 Unstage 상태로 변경

    <br>

* **git rm --cached [파일명]**
    - 파일 Unstage 상태로 변경

    <br>
    
* **git reset HEAD [파일명]**
    - 파일 Unstage 상태로 변경

    <br>
    
* **git pull**
    - 원격저장소에 변경된 사항을 가져오고 병합하기

    <br>
    
* **git log**
    - 커밋 내역 보기

    <br>
    
* **git commit --amend**
    - 마지막 커밋 메시지 수정

    <br>
    
* **git reset --hard 커밋 해시값**
    - 해당 커밋 당시로 롤백

<br>
<br>

> 참고 출처
- [webclub](https://webclub.tistory.com/132?category=546363)
- [backlog](https://backlog.com/git-tutorial/kr/stepup/stepup1_1.html)
- [imacoolgirlyo](https://velog.io/@imacoolgirlyo/Git-fork%EC%99%80-clone-%EC%9D%98-%EC%B0%A8%EC%9D%B4%EC%A0%90-5sjuhwfzgp)
- [얄팍한코딩사전](https://www.youtube.com/watch?v=Bd35Ze7-dIw)
- 위키백과