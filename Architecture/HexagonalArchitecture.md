## Hexagonal Architecture (헥사고날 아키텍쳐)
헥사고날 아키텍쳐는 인터페이스 기반 요소에 영향을 받지 않는 핵심 코드를 만들 이를 견고하게 관리하는것이 목표인 아키텍쳐이다.   
애플리케이션 내부로직과 외부요소를 분리하여 보다 유연하고 확장 가능하며 테스트가 가능한 애플리케이션을 만드는게 목표인 아키텍쳐이다.
그리고 헥사고날 아키텍쳐는 "**포트 어댑터 아키텍쳐**" 하고 불리기도 한다.

헥사고날 아키텍쳐의 핵심은 내부로직과 외부요소의 경계를 명확히 구분해서 외부 시스템이 내부 로직에 미치는 영향을 최소화 하는것이다.
<img width="896" alt="스크린샷 2024-09-14 오후 3 35 42" src="https://github.com/user-attachments/assets/c57fa489-fa31-49c4-87c0-d0a80fd3c715">  
### 구조적 특징

헥사고날 아키텍처는 일반적으로 6면체의 다이어그램으로 표현되며, 각 면은 포트에 대응된다. 중심에는 애플리케이션의 비즈니스 로직이 있으며, 그 외곽에 포트와 어댑터가 둘러싸고 있다. 
외부 시스템(사용자 인터페이스, 데이터베이스, 외부 API 등)은 어댑터를 통해 포트에 연결된다.

### 1. 포트 (Ports)  
포트는 헥사고날 아키텍처에서 가장 중요한 추상화 레이어로, 애플리케이션 코어(핵심 비즈니스 로직)와 외부 시스템(데이터베이스, API, UI 등) 간의 통신 경계 역할을 한다.

- 입력 포트(Input Ports): 외부에서 들어오는 요청을 처리하기 위한 인터페이스로, 애플리케이션의 비즈니스 로직을 외부에서 접근할 수 있게 만드는 역할을 한다. 예를 들어, 사용자가 웹 브라우저를 통해 요청을 보내면, 이 요청이 애플리케이션의 비즈니스 로직으로 전달되기 위한 경로다.
- 출력 포트(Output Ports): 애플리케이션이 외부 시스템과 상호작용할 때 사용하는 인터페이스다. 데이터베이스나 외부 API와 통신할 때, 출력 포트는 이러한 외부 시스템과의 상호작용을 추상화하여 애플리케이션 로직이 직접적으로 외부 시스템에 의존하지 않게 한다.

#### **포트의 핵심 역할은 외부와의 의존성을 최소화하고, 비즈니스 로직이 외부 기술에 종속되지 않도록 인터페이스로 분리하는 역할을 한다.**

### 2. 어댑터 (Adapters)

어댑터는 포트와 외부 시스템을 구체적으로 구현하여 연결하는 부분이다. 어댑터는 포트를 통해 비즈니스 로직과 외부 시스템 간의 통신을 가능하게 하며, 외부 시스템의 구체적인 구현 세부 사항을 처리한다.

- 입력 어댑터(Input Adapters): 외부로부터 들어오는 요청을 받아 입력 포트를 호출하는 역할을 한다. 예를 들어, 웹 요청을 처리하는 컨트롤러(Controller)나 메시지 큐 소비자가 입력 어댑터의 예다. 사용자의 입력을 받아 내부 비즈니스 로직으로 전달하는 역할을 한다.
- 출력 어댑터(Output Adapters): 애플리케이션이 외부 시스템(데이터베이스, 외부 API 등)과 상호작용할 때 출력 포트를 통해 데이터를 주고받는 역할을 한다. 예를 들어, 데이터베이스 접근 레이어, 외부 API 호출 클라이언트 등이 출력 어댑터로 동작한다.

#### **어댑터의 핵심 역할은 외부 시스템과의 상호작용을 처리하여, 애플리케이션 내부의 비즈니스 로직이 외부 시스템의 세부 구현에 영향을 받지 않도록 한다.**

### 3. 유즈케이스 (Use Case)

유즈케이스는 헥사고날 아키텍처에서 비즈니스 로직을 구현하는 부분이다. 유즈케이스는 애플리케이션이 제공하는 기능적 요구 사항을 처리하며, 사용자의 요청에 따라 비즈니스 로직을 실행하고, 필요한 데이터 또는 결과를 반환한다.

- 유즈케이스는 도메인 계층의 엔티티를 사용하여 비즈니스 로직을 처리하고, 출력 포트를 통해 외부 시스템과 상호작용한다.
- 유즈케이스는 애플리케이션의 특정 작업을 수행하는 방법을 정의한다. 예를 들어, “사용자 생성”, “주문 처리”와 같은 애플리케이션의 주요 기능이 유즈케이스로 정의된다.

