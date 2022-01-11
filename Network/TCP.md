# TCP(Transmission Control Protocol)
> ### 개념
- **신뢰성 있는 데이터 전송을 지원하는 연결 지향형 프로토콜**
- 일반적으로 TCP와 IP를 함께 사용하는데, IP가 데이터의 배달을 처리한다면 TCP는 패킷을 추적 및 관리합니다.  

> ### 특징
- 사전에 3-way handshake라는 과정을 통해 연결을 설정하고 통신을 시작합니다.
- 흐름 제어, 혼잡 제어, 오류 제어를 통해 **신뢰성을 보장**합니다. 그러나 이 때문에 **UDP보다 전송 속도가 느리다**는 단점이 있습니다.
- TCP를 사용하는 예로는 대부분의 웹 HTTP 통신, 이메일, 파일 전송에 사용됩니다.

<br>

> 참고 출처
- [WooVictory](https://github.com/WooVictory/Ready-For-Tech-Interview/blob/master/Network/TCP.md)