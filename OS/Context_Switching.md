# Context Switching
멀티프로세스 환경에서 CPU가 어떤 하나의 프로세스를 실행하고 있는 상태에서 인터럽트 요청에 의해 다음 우선 순위의 프로세스가 실행되어야 할 때 **기존의 프로세스의 상태 또는 레지스터 값(Context)을 저장하고 CPU가 다음 프로세스를 수행하도록 새로운 프로세스의 상태 또는 레지스터 값(Context)를 교체하는 작업**을 Context Switch(Context Switching)라고 합니다.

<br>

**하나의 프로세스가 CPU를 사용 중인 상태에서 다른 프로세스가 CPU를 사용하도록 하기 위해, 이전의 프로세스의 상태(Context)를 보관하고 새로운 프로세스의 상태를 적재하는 작업을 말합니다.**(위키백과)

<br>

> ### Context
- CPU가 다루는 Task(Process / Thread)에 대한 정보를 말하고, 대부분의 정보는 Register에 저장되고 PCB로 관리됩니다.

<br>

> 참고 출처
- [gmlwjd9405](https://gmlwjd9405.github.io/2018/09/14/process-vs-thread.html)
- [DolphaGo](https://m.blog.naver.com/adamdoha/222019884898)
- [jeong](https://jeong-pro.tistory.com/93)