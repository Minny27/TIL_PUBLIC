# 교착상태(DeadLock)
**두 개 이상의 프로세스가 서로의 작업이 끝나기만을 기다리고 있어 둘 다 영원히 끝나지 않는 상황을 가리킵니다.**

<br>

프로세스 1과 프로세스2가 모두 자원 1, 자원 2를 얻어야 한다고 가정해보겠습니다.

<img src="https://user-images.githubusercontent.com/33534771/87002992-c4230880-c1f5-11ea-8e0e-0bddc09e3f4a.png" width=60%>

task1 : 프로세스 1이 자원 1을 얻음 / 프로세스 2가 자원 2를 얻음
task2 : 프로세스 1은 자원 2를 기다림 / 프로세스 2는 자원 1을 기다림
이처럼 각각의 프로세스가 원하는 리소스가 서로에게 할당되어 있어서 두 프로세스는 무한정 wait 상태에 빠지게 되고 이러한 상황을 DeadLock 이라고 부릅니다.

<br>

> ### DeadLock을 발생시키는 4가지 필요조건
아래 4가지 조건이 모두 만족되는 경우 데드락이 발생할 가능성이 있고, 하나라도 만족하지 않으면 절대 발생하지 않습니다.
1. 상호 배제(Mutual exclusion)
    - 한 리소스는 한 번에 한 프로세스만이 사용할 수 있음
2. 점유와 대기(Hold and wait)
    - 어떤 프로세스가 하나 이상의 리소스를 점유하고 있으면서 다른 프로세스가 가지고 있는 리소스를 기다리고 있음
3. 비선점(No preemption)
    - 프로세스가 태스크를 마친 후 리소스를 자발적으로 반환할 때까지 기다림 (강제로 빼앗지 않음)
4. 환형 대기(Circular wait)
    - Hold and wait 관계의 프로세스들이 서로를 기다림

> ### DeadLock 예방 방법
사전에 교착상태가 발생하지 않도록 조치하거나, 발생한 뒤에 고치는 방법이 있습니다. 대표적으로 아래 세가지로 나뉩니다.
1. 방지(Prevention)
    - 할당 구조 측면에서, 교착상태가 발생할 수 있는 요구조건을 만족시키지 않게 함으로써 교착상태를 방지함
2. 회피(Avoidance)
    - 리소스 할당의 측면에서, 교착상태가 발생할 가능성이 있는 자원 할당(unsafe allocation)을 하지 않음
    - 예시: 은행원 알고리즘, 자원 할당 그래프
3. 탐지 및 회복(Detection and Recovery)
    - 교착상태가 발생 할 수 있도록 놔 두고 교착상태가 발생 할 경우 찾아내어 고침

<br>

> 참고 출처
- [itwiki](https://itwiki.kr/w/%EA%B5%90%EC%B0%A9%EC%83%81%ED%83%9C)
- [WooVictory](https://github.com/WooVictory/Ready-For-Tech-Interview/blob/master/Operating%20System/%EA%B5%90%EC%B0%A9%EC%83%81%ED%83%9C(DeadLock).md)
- [jwprogramming](https://jwprogramming.tistory.com/12)