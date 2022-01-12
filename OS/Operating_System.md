# 1. 개요

> ### 운영체제의 개념
- 컴퓨터의 사용자와 하드웨어 사이에서 중개자 역할을 해주는 프로그램

<br>

> ### 운영체제의 목적
1. 사용자가 컴퓨터를 편리하게 사용하는 것
2. 컴퓨터 하드웨어가 효율적으로 사용되는 것

<br>

> ### 운영체제의 특징
- 사용자와 하드웨어간의 전반적인 상호작용을 하면서 컴퓨터가 실행되는 동안 항상 수행됩니다.

<br>

# 2. 시스템의 발전

> ### 일괄처리 시스템(Batch System)
- 초기의 컴퓨터가 동작하는 방식.
- 처리 속도를 향상시키기 위해서 유사한 요구를 가지는 작업들을 모아 하나의 그룹으로 수행
- 입출력 장치의 속도가 CPU와 같은 전자적인 장치의 속도보다 느리기 때문에 CPU가 계속 쉬는 상태(idle)인 경우가 많습니다.
- 상호작용이 필요없는 큰 단위의 작업들을 수행할 때 사용됩니다.

<br>

> ### 다중 프로그래밍 시스템(Multi-Programming System)
- CPU가 수행할 작업을 항상 가지도록 하는 방식.
- 먼저 하드디스크나 SSD에서 여러 개의 프로그램을 메인 메모리(RAM)에 적재합니다. 이후에 메모리 내의 작업 중 하나를 선택해 차례대로 실행합니다.  
- 이 때 수행중인 작업이 입출력 등 떄문에 기다리는 상태에 도달하면 CPU는 다른 작업으로 넘어가서 수행을 계속합니다. 이 후에 첫 번째 작업이 끝나면 현재의 작업을 중단하고 다시 첫 번째 작업이 CPU를 차지하게 되어 컴퓨터의 효율을 증대시키는 방법

<br>

> ### 시분할 시스템(Time-Sharing System)
- 다중 프로그래밍의 장점을 채택하여 확장한 시스템으로서 프로그램이 수행되고 있을 때 아주 짧은 주기로 CPU를 각각의 프로그램에 할당해주는 방법입니다.
- 아주 짧은 주기로 전환이 이루어지기 때문에 각 사용자는 모든 프로그램이 동시에 작동한다고 느끼게 됩니다.

<br>

> ### 작업 스케줄링
- 보조기억장치의 프로그램에 저장되어 있고 그 중 일부를 선택해 적재하는 전략입니다.

<br>

> ### CPU 스케줄링
- 메모리에 올라온 작업들 중에서 무엇을 먼저 실행할지 결정하는 전략입니다.

<br>

# 3. 다양한 시스템

> ### 다중 처리 시스템(Multiprocessor System)
- CPU가 여러 개인 시스템을 의미하며, 각각의 CPU들이 아주 밀접하게 통신을 하는 구조입니다.
- 하나의 CPU가 고장나도 속도만 느려질 뿐 시스템은 정상적으로 작동합니다.

<br>

> ### 분산 처리 시스템(Distributed Processing System)
- 네트워크를 이용해 동시에 여러 작업을 수행하는 시스템으로 각각의 CPU들은 서로 메모리를 공유하지 않습니다.
- 적절한 자원 공유로 계산 속도가 빨라지고 신뢰성이 보장합니다.

<br>

> ### 클라이언트 & 서버 시스템(Client & Server System)
- 클라이언트가 서버로 어떤 작업을 요청을 보내고 서버는 그 작업을 수행해서 다시 클라이언트에게 응답을 보내는 구조입니다.

<br>

> ### 클러스터 시스템(Clustered System)
- 물리적으로 많은 CPU를 한 곳에 모아 특정한 작업을 수행하는 시스템입니다.
- LAN으로 연결된 각각의 CPU는 다른 CPU와 상호작용하여 고속 처리 서비스를 지원하게 됩니다.

<br>

> ### 실시간 시스템(Real-Time System)
- 실시간 시스템은 CPU의 동장이나 작업이 즉시적인 처리를 요할 때 채택되는 시스템입니다.
- 주로 의학 영상 시스템이나 무기 시스템에 많이 사용하고 있습니다.

<br>

> 참고 출처
- [동빈나](https://www.youtube.com/watch?v=EAoJb00Iwso&list=PLRx0vPvlEmdCpDmUS-azJTey03BE76eI_)