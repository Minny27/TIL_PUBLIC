# Context Switching
**CPU는 한번에 하나의 프로세스만 처리할 수 있는데, 멀티 프로세스 환경에서 현재 실행중인 Task(프로세스, 스레드)의 상태를 PCB에 저장하고 다음에 실행할 Task의 상태값을 읽어 교체하는 작업을 말합니다.**

<br>

> ### Context Switching 과정
- Task의 대부분 정보는 Register에 저장되고 PCB로 관리됩니다.
- 현재 실행하고 있는 Task의 PCB 정보를 저장합니다.
- 다음 실행할 Task의 PCB 정보를 읽어 Register에 적재하고 CPU가 이전에 진행했던 과정을 연속적으로 수행할 수 있습니다.

<br>

> ### Context Switching이 많은 비용을 소모하는 이유
- Cache 초기화
- Memory mapping 초기화
- 커널은 항상 실행되어야 함

<br>

> ### 프로세스가 스레드보다 Context Switching의 비용이 더 드는 이유
- 스레드는 **Stack 영역을 제외한 모든 메모리를 공유**하기 때문에 Context Switching 발생시 Stack 영역만 변경을 진행하면 되기 때문

<br>

> 참고 출처
- [WooVictory](https://github.com/WooVictory/Ready-For-Tech-Interview/blob/master/Operating%20System/Context%20Switching.md)
- [jeong](https://jeong-pro.tistory.com/93)