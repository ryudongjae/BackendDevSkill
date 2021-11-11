Nginx
====
    Nginx는 경량 웹 서버입니다.
    클라이언트로부터 요청을 받았을 때 요청에 맞는 정적 파일을 응답해주는 HTTP Web Server로 활용되기도 하고,
    Reverse Proxy Server로 활용하여 WAS 서버의 부하를 줄일 수 있는 로드 밸런서로 활용되기도 합니다. 

Nginx 흐름  
---
    Nginx는 Event-Driven 구조로 동작하기 때문에 한 개 또는 고정된 프로세스만 생성하여 사용하고,
    비동기 방식으로 요청들을 Concurrency 하게 처리할 수 있습니다.
    위의 그림에서 보이듯이 Nginx는 새로운 요청이 들어오더라도 새로운 프로세스와 쓰레드를 생성하지 않기 때문에 프로세스와 쓰레드 생성 비용이 존재하지 않고,
    적은 자원으로도 효율적인 운용이 가능합니다.
    이러한 Nginx의 장점 덕분에 단일 서버에서도 동시에 많은 연결을 처리할 수 있습니다.

Nginx의 구조
---
    Nginx는 하나의 Master Process와 다수의 Worker Process로 구성되어 실행됩니다. Master Process는 설정 파일을 읽고,
    유효성을 검사 및 Worker Process를 관리합니다.
    모든 요청은 Worker Process에서 처리합니다.
    Nginx는 이벤트 기반 모델을 사용하고, Worker Process 사이에 요청을 효율적으로 분배하기 위해 OS에 의존적인 메커니즘을 사용합니다.
    Worker Process의 개수는 설정 파일에서 정의되며, 정의된 프로세스 개수와 사용 가능한 CPU 코어 숫자에 맞게 자동으로 조정됩니다.