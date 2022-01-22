# 소켓(Socket)

> ### 개념
- 프로그램이 네트워크에서 데이터를 통신할 수 있도록 연결해주는 창구 역할을 합니다.
- 네트워크를 이용해 데이터를 송수신하기 위해서는 소켓을 열어서 소켓에 데이터를 보내거나 소켓으로부터 데이터를 읽어야합니다.

<br>

> ### 5-Tuple
1. 프로토콜 (Protocol)
2. 호스트 IP 주소 (source IP address)
3. 호스트 port 번호 (source port nunber)
4. 목적지 IP 주소 (destination IP address)
5. 목적지 port 번호 (destination port number)

<br>

> ### 프로토콜(Protocol)
- 컴퓨터 내부에서, 또는 컴퓨터 사이에서 **데이터 교환 방식을 정의하는 규칙 체계**

<br>

> ### IP 주소(Internet Protocol address)
- IP 주소란 많은 컴퓨터들이 **인터넷 상에서 서로를 인식하기 위해 지정받은 식별 번호**
- 현재는 IPv4 버전(32비트)로 구성되어 있으며 한번씩은 들어봤을 법한 127.0.0.1 같은 주소를 말합니다.
- 시간이 갈수록 IPv4 주소의 부족으로 IPv6가 생겼는데, 128비트로 구성되어있기 때문에 IP 주소가 부족하지 않다는 특징이 있습니다.

<br>

> ### 포트(port)
- 네트워크 서비스나 특정 프로세스를 식별하는 논리 단위
- 각 포트는 번호로 구별되며 이 번호를 포트 번호라고 합니다.
- **포트 번호는 호스트 내부적으로 프로세스가 갖는 고유 식별 번호**

<br>

> ### 종착점(Endpoint)
- 클라이언트 응용 프로그램이 **서비스에 액세스할 수 있는 URL**
- **요청을 받아 응답을 제공하는 서비스를 사용할 수 있는 지점**
- Base URL + Path Variable + Query Parameter 모두를 포함한 URL

<br>

> ### 도메인 네임(Domain Name)
- IP주소는 12자리의 숫자로 되어있기 때문에 사람이 외우기 힘들다는 단점이 있습니다.
- 그렇기 때문에 **12자리의 IP 주소를 문자로 표현한 주소**를 도메인 네임이라고 합니다.
- 다시 말해서, 도메인 네임은 'naver.com'처럼 몇 개의 의미있는 문자들과 점(.)의 조합으로 구성됩니다.

<br>

> 참고 출처
- [sophia2730](https://sophia2730.tistory.com/entry/DNS-%EC%A3%BC%EC%86%8C%EC%B0%BD%EC%97%90-wwwnavercom%EC%9D%84-%EC%B9%98%EB%A9%B4-%EC%9D%BC%EC%96%B4%EB%82%98%EB%8A%94-%EC%9D%BC)
- [Clap Yeon](https://medium.com/@su_bak/term-socket%EC%9D%B4%EB%9E%80-7ca7963617ff)
- [달나라 곰돌이](https://helloworld-88.tistory.com/215)
- [on1ystar](https://on1ystar.github.io/socket%20programming/2021/03/16/socket-1/)
- [mozilla](https://developer.mozilla.org/ko/docs/Glossary/Protocol)
- [djaxornwkd12](https://velog.io/@djaxornwkd12/API%EC%99%80-ENDPOINT%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80)
- [toneyparky](https://toneyparky.tistory.com/6)
- 위키백과