#### **유즈케이스는 애플리케이션이 “무엇을” 해야 하는지 정의하고, 이 비즈니스 로직이 외부 시스템과 상호작용할 때 포트를 사용하여 통신하는 역할을 한다.**

### 4. 엔티티 (Entities)

엔티티는 애플리케이션의 비즈니스 도메인을 표현하는 객체로, 애플리케이션에서 핵심적인 데이터와 그와 관련된 비즈니스 규칙을 캡슐화한다. 엔티티는 도메인 모델의 중심으로, 비즈니스의 중요한 개념(예: User, Order, Product)을 나타낸다.

- 엔티티는 고유한 식별자를 가지고 있으며, 비즈니스 로직에서 중요한 역할을 한다. 예를 들어, User 엔티티는 사용자 정보를 담고 있으며, 그 사용자가 애플리케이션 내에서 수행할 수 있는 행동이나 비즈니스 규칙을 관리한다.
- 엔티티는 애플리케이션의 도메인 계층에서 사용되며, 유즈케이스에서 비즈니스 로직을 처리할 때 중요한 역할을 한다.

#### **엔티티는 애플리케이션의 비즈니스 규칙과 도메인 상태를 정의하고 유지하는 중요한 객체다.**


핵사고날 아키텍쳐에서 Java/Spring을 사용 할 때 권장하는 패키지 구조를 한번 보자 (말 그대로 권장 사항이다. 본인 프로젝트에 맞게 커스텀은 얼마든지 가능하다.)
```
com.example.project
│
├── application
│   ├── service
│   ├── dto
│   └── port
│       ├── input
│       └── output
│
├── domain
│   ├── model
│   └── repository
│
├── infrastructure
│   ├── adapter
│       ├── input
│       └── output
│   └── configuration
│
└── web
    ├── controller
    ├── dto
    └── exception
```
우선 패키지별로 하는 역할에 대해서 알아보자 
### ⚒️ application  
**application layer**은 비즈니스 로직을 담당하는 핵심 계층이다. 헥사고날아키텍쳐에서 application layer는 외부의 영향을 받지 않는다.  

각 패키지의 역할들을 보자   
- service : 애플리케이션의 주요 비즈니스 로직을 처리하는 서비스 클래스가 위치한다.
- dto : Data Transfer Object로, 데이터 교환을 위한 객체를 정의한다. 애플리케이션에서 외부 시스템과 데이터를 주고받을 때 사용된다.
- port :
  - input : 외부에서 애플리케이션으로 들어오는 요청을 처리하는 입력 포트. 서비스 계층에서 사용하는 인터페이스들이 이곳에 위치한다.
``` java
//입력포트로서 값을 받아 처리한다.
public interface UserService {
    UserDto getUserById(Long id);
    void createUser(UserDto userDto);
}
```    
  - output : 애플리케이션이 외부 시스템(데이터베이스, 외부 API 등)과 상호작용할 때 사용하는 출력 포트. 외부 의존성과 상호작용하는 부분이 추상화되어 여기에 정의된다.
```java
//출력 포트로서 DB와 통신한다.
public interface UserRepository {
    User save(User user);
    Optional<User> findById(Long id);
}
```
  위 그림에서 보이는 계층 중에서 application 계층은 UseCase에 속한다.
### ⚒️ domain
```java
//주된 객체가 되는 도메인 모델이다.
public class User {
    private Long id;
    private String name;
    private String email;
    // Constructors, getters, setters
}
```
```도메인 계층은 비즈니스 규칙과 엔티티를 담고 있는 부분이다. 이는 애플리케이션의 중심부로, 모든 비즈니스 로직의 핵심을 이루며 외부 시스템과는 독립적이다.```

- model: 애플리케이션의 핵심 비즈니스 모델(도메인 엔티티)을 정의한다. 예를 들어, User, Order 등의 엔티티가 이곳에 포함된다.
- repository: 도메인에서 사용하는 저장소 인터페이스. 데이터베이스와의 상호작용을 위한 인터페이스가 여기에 정의된다.
### ⚒️ infrastructure

```인프라스트럭처 계층은 외부 시스템과의 연결을 담당하는 계층이다. 데이터베이스, 외부 API, 메시징 시스템 등과의 통신을 여기서 처리하며, 헥사고날 아키텍처에서 말하는 어댑터가 위치하는 곳이다.```  
- adapter
  - input: 외부에서 들어오는 요청을 처리하는 입력 어댑터. 예를 들어, REST 컨트롤러, 메시지 큐 소비자, 스케줄러 등이 해당된다.
