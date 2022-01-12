# Context Switching
CPU에서 여러 프로세스를 돌아가면서 작업을 처리하는 데 이 과정을 Context Switching라 합니다.  
동작 중인 프로세스가 대기를 하면서 해당 프로세스의 상태(Context)를 보관하고,  
대기하고 있던 다음 순서의 프로세스가 동작하면서 이전에 보관했던 프로세스의 상태(Context)를 복구하는 작업을 말합니다.

> ### Context
- CPU가 다루는 Task(Process / Thread)에 대한 정보를 말하고, 대부분의 정보는 Register에 저장되고 PCB로 관리됩니다.

<br>

> 참고 출처
- [gmlwjd9405](https://gmlwjd9405.github.io/2018/09/14/process-vs-thread.html)
- [DolphaGo](https://m.blog.naver.com/adamdoha/222019884898)