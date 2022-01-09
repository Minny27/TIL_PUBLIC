# 3 way handshake
TCP/IP 프로토콜을 이용하여 통신을 진행할 때, 클라이언트 서버간 정확한 데이터 전송을 보장하기 위해 연결을 설정하는 과정이다.  
양쪽 모두 데이터를 전송할 준비가 되었다는 것을 보장하고, 실제로 데이터 전달이 시작하기 전에 한 쪽이 다른 쪽이 준비되었다는 것을 알 수 있도록 한다.

<br>

<img src="https://user-images.githubusercontent.com/33534771/75338886-d77ea880-58d2-11ea-84c3-f8b60663f9c6.png" width="60%"/>

<br>

> ### 전체 처리 과정
1. CLIENT -> SERVER 
접속 요청 프로세스 **CLIENT가 연결 요청 메시지 전송 (SYN)**  
송신자가 최초로 데이터를 전송할 때 Sequence Number를 임의의 랜덤 숫자로 지정하고, SYN 플래그 비트를 1로 설정한 세그먼트를 전송합니다.

2. SERVER -> CLIENT
접속 요청을 받은 프로세스 **SERVER가 요청을 수락**했으며, 접속 요청 프로세스인 **CLIENT도 포트를 열어 달라는 메시지 전송 (SYN + ACK)**  
수신자는 Acknowledgement Number 필드를 (Sequence Number + 1)로 지정하고, SYN과 ACK 플래그 비트를 1로 설정한 세그먼트를 전송합니다.

3. CLIENT -> SERVER
마지막으로 접속 요청 프로세스 **CLIENT가 수락 확인을 보내 연결을 맺음 (ACK)**  
이때, 전송할 데이터가 있으면 이 단계에서 데이터를 전송할 수 있습니다.

<br>

> 참고 출처
- [WooVictory](https://github.com/WooVictory/Ready-For-Tech-Interview/blob/master/Network/3%20way%20handshake.md)
- [gmlwjd9405](https://gmlwjd9405.github.io/2018/09/19/tcp-connection.html)