```java
package com.example.web.controller;

import com.example.application.port.input.UserService;
import com.example.application.dto.UserDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 사용자 생성 (입력 요청)
    @PostMapping
    public ResponseEntity<Void> createUser(@RequestBody UserDto userDto) {
        userService.createUser(userDto);  // 입력 포트(UserService)를 호출
        return ResponseEntity.ok().build();
    }

    // 모든 사용자 조회 (입력 요청)
    @GetMapping
    public ResponseEntity<List<UserDto>> getAllUsers() {
        List<UserDto> users = userService.getAllUsers();  // 입력 포트(UserService)를 호출
        return ResponseEntity.ok(users);
    }

    // 특정 사용자 조회 (입력 요청)
    @GetMapping("/{id}")
    public ResponseEntity<UserDto> getUserById(@PathVariable Long id) {
        UserDto user = userService.getUserById(id);  // 입력 포트(UserService)를 호출
        return ResponseEntity.ok(user);
    }

    // 사용자 업데이트 (입력 요청)
    @PutMapping("/{id}")
    public ResponseEntity<Void> updateUser(@PathVariable Long id, @RequestBody UserDto userDto) {
        userService.updateUser(id, userDto);  // 입력 포트(UserService)를 호출
        return ResponseEntity.ok().build();
    }

    // 사용자 삭제 (입력 요청)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);  // 입력 포트(UserService)를 호출
        return ResponseEntity.ok().build();
    }
}
```
  - output: 애플리케이션이 외부로 데이터를 보낼 때 사용하는 출력 어댑터. 예를 들어, 데이터베이스에 데이터를 저장하는 JPA 리포지토리, 외부 API 호출 클라이언트 등이 여기에 포함된다.
```java
  JPA 리포지토리를 사용해 데이터베이스와 상호작용하는 로직을 구현한다.
  @Repository
public class UserRepositoryImpl implements UserRepository {
    private final JpaUserRepository jpaUserRepository;

    public UserRepositoryImpl(JpaUserRepository jpaUserRepository) {
        this.jpaUserRepository = jpaUserRepository;
    }

    @Override
    public User save(User user) {
        return jpaUserRepository.save(user);
    }

    @Override
    public Optional<User> findById(Long id) {
        return jpaUserRepository.findById(id);
    }
}
```
  - configuration: Spring의 @Configuration 클래스나 외부 서비스와 관련된 설정 파일들이 이곳에 위치한다. 예를 들어, Bean 등록, 외부 시스템과의 연결 설정 등을 처리한다.
 
### 🌐 web (프레젠테이션 레이어)

```웹 계층은 사용자와의 상호작용을 처리하는 부분으로, 주로 REST API 요청을 받아 비즈니스 로직을 호출하는 역할을 한다. 이 계층은 헥사고날 아키텍처의 입력 어댑터로 동작한다.```

- controller: Spring MVC 컨트롤러가 위치하는 곳이다. 사용자의 요청을 받아서 애플리케이션의 비즈니스 로직에 전달하는 역할을 한다.
```java
@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 사용자 생성
    @PostMapping
    public ResponseEntity<Void> createUser(@RequestBody UserDto userDto) {
        userService.createUser(userDto); // 비즈니스 로직 실행 (입력 포트 호출)
        return ResponseEntity.ok().build(); // 응답 처리
    }
}
```
- dto: 웹 계층에서 사용되는 요청과 응답 데이터를 정의한다.
```java
@Getter
@Setter
@NoArgsConstructure
@AllArgsConstructure
public class UserDto {

    private Long id;
    private String name;
    private String email;
}
```
- exception: 웹 계층에서 발생하는 예외 처리를 관리한다. 주로 전역 예외 핸들러가 이곳에 위치한다.
```java 
@ControllerAdvice
public class GlobalExceptionHandler {

    // 사용자 정의 예외 처리
    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<String> handleUserNotFoundException(UserNotFoundException ex) {
        return new ResponseEntity<>(ex.getMessage(), HttpStatus.NOT_FOUND); // 404 에러 반환
    }

}
```

-------------------
### 마무리
헥사고날 아키텍쳐의 구조를 전체적으로 뜯어보았다. 다른 방식의 헥사고날도 있겠지만 권장되는 방식을 위주로 해서 조금 아쉬운 부분은 있지만 본인이 개선 해가면서 더 나은 아키텍쳐를 개발하길 바란다 !^
아키텍쳐에 노력을 들일수록 모든 상황이 좋아지는 것은 아니라 생각을 한다. 하지만, 아키텍쳐 패턴을 통해 규칙을 정하고 규칙에 따라 개발을하게 된다면 그리고 유지보수가 좋아지고, 예상 가능한 위치에 패키지나 클래스가 그리고 함수가 있다면 노력할 만한 가치가 있다 생각을 한다.

헥사고날 아키텍쳐가 정답은 아니지만, “상황에 따라 다르다”라는 말이 있듯이 상황에 맞게 사용을 할 수 있을 것 같습니다.
