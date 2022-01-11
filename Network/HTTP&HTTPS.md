# HTTP & HTTPS

> ### HTTP
* **개념**
    - **웹 서버와 클라이언트 간의 문서를 교환하기 위한 통신 규약**
    - 웹에서만 사용하는 프로토콜로 TCP/IP 기반으로 서버와 클라이언트 간의 요청과 응답을 전송합니다.
    - 보통 브라우저인 클라이언트에 의해 전송되는 메시지를 요청(request)이라고 부르며, 그에 대해 서버에서 응답으로 전송되는 메시지를 응답(responses)이라고 부릅니다.

* **문제점**
    - HTTP는 평문 통신이기 때문에 도청이 가능
    - 통신 상대를 확인하지 않기 때문에 위장이 가능
    - 완전성을 증명할 수 없기 때문에 변조가 가능

<br>

> ### HTTPS
* **개념**
    - **HTTPS는 HTTP에 데이터 암호화를 위해 SSL(보안 소켓 계층)이 추가된 프로토콜**
    - HTTP는 TCP와 통신했지만, HTTPS는 계층 하나를 추가해서 HTTP는 SSL, SSL은 TCP와 통신하게 됩니다.
    - HTTPS의 SSL에서는 대칭키 암호화 방식과 공개키 암호화 방식을 모두 사용합니다.

<br>

> 참고 출처
- [WooVictory](https://github.com/WooVictory/Ready-For-Tech-Interview/blob/master/Network/HTTP%2C%20HTTPS.md)
- [mozilla.org](https://developer.mozilla.org/ko/docs/Web/HTTP/Overview)