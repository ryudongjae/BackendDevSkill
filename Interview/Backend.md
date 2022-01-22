### 🧑🏻‍💻WAS와 WS의 차이
  * WAS(Web Application Server)
    * 비즈니스 로직을 넣을 수 있음
    * Tomcat,PHP,ASP,.Net 등 
  * WS(Web Server)
    * 비즈니스 로직을 넣을 수 없음
    * Nginx, Apache 등
---

### 🧑🏻‍💻많은 트래픽 대처

    1. 스케일 업(Scale Up): 서버에 CPU나 RAM 등을 추가하여 서버의 하트웨어 스펙을 향상 시키는 방법이다.

    2. 스케일 아웃(Scale Out): 서버를 여러 대 추가하여 시스템을 증가시키는 방법이다.
---
   
### CORS
    CORS(Cross-Origin-Resource-Sharing)란 도메인이 다른 2개의 사이트가 데이터를 주고 받을 때 발생하는 문제이다.
    예를들어 naver.com 에서 google.com 으로 데이터를 요청한다고 하면 , 따로 설정을 해주지 않는 한 CORS에러를 만나게 된다.
    CORS가 생기게 된 이유는 서버 내에서 요청이 허락된 도메인에만 데이터를 주기 위해서이다.CORS에러가 발생하지 않고 요청을 허락하기 위해서는
    Accesss-Control-Alow-Origin :{도메인} 과 같은 내용을 Response의 헤더에 추가해주어야 한다. 만약 도메인을 * 로 설정하게 되면 
    모든 도메인에 대해 요청을 허락할 수 있다.
* Access-Control-Allow-Origin : 요청을 보내는 페이지의 출처 [* , 도메인]
* Access-Control-Allow-Methods : 요청을 허용하는 메소드 [default: GET,POST]
* Access-Control-Max-Age : 클라이언트에서 preflight 요청(서버의 응답 가능 여부에 대한 확인) 결과를 저장할 시간
* Access-Control-Allow-Header : 모든 요청을 허용하는 헤더
---

### 아파치, 톰캣 은 멀티 프로세스인가 멀티 스레드인가❔

* 아파치는 기본적으로 멀티 프로세스로 구현되어 있다. 하지만 설정에 따라 멀티 스레드를 같이 운용할 수 있다.
* 톰캣은 요청을 처리하기 위한 스레드 풀을 관리하고 있다. 그리고 요청이 오면 해당 스레드 풀에서 스레드를 꺼내 요청을 처리하도록 한다.
---




  



