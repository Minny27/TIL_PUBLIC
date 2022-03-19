# 인터럽트(Interrupt)
**CPU가 어떤 프로그램을 실행하고 있을 때, 입출력 하드웨어 혹은 소프트웨어에 의해 예외 상황이 발생하여 처리가 필요한 경우에 CPU에게 이를 알려주는 것을 말합니다.**

<br>

> ### 인터럽트 과정
process A 실행 중 디스크에서 어떤 데이터를 읽어오라는 명령(인터럽트)을 받았다고 가정해보겠습니다.
process A는 system call을 통해 인터럽트를 발생시킵니다.
CPU는 현재 진행 중인 기계어 코드를 완료합니다.
현재까지 수행중이었던 상태를 해당 process의 PCB(Process Control Block)에 저장합니다. (수행중이던 MEMORY주소, 레지스터 값, 하드웨어 상태 등...)
PC(Program Counter, IP)에 다음에 실행할 명령의 주소를 저장합니다.
인터럽트 벡터를 읽고 ISR 주소값을 얻어 ISR(Interrupt Service Routine)로 점프하여 루틴을 실행합니다.
해당 코드를 실행합니다.
해당 일을 다 처리하면, 대피시킨 레지스터를 복원합니다.
ISR의 끝에 IRET 명령어에 의해 인터럽트가 해제됩니다.
IRET 명령어가 실행되면, 대피시킨 PC 값을 복원하여 이전 실행 위치로 복원한다.

<br>

> 참고 출처
- [탕탕탕구리](https://real-dongsoo7.tistory.com/m/93?category=784608)
- [adam2](https://velog.io/@adam2/%EC%9D%B8%ED%84%B0%EB%9F%BD%ED%8A%B8)