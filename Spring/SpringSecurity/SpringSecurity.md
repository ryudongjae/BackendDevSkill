# SpringSecurity

### **REFERENCE**

- [https://spring.io/projects/spring-security](https://spring.io/projects/spring-security)
- 힐링 페이퍼(강남언니) BROWN님
- SK hynix  김*진님
- MS(microsoft)  BRICKS님

  ****(대기업 형님들의 전폭적인 지원으로 만든 세미나)

![스크린샷 2022-12-28 17.46.32.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2fee8bc7-efe9-49aa-9fb8-d6854ed4d996/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-28_17.46.32.png)

### **Spring Security란?**

> Spring Security is a powerful and highly customizable authentication and access-control framework. It is the de-facto standard for securing Spring-based applications.
>
>
> Spring Security is a framework that focuses on providing both authentication and authorization to Java applications. Like all Spring projects, the real power of Spring Security is found in how easily it can be extended to meet custom requirements
>
> Spring Security requires a Java 8 or higher Runtime Environment.
>
> As Spring Security aims to operate in a self-contained manner, you do not need to place any special configuration files in your Java Runtime Environment. In particular, you need not configure a special Java Authentication and Authorization Service (JAAS) policy file or place Spring Security into common classpath locations.
>
> Similarly, if you use an EJB Container or Servlet Container, you need not put any special configuration files anywhere nor include Spring Security in a server classloader. All the required files are contained within your application.
>
> This design offers maximum deployment time flexibility, as you can copy your target artifact (be it a JAR, WAR, or EAR) from one system to another and it immediately works.
>
> Spring Security는 강력하고 고도로 맞춤형 인증 및 액세스 컨트롤 프레임워크이다. Spring Security는 Spring 기반 애플리케이션을 보호하기 위한 사실상의 표준이다.
>
> Spring Security는 Java 애플리케이션에 인증과 인가를 모두 제공하는 데 중점을 두는 프레임워크이고, 모든 Spring 프로젝트와 마찬가지로 Spring Security의 진가는 커스텀 요건을 충족시키기 위해 얼마나 쉽게 확장할 수 있느냐에 있다.
>
> Spring Security에는 Java 8 이상의 Runtime Environment가 필요하고,Spring Security는 독립적인 방식으로 작동하는 것을 목표로 하므로 Java Runtime Environment에 특별한 구성 파일을 배치할 필요가 없다. 특히 특별한 JAAS(Java Authentication and Authorization Service) 정책 파일을 구성하거나 Spring Security를 공통 클래스 경로 위치에 배치할 필요가 없습니다.
>
> 마찬가지로 EJB 컨테이너 또는 서블릿 컨테이너를 사용하는 경우 특별한 구성 파일을 어디에도 두거나 서버 클래스 로더에 Spring Security를 포함할 필요가 없다. 필요한 모든 파일은 애플리케이션 내에 포함되어 있다.
>
> 이 디자인은 대상 아티팩트(JAR, WAR 또는 EAR)를 한 시스템에서 다른 시스템으로 복사할 수 있고 즉시 작동하므로 최대한의 배포 시간 유연성을 제공한다.
>

Spring Security는 Spring 기반의 애플리케이션의 보안(인증과 권한, 인가 등)을 담당하는 스프링 하위 프레임워크이다. Spring Security는 '인증'과 '권한'에 대한 부분을 Filter 흐름에 따라 처리하고 있다. Filter는 Dispatcher Servlet으로 가기 전에 적용되므로 가장 먼저 URL 요청을 받지만, Interceptor는 Dispatcher와 Controller사이에 위치한다는 점에서 적용 시기의 차이가 있다. Spring Security는 보안과 관련해서 체계적으로 많은 옵션을 제공해주기 때문에 개발자 입장에서는 일일이 보안관련 로직을 작성하지 않아도 된다는 장점이 있다.

### **인증(Authorizatoin)과 인가(Authentication)**

- 인증(Authentication): 해당 사용자가 본인이 맞는지를 확인하는 절차
- 인가(Authorization): 인증된 사용자가 요청한 자원에 접근 가능한지를 결정하는 절차

![https://blog.kakaocdn.net/dn/oMnop/btqEJh4jxCX/PhClhzrEpVOCRK7wYM5R4k/img.png](https://blog.kakaocdn.net/dn/oMnop/btqEJh4jxCX/PhClhzrEpVOCRK7wYM5R4k/img.png)

Spring Security는 기본적으로 인증 절차를 거친 후에 인가 절차를 진행하게 되며, 인가 과정에서 해당 리소스에 대한 접근 권한이 있는지 확인을 하게 된다. Spring Security에서는 이러한 인증과 인가를 위해 Principal을 아이디로, Credential을 비밀번호로 사용하는 Credential 기반의 인증 방식을 사용한다.

- **Principal(접근 주체)**: 보호받는 Resource에 접근하는 대상
- **Credential(비밀번호)**: Resource에 접근하는 대상의 비밀번호

## 🔒 SpringSecurity Architecture

![스크린샷 2022-12-27 오후 8.36.51.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7930b281-9d3d-4b27-9a35-07185a38e21a/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_8.36.51.png)

1. 사용자가 아이디 비밀번호로 로그인을 요청함
2. AuthenticationFilter에서 UsernamePasswordAuthenticationToken을 생성하여 AuthenticaionManager에게 전달
3. AuthenticaionManager는 등록된 AuthenticaionProvider(들)을 조회하여 인증을 요구함
4. AuthenticaionProvider는 UserDetailsService를 통해 입력받은 아이디에 대한 사용자 정보를 DB에서 조회함
5. 입력받은 비밀번호를 암호화하여 DB의 비밀번호화 매칭되는 경우 인증이 성공된 UsernameAuthenticationToken을 생성하여 AuthenticaionManager로 반환함
6. AuthenticaionManager는 UsernameAuthenticaionToken을 AuthenticaionFilter로 전달함
7. AuthenticationFilter는 전달받은 UsernameAuthenticationToken을 LoginSuccessHandler로 전송하고, SecurityContextHolder에 저장함

![스크린샷 2022-12-28 17.47.49.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7802373a-82a0-4b11-99a6-3510091cae7b/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-28_17.47.49.png)

### 🔑 **Authentication Filter**

요청이 Dispatcher Servlet에 도달하기 전에 먼저 필터 체인에 의해 차단된다.

![https://www.javainuse.com/series-2-3-min.JPG](https://www.javainuse.com/series-2-3-min.JPG)

이러한 필터는 Spring Security를 담당한다. 따라서 들어오는 모든 요청은 이러한 필터를 거치며 여기에서 인증 및 권한 부여가 이루어진다. 요청 유형에 따라 BasicAuthenticationFilter, UsernamePasswordAuthenticationFilter 등과 같은 다양한 인증 필터가 있다.

각 필터에 대해 간단하게 설명하면 아래와 같다.

- SecurityContextPersistenceFilter : SecurityContextRepository에서 SecurityContext를 가져오거나 저장한다.
- LogoutFilter : 설정된 로그아웃 URL로 오는 요청을 감시하며, 해당 유저를 로그아웃 처리한다.
- (UsernamePassword)AuthentocationFilter(아이디와 비밀번호를 사용하는 form 기반 인증) 설정된 로그인 URL로 오는 요청을 감시하며, 유저 인증을 처리.
    1. AuthenticationManager를 통한 인증 실행.
    2. 인증 성공 시, 얻은 Authentication 객체를 SecurityContext에 저장 후, AuthenticationSuccessHandler 실행.
    3. 인증 실패 시, AuthenticationFailureHandler 실행.
- DefaultLoginPageGeneratingFilter : 인증을 위한 로그인 폼 URL을 감시.
- BasicAuthentocationFilter : HTTP 기본 인증 헤더를 감시하여 처리.
- RequestCacheAwareFilter : 로그인 성공 후 , 원래 요청 정보를 재구성하기 위해 사용.
- SecurityContextHolderAwareRequestFilter :HttpServletRequestWrapper를 상속한 SecurityContextHolderAwareRequestWrapper 클래스로 HttpServletRequest 정보를 감싼다. SecurityContextHolderAwareRequestWrapper는 필터 체인상의 다음 필터들에게 정보를 제공한다
- AnonymousAuthenticationFilter : 이 필터가 호출되는 시점까지 사용자 정보가 인증되지 않았다면, 인증 토큰에 사용자가 익명 사용자로 나타난다.
- SessionManagementFilter : 이 필터는 인증된 사용자와 관려된 모든 세션을 추적한다.
- ExceptionTranslationFilter : 이 필터는 보호된 요청을 처리하는 중에 발생할 수 있는 예외를 위임, 전달한다.
- FilterSecurityInterceptor : AccessDecisionManager로써 권한 부여처리를 위임하여 접근 제어를 쉽게 해준다.

### 🔑  **UsernamePasswordAuthenticationToken**

- UsernamePasswordAuthenticationToken은 Authentication을 implements한 AbstractAuthenticationToken의 하위 클래스로, User의 ID가 Principal 역할을 하고, Password가 Credential의 역할을 한다.
- UsernamePasswordAuthenticationToken의 첫 번째 생성자는 인증 전의 객체를 생성하고, 두번째 생성자는 인증이 완려된 객체를 생성한다.

### 🔑  **AuthenticationProvider**

- AuthenticationProvider에서는 실제 인증에 대한 부분을 처리하는데, 인증 전의 Authentication객체를 받아서 인증이 완료된 객체를 반환하는 역할을 한다.
- 아래와 같은 AuthenticationProvider 인터페이스를 구현해서 Custom한 AuthenticationProvider을 작성해서 AuthenticationManager에 등록하면 된다.
- **UserDetailsService -**

    UserDetailsService는 loadUserByUsername이라는 단일 메서드가 있는 인터페이스이다.

    ![https://www.javainuse.com/series-2-12-min.JPG](https://www.javainuse.com/series-2-12-min.JPG)

    CachingUserDetailsService, JDBCDaoImpl 등 다양한 구현이 있습니다. 구현에 따라 적절한 UserDetailsService가 호출된다.

    ![https://www.javainuse.com/series-2-16-min.JPG](https://www.javainuse.com/series-2-16-min.JPG)

    들어오는 사용자 개체와 비교할 사용자 이름과 암호를 사용하여 사용자 객체를 가져오는 일을 담당한다.


### 🔑  **Authentication Manager**

- 인증에 대한 부분은 SpringSecurity의 AuthenticatonManager를 통해서 처리하게 되는데, 실질적으로는 AuthenticationManager에 등록된 AuthenticationProvider에 의해 처리된다. 인증이 성공하면 2번째 생성자를 이용해 인증이 성공한(isAuthenticated=true) 객체를 생성하여 Security Context에 저장한다.
- 그리고 인증 상태를 유지하기 위해 세션에 보관하며, 인증이 실패한 경우에는AuthenticationException를 발생시킨다.
- **AuthenicationManager -**필터가 생성한 인증 개체를 사용하면 인증 관리자의 인증 방법이 호출된다. 인증 관리자는 인터페이스일 뿐이며 인증 방법의 실제 구현은 ProviderManager에서 제공한다.

![https://www.javainuse.com/series-2-9-min.JPG](https://www.javainuse.com/series-2-9-min.JPG)

![https://www.javainuse.com/series-3-2-min.JPG](https://www.javainuse.com/series-3-2-min.JPG)

여기서 중요한점은 인증 관리자가 인증 개체를 입력으로 사용하고 성공적인 인증 후에 다시 인증 유형의 개체를 반환한다.

![https://www.javainuse.com/series-2-13-min.JPG](https://www.javainuse.com/series-2-13-min.JPG)

ProviderManager에는 AuthenticationProvider 목록이 있다. 인증 메소드에서 적절한 AuthenticateProvider의 인증 메소드를 호출한다. 응답으로 인증에 성공하면 Principal Authentication Object를 가져온다.

![https://www.javainuse.com/series-2-10-min.JPG](https://www.javainuse.com/series-2-10-min.JPG)

**AuthenticationProvider -** AuthenicationProvider는 단일 인증 방법이 있는 인터페이스이다.

![https://www.javainuse.com/series-2-15-min.JPG](https://www.javainuse.com/series-2-15-min.JPG)

CasAuthenticationProvider,DaoAuthenticationProvider와 같은 다양한 구현이 있다. 구현에 따라 적절한 AuthenicationProvider 구현이 사용된다. 모든 실제 인증이 발생하는 AuthenticationProvider 구현 인증 메소드에 있다.

![https://www.javainuse.com/series-2-11-min.JPG](https://www.javainuse.com/series-2-11-min.JPG)

UserDetails 서비스를 사용하여 AuthenticationProvider는 사용자 이름에 해당하는 사용자 개체를 가져온다. 데이터베이스, 내부 메모리 또는 기타 소스에서 이 사용자 개체를 가져옵니다. 그런 다음 이 사용자 개체 자격 증명을 들어오는 인증 개체 자격 증명과 비교한다. 인증에 성공하면 Principal Authentication Object가 응답으로 반환된다.

![https://www.javainuse.com/series-2-12-min.JPG](https://www.javainuse.com/series-2-12-min.JPG)

**UserDetailsService -** UserDetailsService는 loadUserByUsername이라는 단일 메서드가 있는 인터페이스이다.

![https://www.javainuse.com/series-2-16-min.JPG](https://www.javainuse.com/series-2-16-min.JPG)

CachingUserDetailsService, JDBCDaoImpl 등 다양한 구현이 있다. 구현에 따라 적절한 UserDetailsService가 호출된다.

들어오는 사용자 개체와 비교할 사용자 이름과 암호를 사용하여 사용자 개체를 가져오는 일을 담당한다.

### **SecurityContextHolder**

- SecurityContextHolder는 보안 주체의 세부 정보를 포함하여 응용프래그램의 현재 보안 컨텍스트에 대한 세부 정보가 저장된다.
- SecurityContextHolder는 기본적으로 SecurityContextHolder.MODE_INHERITABLETHREADLOCAL 방법과SecurityContextHolder.MODE_THREADLOCAL 방법을 제공한다.

### **SecurityContext**

- Authentication을 보관하는 역할을 하며, SecurityContext를 통해 Authentication 객체를 꺼내올 수 있다.

### **Authentication**

- Authentication는 현재 접근하는 주체의 정보와 권한을 담는 인터페이스이다. Authentication 객체는 Security Context에 저장되며, SecurityContextHolder를 통해 SecurityContext에 접근하고, SecurityContext를 통해 Authentication에 접근할 수 있다.

### ****Login Form 인증 로직 플로우****

1. UsernamePasswordAuthenticationFilter
    - 로그인 인증처리를 담당하고 인증처리에 관련된 요청을 처리하는 필터

![스크린샷 2022-12-27 오후 10.13.16.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6779c6a7-6e65-49d3-97d5-b4d11754392b/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.13.16.png)

1. **AntPathRequestmatcher**(/login)
→ 사용자가 요청한 요청정보를 확인하여 요청정보 Url이 /login으로 시작하는지 확인한다.
요청한다면 다음단계로(인증처리) 진행되고, 일치하지 않는다면 다음 필터로 진행된다.(chain.doFilter)
*/login url은 .loginProcessingUrl()으로 변경 가능하다.*

[data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==](data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==)

1. Authentication 에서 실제 인증처리를 하게 되는데, 로그인 페이지에서 입력한 Username과 Password를 인증객체(Authentication)에 저장해서 인증처리(AuthenticationManager)를 맡기는 역할을 한다.
***→ 여기까지가 인증처리를 하기전에 필터가 하는 역할.***
2. 인증관리자(AuthenticationManager)는 내부적으로 AuthenticationProvider 에게 인증처리를 위임하게 된다. 해당 Provider가 인증처리를 담당하는 클래스로써 인증에 성공/실패를 반환하는데 실패할 경우 AuthenticationException  예외를 반환하여 UsernamePasswordAuthenticationFilter로 돌아가서 예외처리를 수행하고, 인증에 성공하게 되면, Authentication 객체를 생성하여
User객체와 Authorities객체를 담아서 AuthenticationManager에게 반환한다.
3. AuthenticationManager는 Provider로부터 반환받은 인증객체(인증결과 유저(User), 유저권한정보
4. SecurityContext는 Session에도 저장되어 전역적으로 SecurityContext를 참조할 수 있다.
5. 인증 성공 이후에는 SuccessHandler에서 인증 성공이후의 로직을 수행하게 된다.

****정리****

인증처리 필터(UsernamePasswordAuthenticationFilter)는 Form인증처리를 하는 필터로써 해당 필터는 크게 두가지로 인증전과 인증후의 작업들을 관리한다.

인증처리전에는 사용자 인증정보를 담아서 전달하면서 인증처리를 맡기고(AuthenticationManager) 성공한 인증객체를 반환받아서  (전역적으로 인증객체를 참조할 수 있도록 설계 된)SecurityContext에 저장하고, 그 이후 SuccessHandler를 통해 인증 성공후의 후속 작업들을 처리합니다.

### **Logout Flow Detail**

1. Client에서 GET방식의 /logout 리소스 호출
2. Server에서 세션무효화, 인증토큰 삭제, 쿠키정보 삭제 후 로그인페이지로 리다이렉트

![스크린샷 2022-12-27 오후 10.15.02.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c1c6be4d-347e-4390-bf92-149fccc91d93/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.15.02.png)

1. 요청이 Logout Url 인지 확인
2. 맞을 경우 SecurityContext에서 인증객체(Authentication)객체를 꺼내옴
3. **SecurityContextLogoutHandler**에서 세션 무효화, 쿠키삭제, clearContext()를통해 **SecurityContext**객체를 삭제하고 인증객체도 null로 만든다.
4. **SimpleUrlLogoutSuccessHandler**를 통해 로그인페이지로 리다이렉트 시킨다.

## **Remember Me 인증(EX: 로그인 유지 등등)**

→ 세션이 만료되고 웹 브라우저가 종료된 후에도 어플리케이션이 사용자를 기억하는 기능

→ **Remember-Me** 쿠키에 대한 HTTP 요청을 확인한 후 토큰 기반 인증을 사용해 유효성을 검사하고 토큰이 검증되면 사용자는 로그인 된다.

→ 사용자 라이프 사이클

- 인증 성공(Remember-Me 쿠키 설정)
- 인증 실패(쿠키가 존재하면 쿠키 무효화)
- 로그아웃(쿠키가 존재하면 쿠키 무효화)

****특징****

- SessionID 쿠키를 삭제하더라도 Remember-Me가 있다면 해당 쿠키를 decoding한 다음 로그인 상태를 유지할 수 있도록 한다.

![스크린샷 2022-12-27 오후 10.16.48.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/72fddf01-aaa1-4169-907b-1648a2004d10/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.16.48.png)

****Remember Me 인증 Flow****

1. Client에서 요청 (세션이 만료되었고, 사용자는 Form인증 받을 당시 Remember me를 사용하였기에 Remember me cookie를 가지고 있음)
2. RememberMeAuthenticationFilter 가 동작
3. RememberMeService interface의 구현체 동작
- TokenBasedRememberMeService → 메모리에서 저장한 토큰과 사용자가 가져온 토큰을 비교(default 14일 보존)하는 구현체
- PersistentTokenBasedRememberMeService → DB에 발급한 토큰과 사용자가 가져온 토큰을 비교해서 인증 처리 하는 구현체
1. Token Cookie 추출
2. Token이 존재하는지 검사 → 만약 없다면 다음 필터 동작
3. Decode Token으로 Token의 format이 규칙에 맞는지 판단(유효성 검사)

→ 유효성이 invalidate 하다면 Exception 발생

1. 토큰이 서로 일치하는지 검사

→ 토큰이 일치하지 않을경우 Exception 발생

1. 토큰에 User 계정이 존재하는지 검사

→ 없을 경우 Exception 발생

1. 새로운 Authentication Object를 생성하여 인증처리
2. AuthenticationManager 인증관리자에게 전달하여 인증처리 수행

## **익명사용자 인증 필터:**

****AnonymousAuthenticationFilter****

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F7303fe40-d546-4cb6-aaa4-d9d70a80f723%2FAnonymousAuthenticationFilter.png&blockId=aee0bff8-5398-4a01-97dd-aa65ce8231ff](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F7303fe40-d546-4cb6-aaa4-d9d70a80f723%2FAnonymousAuthenticationFilter.png&blockId=aee0bff8-5398-4a01-97dd-aa65ce8231ff)

- 인증객체가 없는 익명의 사용자를 위한 필터로써 특정 자원(페이지)에 접근시도시 인증객체를 검사하는데 만약 session을 발급받은 인증객체가 있는 사용자일 경우 해당 객체를 가지고 다음 필터를 동작하지만, 인증객체가 없을경우 익명사용자용 인증객체를 생성하기위해 사용되고 있다.
- isAnonymous()와 isAuthenticated()를 통해 인증 여부를 검사할 수 있다( return boolean type)
- 인증객체를 세션에 저장하지 않는다.

****정리****

: 익명사용자와 일반 사용자간의 구분이 필요하다는 점과 , 익명사용자일 경우에 처리 로직을 동작시키기 위해 익명사용자 인증 필터와 익명사용자용 인증객체가 필요하다.

## **동시 세션 제어, 세션 고정 보호, 세션 정책**

****개요****

A 컴퓨터에서 로그인하여 서비스를 사용하다가 핸드폰 혹은 다른 컴퓨터 등에서 같은 서비스를 이용하기위해 로그인을 시도할 수 있다. 그런데 이런 다중 접속시도가 무한정 허용 될 경우 여러 문제점을 야기시킬 수 있다. 교육플랫폼같은 경우에는 다중 로그인을 허용해 동시 접속이 된다면, 한 명이 강의를 결제한 뒤 모두가 공유해서 보는 문제가 발생할 수 있다.

OTT 서비스인 Wave의 경우에도 다중 접속의 경우 인원제한을 두고 과금 모델을 만들어서 제한적인 동시 세션을 허용해주고 있다. 스프링 시큐리티에서는 이런 세션에 대한 관리기능도 다음과 같이 제공을 해 주고 있다.

1. **세션관리** → 인증 시 사용자의 세션정보를 등록, 조회, 삭제 등의 세션 이력을 관리
2. **동시적 세션 제어** → 동일 계정으로 접속이 허용되는 최대 세션수를 제한
3. **세션 고정 보호** → 인증 할 때마다 세션 쿠키를 새로 발급하여 공격자의 쿠키 조작을 방지
4. **세션 생성 정책** → Always, if_required, Never, Stateless

📍 ****동시 세션 제어****

동시 세션 제어란 같은 계정(세션)을 동시에 몇개까지 유지할 수 있게 할 지에 대한 제어를 의미하는데,

위에서도 언급했듯이 기존 접속해있는 계정이 있다고 할 때 새로운 사용자가 동일한 계정으로 접속을 시도했을 때 어떻게 대응할지에 대한 방법으로 기존 사용자를 로그아웃 시키거나 현재 사용자가 접속을 할 수 없게 막거나 하는식이다.

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F9e5edfdc-7851-4645-8938-6db52c09497e%2F.png&blockId=668977fd-cbd5-43a2-a99f-e7d7f95463d9](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F9e5edfdc-7851-4645-8938-6db52c09497e%2F.png&blockId=668977fd-cbd5-43a2-a99f-e7d7f95463d9)

****최대 세션 허용 개수를 초과하였을 경우의 처리 로직 2가지 전략****

1. **이전 사용자 세션 만료 전략**

*→신규 로그인시 기존 로그인 계정의 세션이 만료되도록 설정하여 기존 사용자가 자원 접근시 세션만료가 된다.*

1. **현재 사용자 인증 실패 전략**

*→ 신규 사용자가 로그인 시도시 인증 예외 발생*

****동시 세션 제어 설정하기****

시큐리티 설정 클래스에는 다음과 같이 세션관리에 대한 옵션을 설정할 수 있다.

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserDetailsService userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.sessionManagement() //세션 관리 기능이 작동함
            .invalidSessionUrl("/invalid")//세션이 유효하지 않을 때 이동 할 페이지
            .maximumSessions(1)//최대 허용 가능 세션 수, (-1: 무제한)
            .maxSessionsPreventsLogin(true)//동시 로그인 차단함, false: 기존 세션 만료(default)
            .expiredUrl("/expired");//세션이 만료된 경우 이동할 페이지
		}
}
```

****세션 고정 보호****

보호라는 말은 공격으로부터 막는다는 의미로, 악의적인 해커의 세션 고정 공격을 막기위한 대응 전략이다.

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Faebf6d70-2d1a-4a10-8f5a-98c7b36eacff%2F.png&blockId=2943c2c2-6e76-4401-8b44-2c5bc8f43092](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Faebf6d70-2d1a-4a10-8f5a-98c7b36eacff%2F.png&blockId=2943c2c2-6e76-4401-8b44-2c5bc8f43092)

세션 고정 공격 방법

****개요****

:세션 고정 공격을 방지하기 위해 세션 고정 보호가 필요하다

[data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==](data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==)

**참고:**

**세션 고정 공격이란?**

공격자가 서버에 접속을해서 JSSEIONID를 발급받아서 사용자에게 자신이 발급받은 세션쿠키를 심어놓게되면 사용자가 세션쿠키로 로그인 시도했을 경우 공격자는 같은 쿠키값으로 인증되어 있기 때문에 공격자는 사용자 정보를 공유하게 된다.

**참고: 세션 고정 보호란?**

[data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==](data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==)

사용자가 공격자 세션쿠키로 로그인을 시도하더라도 로그인시마다 새로운 세션ID를 발급하여 제공하게 되면, JSSEIONID가 다르기 때문에, 공격자는 같은 쿠키값으로 사용자 정보를 공유받을 수 없다.

****세션 고정 보호 설정하기****

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserDetailsService userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.sessionManagement()
            .sessionFixation().changeSessionId();// 기본값 -> 세션은 유지하되 세션아이디는 계속 새로 발급(servlet 3.1이상 기본 값)
                                                     // none, migrateSession, newSession
		}
}
```

- **none()**

: 세션이 새로 생성되지 않고 그대로 유지되기 때문에 세션 고정 공격에 취약하다.

- **migrateSession()**

: 새로운 세션도 생성되고 세션아이디도 발급된다. (sevlet 3.1 이하 기본 값) + 이전 세션의 속성값들도 유지된다.

- **newSession()**

: 세션이 새롭게 생성되고, 세션아이디도 발급되지만, 이전 세션의 속성값들을 유지할 수 없다.

****세션 정책****

인증처리를 할 때 꼭 스프링 시큐리티에서 세션을 생성할 필요는 없고, 오히려 외부 서비스를 통해 인증 토큰을 발급하는 방식을 사용 할 수도 있다. 예를들어 JWT 토큰을 사용하거나, KeyCloak같은 외부 서비스를 사용할수도 있다. 이런 경우에는 굳이 스프링 시큐리티를 통해 세션을 생성할 필요가 없다. 그래서 이런 세션 생성 정책도 설정을 통해 지정해 줄 수 있다.

****세션 정책 설정하기****

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserDetailsService userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.sessionManagement()// 세션 관리 기능이 작동함.
            .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED);
		}
}
```

- **SessionCreationPolicy.Always** : 스프링 시큐리티가 항상 세션 생성
- **SessionCreationPolicy.IF_REQUIRED** : 스프링 시큐리티가 필요 시 생성(default)
- **SessionCreationPolicy.Never** : 스프링 시큐리티가 생성하지 않지만 이미 존재하면 사용
- **SessionCreationPolicy.Stateless**: 스프링 시큐리티가 생성하지 않고 존재해도 사용하지 않음.
→ JWT 토큰방식을 사용할 때는 Stateless 정책을 사용한다.

## **세션 제어 필터:**

****SessionManagementFilter,****

****ConcurrentSessionFilter****

****SessionManagementFilter****

1.**세션관리** → 인증 시 사용자의 세션정보를 등록, 조회, 삭제 등의 세션 이력을 관리

2.**동시적 세션 제어** → 동일 계정으로 접속이 허용되는 최대 세션수를 제한

3.**세션 고정 보호** → 인증 할 때마다 세션 쿠키를 새로 발급하여 공격자의 쿠키 조작을 방지

4.**세션 생성 정책** → Always, if_required, Never, Stateless

****ConcurrentSessionFilter****

- 매 요청 마다 현재 사용자의 세션 만료 여부 체크
- 세션이 만료되었을 경우 즉시 만료 처리
- session.isExired() == true
- 로그아웃 처리
- 즉시 오류 페이지 응답(This session has been expired)

****SessionManagementFilter, ConcurrentSessionFilter - Flow****

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F2ec92421-a335-4b09-9b18-c4d6f35fa61c%2FSessionManagementFilterFlow.png&blockId=f1097016-5dbd-4c8b-b6ba-7042af601675](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F2ec92421-a335-4b09-9b18-c4d6f35fa61c%2FSessionManagementFilterFlow.png&blockId=f1097016-5dbd-4c8b-b6ba-7042af601675)

1. Login 시도
2. 최대 세션 허용 개수 확인
→ 최대 세션 허용 개수가 초과되었을 경우 정책별 로직 수행(이전 사용자 세션 만료/ 현재 사용자 인증 실패) : session.expireNow()
3. 이전사용자 가 자원접근(Request) 시도
4. ConcurrentSessionFilter에서 이전 사용자의 세션이 만료되었는지 확인.

    → SessionManagementFilter 안의  설정 참조

5. 로그아웃 처리 후 오류 페이지 응답
→ This session has been expired

****SessionManagementFilter, ConcurrentSessionFilter - sequence diagram****

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F178b1be5-9085-4c50-b2a5-7ff41829e3d8%2FSessionManagementFilter_sequencediagram.png&blockId=07385c53-85d1-4673-a39d-e14993510206](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F178b1be5-9085-4c50-b2a5-7ff41829e3d8%2FSessionManagementFilter_sequencediagram.png&blockId=07385c53-85d1-4673-a39d-e14993510206)

Sequence diagram

## **권한설정과 표현식**

****선언적 방식****

- URL
    - http.antMatchers("/users/**").hasRole("USER")
- Method
    - @PreAuthorize("hasRole('USER')")
    - public void user(){System.out.println("user")}

****동적 방식 - DB 연동 프로그래밍****

- URL
- Method

****권한 설정****

```java
@Override
protected void configure(HttpSecurity http) throws Exception {
    http.antMatcher("/**") //특정 경로를 지정 해당 메서드를 생략하면 모든 경로에 대해 검색하게 된다.
        .authorizeRequests() //보안 검사기능 시작
        .antMatchers("/login", "/users/**").permitAll() //해당경로에 대한 모든 접근을 하용한다.
        .antMatchers("/mypage").hasRole("USER") // /show/mypage는 USER권한을 가지고있는 사용자에게만 허용한다.
        .antMatchers("/admin/pay").access("hasRole('ADMIN')")
        .antMatchers("/admin/**").access("hasRole('ADMIN') or hasRole('SYS ')")
        .anyRequest().authenticated();
}
```

**참고:** 설정시 구체적인 경로("/admin/pay")가 먼저 설정되고 그 다음에 더 넓은 범위가 설정되고, 되야하는 이유는 불필요한 검사를 막기 위해서이다.
예를들어, .antMatchers("/admin/**").access("hasRole('ADMIN') or hasRole('SYS ')") 설정이 더 위로간다면, SYS유저는 해당 검사를 통과하고 그 아래에서 걸리게 된다.

### **인가 API**

| Method |  Action |
| --- | --- |
| authenticated()  | 인증된 사용자의 접근을 허용 |
| fullyAuthenticated() | 인증된 사용자의 접근을 허용, rememberMe 인증 제외 |
| permitAll() | 무조건 접근을 허용 |
| denyAll() | 무조건 접근을 허용하지 않음 |
| anonymous() | 익명사용자의 접근을 허용 |
| rememberMe() | 기억하기를 통해 인증된 사용자의 접근을 허용 |
| access(String) | 주어진 SpEL표현식의 평과 결과가 true이면 접근을 허용 |
| hasRole(String) | 사용자가 주어진 역할이 있다면 접근을 허용 |
| hasAuthority(String) | 사용자가 주어진 권한이 있다면 접근을 허용 |
| hasAnyRole(String...) | 사용자가 주어진 권한이 있다면 접근을 허용 |
| hasAnyAuthority(String...) | 사용자가 주어진 권한 중 어떤 것이라도 있다면 접근을 허용 |
| hasIpAddress(String) | 주어진 IP로부터 요청이 왔다면 접근을 허용. |

****예제 코드****

```java
/*Application*/
@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserDetailsService userDetailsService;


		/*메모리방식으로 사용자 생성및 비밀번호와 권한 설정 메서드*/
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
				//{noop}비밀번호 형식을 적어준 것으로 noop은 따로 인코딩방식X
        auth.inMemoryAuthentication().withUser("user").password("{noop}1111").roles("USER");
        auth.inMemoryAuthentication().withUser("sys").password("{noop}1111").roles("SYS","USER");
        auth.inMemoryAuthentication().withUser("admin").password("{noop}1111").roles("ADMIN","SYS","USER");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
            .antMatchers("/user").hasRole("USER")
            .antMatchers("/admin/pay").hasRole("ADMIN")
            .antMatchers("/admin/**").access("hasRole('ADMIN') or hasRole('SYS')")
            .anyRequest().authenticated();
        http.formLogin();
    }
}

/*Controller*/
@RestController
public class SecurityController {

    @GetMapping("/")
    public String index(){
        return "home";
    }

    @GetMapping("loginPage")
    public String loginPage(){
        return "loginPage";
    }

    @GetMapping("/user")
    public String user(){
        return "user";
    }

    @GetMapping("/admin/pay")
    public String adminPay(){
        return "adminPay";
    }

    @GetMapping("/admin/**")
    public String adminAll(){
        return "admin";
    }
}
```

- **configure()** 메서드의 순서 /admin/** 과 /admin/pay 의 순서를 바꾸면 어떻게 될 것인가?
    - SYS권한 유저가 /admin/pay 에 접근 권한 검사를 하기전 /admin/** 권한 검사에서 통과가 되버리기 때문에 /admin/pay 경로 접속이 허용되게 된다.
    그렇기 때문에 접속 권한 설정시 작은 부분에서 큰부분으로 설정을 해야 한다.

[data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==](data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==)

## **예외처리 및 요청 캐시 필터:**

****ExceptionTranslationFilter, RequestCacheAwareFilter****

SpringSecurity가 관리하는 보안 필터중 마지막 필터가 FilterSecurityInterceptor이고, 바로 전 필터가 ExceptionTranslationFilter이고 해당 필터에서 사용자의 요청을 받을 때, 그 다음 필터로 그 요청을 전달할 때 try-catch로 감싸서  FilterSecurityInterceptor 를 호출하고 있고, 해당 필터에서 생기는 인증및 인가 예외는

ExceptionTranslationFilter로 throw 하고 있다.

****AuthenticationException****

- **인증 예외 처리**
1. **AuthenticationEntryPoint 호출**
→ 로그인 페이지 이동, 401(Unauthorized) 오류 코드 전달 등
2. **인증 예외가 발생하기 전의 요청정보를 저장**

    → RequestCache - 사용자의 이전 요청 정보를 세션에 저장하고 이를 꺼내 오는 캐시 메커니즘

    → SavedRequest - 사용자가 요청했던 request 파라미터 값들, 그 당시의 헤더값들 등이 저장


****AccessDeniedException****

- **인가 예외 처리**
- AccessDeniedHandler 에서 예외 처리하도록 제공

****Flow****

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F525a086f-c98f-4eac-8b6a-aa04d509170c%2FExceptionTranslationFilterLogic.png&blockId=0b5ef82b-9221-432a-a306-030f6cd5b240](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F525a086f-c98f-4eac-8b6a-aa04d509170c%2FExceptionTranslationFilterLogic.png&blockId=0b5ef82b-9221-432a-a306-030f6cd5b240)

1. 익명 사용자가 /user에 접근을 시도한다고 가정한다.
2. FilterSecurityInterceptor 권한 필터가 해당 요청(/user)을 받았지만, 해당 유저는 인증을 받지 않은 상태.
3. 해당 필터는 인증 예외를 발생한다.
→ 정확히는 **인가 예외**를 던진다. 왜냐하면 해당 사용자는 익명(anonymouse)사용자이기에 인증을 받지 않은 상태라서 인가 예외(AccessDeniedException)로 빠진다.
4. 인가 예외(AccessDeniedException)는 익명 사용자이거나 RememberMe사용자일 경우 AccessDeniedHandler를 호출하지 않고 AuthenticationException 에서 처리하는 로직으로 보내게 된다.
5. 인증 예외 (AuthenticationException) 두 가지 일을 한다.
    - AuthenticationEntryPoint 구현체 안에서 login페이지로 리다이렉트 한다. (인증 실패 이후)
    → Security Context를 null로 초기화해주는 작업도 해준다.
    - 예외 발생 이전에 유저가 가고자 했던 요청정보를 DefaultSavedRequest객체에 저장하고 해당 객체는 Session에 저장되고 Session 에 저장하는 역할을 HttpSessionRequestCache에서 해준다.

1. 인증절차를 밟은 일반 유저가 /user자원에 접근을 시도하는데  해당 자원에 설정된 허가 권한이 ADMIN일 경우.
2. 권한이 없기 때문에 인가 예외 발생
3. AccessDeniedException이 발생한다.
4. AccessDeniedHandler 호출해서 후속작업을 처리한다.

    → 보통은 denied 페이지로 이동한다.


EX) ****API****

```java
@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserDetailsService userDetailsService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication().withUser("user").password("{noop}1111").roles("USER");
        auth.inMemoryAuthentication().withUser("sys").password("{noop}1111").roles("SYS", "USER");
        auth.inMemoryAuthentication().withUser("admin").password("{noop}1111").roles("ADMIN", "SYS", "USER");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
            .antMatchers("/login").permitAll()
            .antMatchers("/user").hasRole("USER")
            .antMatchers("/admin/**").access("hasRole('ADMIN') or hasRole('SYS')")
            .antMatchers("/admin/pay").hasRole("ADMIN")
                .anyRequest().authenticated();
        http.formLogin()
             .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest request,
                                                        HttpServletResponse response,
                                                        Authentication authentication) throws IOException, ServletException {
                        RequestCache requestCache = new HttpSessionRequestCache();
                        SavedRequest savedRequest = requestCache.getRequest(request, response);
                        String redirectUrl = savedRequest.getRedirectUrl();
                        response.sendRedirect(redirectUrl);
                    }
                });

        http.exceptionHandling() //예외처리 기능이 작동
            .authenticationEntryPoint(new AuthenticationEntryPoint() {
                    @Override
                    public void commence(HttpServletRequest request,
                                         HttpServletResponse response,
                                         AuthenticationException authException) throws IOException, ServletException {
                        response.sendRedirect("/login");
                    }
                }) //인증실패 시 처리
           .accessDeniedHandler(new AccessDeniedHandler() {
                    @Override
                    public void handle(HttpServletRequest request,
                                       HttpServletResponse response,
                                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
                        response.sendRedirect("/denied");
                    }
                });//인증실패 시 처리

    }
```

→ 살펴봐야 할 부분은 successHandler 의 onAuthenticationSuccess() 메서드 로직과 authenticationEntryPoint(), accessDeniedhandler()내부의 구현 메서드들이다.

1. **onAuthenticationSuccess**
→ savedRequest객체에 RequestCache객체가 담고 있는 사용자가 원래 가려던(요청하려던) 자원의 요청정보를 가져와 활용할 수 있도록 한다.
2. **AuthenticationEntryPoint**
→ 인증예외 발생시 수행 메서드(commence) 오버라이딩. 해당 코드에서는 login페이지로 이동시키지만 다른 로직을 수행할 수도 있다.
3. **AccessDeniedHandler**
→ 인가예외 발생시 처리 로직 수행 해당 코드에서는 denied페이지로 이동하지만 별도로 다른 로직을 수행할 수 있다.

****Sequence Diagram****

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F2f45d333-c751-4dde-8921-5b63b74b1273%2FExceptionTranslationFilter_sequenceDiagram.png&blockId=9c203dbb-62bd-4c57-b3e5-e2165d407993](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F2f45d333-c751-4dde-8921-5b63b74b1273%2FExceptionTranslationFilter_sequenceDiagram.png&blockId=9c203dbb-62bd-4c57-b3e5-e2165d407993)

## **사이트 간 요청 위조:**

****CSRF, CsrfFilter****

[https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F0051d4c0-bf41-4183-83fe-eb3a4acec0ba%2FCSRF_image.png&blockId=c8fae8d8-a9f8-4a79-909d-e70e5f8b62eb](https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F0051d4c0-bf41-4183-83fe-eb3a4acec0ba%2FCSRF_image.png&blockId=c8fae8d8-a9f8-4a79-909d-e70e5f8b62eb)

: 사용자가 쇼핑몰에 접속하여 로그인 후 쿠키를 발급받은 뒤 공격자가 사용자의 이메일로 특정 링크를 전달하고 사용자가 해당 링크를 클릭하게 되면, 공격용 웹페이지에 접속하게 되고, 해당페이지에 '로또당첨'이라는 이미지가 노출된다.  그리고 유저가 로또당첨 이미지를 클릭하면 쇼핑몰에 특정 URL로 요청을 하게되는데 해당 쿠키정보를 가지고 있기 때문에 해당 요청에 대해서 정상적으로 동작을 하게 된다.

**이처럼 사용자의 의도와는 무관하게 공격자가 심어놓은 특정 방식을 통해 자원 요청을 하게되고 그것을 응답을 받을 수 있도록 하는 것을 CSRF(사이트 간 요청 위조) 라 한다.**

****CsrfFilter****

- 모든 요청에 랜덤하게 생성된 토큰을 HTTP 파라미터로 요구
- 요청 시 전달되는 토큰 값과 서버에 저장된 실제 값과 비교한 후 만약 일치하지 않으면 요청은 실패한다.
- Client

```groovy
<input type="hidden" name="${csrf.parameterName}" value="${_csrf.token}"/>
```

HTML

- HTTP 메소드:  PATCH, POST, PUT, DELETE
- Spring Security
    - http.csrf(): 기본 활성화되어 있음
    - http.csrf().disabled(): 비활성화

## 🤷🏻‍♂️ OAuth 2.0

### 기본 개념

기본적으로 OAuth (OpenID Authentication) 란, 타사의 사이트에 대한 접근 권한을 얻고 그 권한을 이용하여 개발할 수 있도록 도와주는 프레임워크다. 구글, 카카오, 네이버 등과 같은 사이트에서 로그인을 하면 직접 구현한 사이트에서도 로그인 인증을 받을 수 있도록 되는 구조다.

물론 구글에서 로그인을 했다고 해서, 개발한 웹 사이트에 구글 ID와 PW를 그대로 전달해주면 안되므로, Access Token을 발급 받고, 그 토큰을 기반으로 원하는 기능을 구현해야 한다.

Access Token은 로그인을 하지 않고 인증을 할 수 있도록 해주는 인증 토큰 정도의 개념이다. 유저 `A`가 직접 개발한 웹 사이트 `X`에서 자신의 구글 캘린더에 대한 접근을 허용해 준다면, Access Token을 통해 해당 정보 권한을 받아올 수 있어서 그 정보를 토대로 캘린더에 글을 작성하고 삭제하는 등의 작업을 할 수 있게 된다.

### 📎 주요 키워드

여기서 Access Token을 발급 받기 위한 일련의 과정들을 인터페이스로 정의해둔 것이 바로 OAuth 다. OAuth에서 중요한 용어는 크게 세 가지다.

- `Resource Owner`: 개인 정보의 소유자를 가리킨다. 유저 `A`가 이에 해당한다.
- `Client`: 제 3의 서비스로부터 인증을 받고자 하는 서버다. 직접 개발한 웹 사이트 `X`가 이에 해당한다.
- `Resource Server`: 개인 정보를 저장하고 있는 서버를 의미한다. 구글이 이에 해당한다.

유저 `A`가 구글에서 제공해주는 서비스를 이용하는 셈이므로 타 사의 서비스를 이용하기 위해서는 신청을 해야 한다. 신청 방법은 구글, 카카오, 네이버, 페이스북 등 각각 모두 방식이 다르지만, 반드시 필요로 하는 내용은 ID, PW, 본인 인증 방법 이렇게 세 가지 정도다. 각 사이트의 개발자 Docs를 참고하면 쉽게 등록하고 발급받을 수 있다.

- `Client ID`: Resource Server에서 발급해주는 ID. 웹 사이트 `X`에 구글이 할당한 ID를 알려주는 것이다.
- `Client Secret`: Resource Server에서 발급해주는 PW. 웹 사이트 `X`에 구글이 할당한 PW를 알려주는 것이다.
- `Authorized Redirect Uri`: Client 측에서 등록하는 Url. 만약 이 Uri로부터 인증을 요구하는 것이 아니라면, Resource Server는 해당 요청을 무시한다.

### 예시 동작 설명

Client, 즉 직접 개발한 웹 사이트 `X`가 Resource Server에 등록이 완료되었다면, 이제 Access Token을 발급 받을 수 있다. 구글을 예시로 계속 설명하자면, 유저 `A`가 웹 사이트 `X`에서 특정 기능을 이용하기 위해서 로그인이 요구되고, 구글 인증 Access Token을 받기 위해 구글 로그인 링크로 연결된다.

예시 링크(`https://accounts.google.com/?client_id=123&scope=profile,email&redirect_uri=http://localhost`)의 쿼리 스트링을 살펴보면, `client_id`는 `123`, `scope`는 `profile`과 `email`, `redirect_uri`는 `http://localhost`임을 알 수 있다.

유저 `A`가 구글 로그인을 정상적으로 했다면, 구글은 이전에 등록되었던 `client_id=123`인 서버의 `redirect_uri`와 동일한지 확인한다.

일치하는 경우, 유저 `A`에게 `scope=profile,email` 기능을 넘겨줄 것인지에 대한 승인 여부를 불어보고, 동의한다면 구글은 이에 해당하는 `authorization_code`라는 임시 PW를 발급한다.

이후 `http://localhost/?authorization_code=2`으로 리다이렉트되며, 웹 사이트 `X`의 서버는 이 `authorization_code`를 가지고 구글에게 Access Token을 요청한다. 그리고 유저 `A`의 인증이 필요할 때마다 Access Token을 이용하여 접근한다.

### 🔍  서버 기반 인증 방식

먼저 서버 기반 인증 방식에 대해 알아야 한다. 서버 기반 인증 방식의 핵심은 서버 측에 사용자 정보를 저장하는 것이다. Spring Security에서는 별도의 설정이 없다면 세션을 이용하여 처리한다. 즉, 사용자가 로그인을 하면 서버는 해당 사용자의 세션을 만들고, 서버의 메모리와 데이터베이스에 저장한다. 만약 마이크로 서비스 개발을 진행하거나 서버를 확장하게 된다면, 모든 서버에게 세션의 정보를 공유해야 하므로 이를 위한 별도의 중앙 세션 관리 서버를 두곤 한다.

### 🔍  Access Token과 Refresh Token

Access Token은 리소스 (사용자 정보) 에 직접 접근할 수 있도록 해주는 정보만을 가지고 있다. Refresh Token에 비해 짧은 만료 기간을 가지며, 주로 세션에 담아 관리한다.

Refresh Token은 새로운 Access Token을 발급받기 위한 정보를 담고 있다. 클라이언트가 Access Token이 없거나 만료된 상태라면, Refresh Token을 통해 Auth Server에 요청하여 새로운 Access Token을 발급 받을 수 있다. Refresh Token은 외부에 노출되지 않도록 하기 위해 보통은 DB에 저장하곤 한다.

### 🔍  OAuth 2.0

위에서 설명했듯이 구글, 카카오 등에서 제공하는 Authorization Server를 통해 회원 정보를 인증하고 Access Token을 발급 받는다. 그리고 발급 받은 Access Token을 이용해 직접 개발한 서버의 API 서비스를 이용 및 호출한다. 마이크로 서비스이거나 서버 간의 통신이 잦은 경우, Access Token을 자주 주고 받을 수 밖에 없다.

그리고 각 서버는 API 호출 요청에 대해서 전달 받은 Access Token이 유효한 지를 확인해야 한다. 이는 서버에서 클라이언트의 상태 (Access Token의 유효성) 를 관리하게끔 하며, 또 API를 호출할 때마다 Access Token이 유효한지 매번 DB에서 조회하고 새로 갱신 시 업데이트 작업을 해주어야 한다. 즉, 클라이언트 상태를 관리 및 공유할 추가적인 저장 공간과 매번 요청마다 Access Token의 검증 및 업데이트를 위한 DB 호출이 발생하는 구조다.

마이크로 서비스 개발처럼, 서버의 수가 많은 경우에는 각각의 서버가 Access Token의 유효성 및 권한 확인을 Auth Server에 요청하기 때문에 병목 현상 등이 발생해, 서버의 부하로 이어질 수 있다. 이 문제점을 해소하기 위해 JWT 기반 인증을 도입한다.

### 🔍  JWT

JWT는 Claim 기반 방식을 사용한다. 여기서 Claim이란 사용자에 대한 속성 값들을 가리킨다. 즉, JWT은 의미있는 토큰 (사용자의 상태를 포함) 으로 구성되어 있기 때문에, Auth Server에 검증 요청을 보내야만 했던 과정을 생략하고 각 서버에서 수행할 수 있게 되어 비용 절감 및 Stateless 아키텍처를 구성할 수 있다.

- 클라이언트 (사용자) 는 Auth Server에 로그인을 한다.
- Auth Server에서 인증을 완료한 사용자는 JWT 토큰을 전달 받는다.
- 클라이언트는 특정 애플리케이션 서버에 리소스 (서비스에 필요한 데이터) 를 요청할 때, 앞서 전달 받은 JWT 토큰을 Authorization Header에 넣어 전달한다.
- 애플리케이션 서버는 전달 받은 JWT 토큰의 유효성을 직접 검사하여 사용자 인증을 할 수 있다.

JWT 방식은 확장성에 큰 강점을 가진다. 만약 세션을 사용하는 경우, 서버를 확장할 때마다 각 서버에 세션 정보를 저장하게 된다. 이렇게 될 경우, 특정 서버에서 로그인 인증을 받을 때 다른 서버에서는 로그인을 했는지 알 수 없다는 단점이 있다. 하지만 JWT는 서버의 수와는 상관없이 토큰을 인증하는 방식을 알고 있다면 인증 과정에 문제가 없다. 더불어, 웹과 앱 간의 쿠키 세션 처리에도 유용하다. 브라우저와 앱에서의 쿠키 처리 방법은 각기 다를 수 있기 떄문에 JWT를 이용하는 것이 다양한 디바이스 차원에서 좋다.

고려해야 할 점은, 사용자 인증 정보가 필요한 요청을 보낼 때 헤더에 JWT 토큰 값을 넣어 보내야 하기 때문에 데이터가 증가하여 네트워크 부하가 늘어날 수 있다. 또한 토큰 자체에 사용자 정보를 담고 있기 때문에 JWT가 만료되기 전에 탈취당하면 서버에서 처리할 수 있는 일이 없다. JWT 방식은 한 번 만들어 클라이언트에게 전달하면 제어가 불가능하기 때문에 만료 시간을 필수적으로 넣어 주어야 한다.

이번 세미나에서 준비한 방식은 짧은 만료 기간을 갖는 JWT 형식의 Access Token과 긴 만료 기간을 갖는 JWT 형식의 Refresh Token, 두 가지 토큰을 사용하려 한다. 이렇게 구성한다면 아무래도 Refresh Token을 DB에 저장하고 새로운 Access Token을 발급하기 위해 거쳐야 하는 추가적인 과정이 생기게 된다.

만약 Access Token만을 이용해 사용자 인증을 관리하려 할 때, 두 가지 경우가 가능하다. 첫번째는 Access Token의 만료 기간을 짧게 설정하여 사용자가 자주 로그인을 해야하는 경우, 그리고 두번째는 Access Token의 만료 기간을 길게 설정하여 사용자가 로그인하는 빈도는 줄어들지만 토큰이 탈취된다면 긴 만료 기간만큼 위험에 노출되는 경우다.

다른 대안들을 찾아보았지만, 결국 보안성과 편의성 (혹은 성능) 관점에서 Trade Off 가 존재한다. 그래서 적절한 협의점인, Refresh Token을 관리하는 방법을 택한 것이다.