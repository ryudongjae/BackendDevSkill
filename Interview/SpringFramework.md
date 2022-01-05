### 🧑🏻‍💻Spring Singleton Pattern
    싱글톤 패턴은 1개의 클래스당 1개의 객체만을 생성하여 사용하는 디자인 패턴이다. Spring에서는 스프링 컨테이너가 관리하는 객체인 Bean을 싱글톤 패턴으로
    구현하여 제공한다.
    Spring에서는 private 생성자나 static 메소드를 사용하지 않고도 해당 객체를 싱글톤으로 관리하여 객체지향적 개발을 할 수 있다.또한 자바의 싱글촌은 해당 클래스로더 내에서 
    1개의 인스턴스만을 생성할 수 있지만, Spring에서는 스프링 컨테이너의 컨택스트에서 1개의인스턴스를 생성할 수 있다.
    그에 따라 자바의 싱글톤은 JVM에 라이프사이클의 제어가 되지만, Spring의 싱글톤은 스프링 컨텍스트에 의해 제어가 된다. 또한 Spring에서의 싱글톤은 
    Thread safety를 자동으로 보장하는 반면 자바로 구현한 싱글톤 패턴은 반드시 보장하지 못한다.
---

### ➡️spring MVC
    spring MVC란 웹 애플리케이션 개발을 위한 MVC패턴 기반의 웹 프레임워크이다. Spring Mvc는 애플리케이션의 구성요소를 
    Model,View ,Controller 로 분리합니다. 또한 Spring MVC는 아래와 같은 컴포넌트들로 구성된다.
* Dispatcher Servlet : 클라이언트의 요청을 먼저 받아들이는 서블릿으로, 요청에 맞는 컨트롤러에게 요청을 전달함
* Handler Mapping : 해당 요청이 어떤 컨트롤러에게 온 요청인지 검사함
* Controller : 클라이언트의 요청을 받아 처리하여 결과를 디스패처 서블릿에게 전달함
* ViewResolver : View의 이름을 통해 알맞은 View를 찾음
* View : 사용자에게 보여질 UI 화면
---

### ➡️Spring MVC 작동 원리
    1. 클라이언트는 URL을 통해 요청을 전송한다.
    2. 디스패처 서블릿은 핸들러 매핑을 통해 해당 요청이 어느 컨트롤러에게 온 요청인지 찾는다.
    3. 디스패처 서블릿은 핸들러 어댑터에게 요청을 전달한다.
    4. 핸들러 어댑터는 해당 컨드롤러에 요청을 전달한다.
    5. 컨트롤러는 비즈니스 로직을 처리한 후에 반환할 뷰의 이름을 반환한다.
    6. 디스패처 서블릿은 뷰리졸버를 통해 반환할 뷰를 찾는다.
    7. 디스패처 서블릿은 컨트롤러에서 뷰에 전달할 데이터를 추가한다.
    8. 데이터가 추가된 뷰를 반환한다.
---

### ➡️Spring MVC의 장점과 단점
* 장점
    * 의존성 주입을 통해 컴포넌트 간의 결합도를 낮출 수 있어 단위 테스트가 용이하다.
    * 제어의 역전을 통해 빈(객체)의 라이프싸이클에 관여하지 않고 개발에 집중할 수 있다.
* 단점
    * XML을 기반으로 하는 프로젝트 설정은 너무 많은 시간을 필요로 한다.
    * 톰캣과 같은 WAS를 별도로 설치해주어야함
---
### ➡️Spring boot
    자동설정을 도입하여 Dispatcher Servlet 등과 같은 설정 시간을 줄여준다.
    프로젝트의 의존성을 독입적으로 선택하지 않고 spring-boot-starter로 모아두어 외부 도구들을 사용하기 편리하다.
    내장 톰캣을 제공하여 별도의 WAS를 필요로 하지 않음
---

### @Bean, @Configuration, @Component
* 개발자가 직접제어가 불가능한 외부 라이브러리 또는 설정을 위한 클래스를 Bean으로 등록할 때 @Bean어노테이션을 활용
* 1개 이상의 @Bean을 제공하는 클래스의 경우 반드시 @Configuration을 명시해주어야 한다.
* 개발자가 직접 개발한 클래스를 Bean으로 등록하고자 하는 경우 @Component 어노테이션을 활용한다.
---

### Springboot 와 SpringFramework  
    스프링 부트와 스프링 프레임워크의 가장 큰 차이는 Auto Configuration 이다.
    예를 들어 Spring Mvc프로젝트를 SpringFramework 기반으로 구성하면 컴포넌트 스캔,bean 설정, Dispatcher Servlet 설정, View Resolver
    JDBC 설정,웹 jar설정 등 다양한 설정을 해야하지만 이를 SpringBoot기반으로 구성함으로써 초기 개발 환경 세팅에 걸리는 리소스를 절약할 수 있다.
    스프링 부트로 프로젝트를 생성할 시 스프링 부트에서는 내장 서블릿 컨테이너인 톰캣이 자동적으로 설정된다.
---
### Spring container 종류
  1. BeanFactory : DI의 기본사항을 제공하는 컨테이너, 빈을 생성하고 분배하는 작업을 한다.
  2. ApplicationContext : bean 팩토리와 유사하지만 더 많은 기능을 제공한다. 미리 빈을 생성해놓아 빈이 필요할때 즉시 사용할 수 있도록 보장한다.
---

### 컨테이너(container)
    프레임워크 안에서 인스턴스들의 생명 주기를 관리하며, 생성된 인스턴스에 추가적인 기능을 제공한다.
    내가 작업한 코드 처리과정이 컨테이너에서 실행된다.
    스프링 컨테이너는 스프링 프레임워크 핵심적인 위치에 존재하며 DI를 통한 애플리케이션을 구성하는 컴포넌트를 관리한다.

---

### IOC Container
    IOC container는 객체의 생성과 관계 설정, 사용, 제거 등의 전체 라이프 사이클을 관리해주는 작업을 하는 컨테이너를 Ioc컨테이너라 한다.
    Ioc Container의 대표적인 명세는 BeanFactory인데 요즘은 이를 상속하는 Application Context를 사용한다.
    왜냐하면 Application Context는 BeanFactory의 기능 뿐만 아니라, 메세지 다국화, 이벤트 발행기능, 리소스 로딩 기능등의 여러 기능을 제공한다.
    
    spring Ioc Container의 Bean 등록방법에는 Xml설정 파일을 통해 Bean 등록, @Annotation을 통해 Bean 등록하는 방법이 있다.
    하지만 Annotation기반의 Bean 등록시에는 Component Scan을 필요로 한다. 직접 등록해줄수도 있지만 SpringBoot에서는 CommponentScan을 자동으로 설정해준다.
* @Configuration : 스프링 설정으로 사용하겠다는 의미
* @EnableAutoConfiguration : 지정해둔 설정 값들을 자동으로 설정하는 기능을 킨다는 의미
* @ComponentScan, @Component, @Configuration 붙은 클래스를 Bean으로 등록  
---