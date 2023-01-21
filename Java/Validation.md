# Validation


일반적인 애플리케이션에서 데이터 유효성 검사 로직은 다음과 같은 문제를 가지고 있다.

1. 애플리케이션 전체에 분산되어 있다.
2. 코드 중복이 심하다.
3. 비즈니스 로직에 섞여있어 검사 로직 추척이 어렵고 애플리케이션이 복잡해진다.

이러한 문제 때문에 데이터 유효성 검사 로직에 기능을 추가, 수정하기 어렵고, 오류가 발생할 가능성도 크다.

# 해결 방법

Java에서는 2009년부터 Bean Validation이라는 데이터 유효성 검사 프레임워크를 제공하고 있다. Bean Validation은 위에서 말한 문제들을 해결하기 위해 다양한 제약(Contraint)을 도메인 모델(Domain Model)에 어노테이션(Annotation)로 정의할 수 있게한다. 이 제약을 유효성 검사가 필요한 객체에 직접 정의하는 방법으로 기존 유효성 검사 로직의 문제를 해결한다.

# 시작하기

# 1. 설치

Spring Boot Validation Starter를 추가한다. (Bean Validation 구현체로 Hibernate Validator를 사용한다.)

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>

```

# 2. 제약 설정과 검사

다음은 Bean Validation에서 제공하는 '@Length', '@NotBlank', '@NotNull' 제약을 CreateContact(연락처 생성 기능에 대한 도메인 모델)에 설정한 예다.

```java
public class CreateContact {

	@Length(max = 64)// 최대 길이 64@NotBlank// 빈문자열은 안됨private String uid;
	@NotNull// null 안됨private ContactType contactType;
	@Length(max = 1_600)// 최대 길이 1,600
	private String contact;

}

```

다음은 CreateContact에 값을 입력하고 유효성 검사를 검증하는 코드다.

```java
@BeforeClass
public static void beforeClass() {
        Locale.setDefault(Locale.US);// locale 설정에 따라 에러 메시지가 달라진다.
    }

@Testpublicvoidtest_validate() {
// Givenfinal Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

final CreateContact createContact = CreateContact
            .builder()
            .uid(null)// @NotBlank가 정의되어 있기때문에 null이 오면 안된다.
            .contact("000")
            .contactType(ContactType.PHONE_NUMBER)
            .build();

// When
final Collection<ConstraintViolation<CreateContact>> constraintViolations = validator.validate(createContact);

// Then
        assertEquals(1, constraintViolations.size());// ConstraintViolation에 실패에 대한 정보가 담긴다.
        assertEquals("must not be blank", constraintViolations.iterator().next().getMessage());
    }

```

# 기능 소개

# 1. Spring에서 사용하기

다양한 기능을 알아보기 전에 Spring에서 Bean Validation을 어떻게 쓰는지 알아보겠다. 의존성에 'spring-boot-starter-validation'을 추가했다면 바로 사용할 수 있다. Service나 Bean에서 사용하기 위해서는 '@Validated'와 '@Valid'를 추가해야 한다.

```java
@Validated// 여기에 추가
@Service
public class ContactService {

	public void createContact(@Valid CreateContact createContact) {
		// '@Valid'가 설정된 메서드가 호출될 때 유효성 검사를 진행한다.// Do Something
    }
}

```

Controller는 '@Validated'가 필요 없다. 검사를 진행할 곳에 '@Valid'를 추가하면 된다.

```java
@PostMapping("/contacts")
public Response createContact(@Valid CreateContact createContact) {// 메서드 호출 시 유효성 검사 진행return Response
            .builder()
            .header(Header
                .builder()
                .isSuccessful(true)
                .resultCode(0)
                .resultMessage("success")
                .build())
            .build();
    }

```

여기서 주의할 점은 데이터 유효성 검사를 진행할 때 검사가 중복으로 실행되지 않도록 해야 한다는 것이다. 같은 데이터 유효성 검사가 여러 번 실행될 경우 애플리케이션 성능에 영향을 미칠 수 있다는 점을 명심해야 한다.

# 2. 컨테이너(컬렉션, 맵, ...)

컨테이너(Container)의 요소(Element)에 대해서도 유효성 검사가 필요할 때가 있다. Bean Validation 2.0부터 컨테이너의 요소에 대해 유효성 검사가 가능해졌다. 아래와 같이 제약을 정의할 수 있다.

```java
public class DeleteContacts {
	@Min(1)
	private Collection<@Length(max = 64)@NotBlank String> uids;
}

```

# 3. 사용자 정의 제약(Custom Constraint)

CreateContact의 uid 속성에 이모지(Emoji) 문자 사용을 못 하게 제약을 추가한다고 하자. Bean Validation에서 제공하는 제약 중에 이런 제약은 없다. 대신 Bean Validation에서는 필요한 제약을 직접 정의해서 사용할 수 있도록 기능을 제공한다. 다음과 같이 임의의 제약(Constraint)과 검증자(Validator)를 구현할 수 있다.

```java
@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE})
@Retention(RUNTIME)
@Constraint(validatedBy = NoEmojiValidator.class)
@Documented
public @interface NoEmoji{
    Stringmessage()default "Emoji is not allowed";

    Class<?>[] groups()default {};

    Class<? extends Payload>[] payload()default {};

@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER})
@Retention(RUNTIME)
@Documented
@interface List{
        NoEmoji[] value();
    }
}

```

```java
public class NoEmojiValidatorimplementsConstraintValidator<NoEmoji,String> {
	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
			if (StringUtils.isEmpty(value) ==true) {
				returntrue;
        }

			return EmojiParser.parseToAliases(value).equals(value);
    }
}

```

다른 제약과 마찬가지로 검사할 속성에 설정한다.

```java
public classC reateContact {
@NoEmoji@Length(max = 64)
@NotBlankprivate String uid;
@NotNullprivate ContactType contactType;
@Length(max = 1_600)
private String contact;
}

```

# 4. 제약 그룹(Grouping)

다음과 같이 메시지 발송에 사용되는 도메인 모델 Message가 있다. 메시지에는 일반과 광고 메시지가 있고, 광고 메시지인 경우 연락처(contact), 광고 제거 가이드(removeGuide) 속성에 값을 설정해야 한다고 하자. 하나의 도메인 모델에 두 가지 경우(일반, 광고)에 대해 데이터 유효성 검사를 해야 한다. 이런 경우에 제약을 묶어주는 Grouping 기능을 사용할 수 있다.

```java
public class Message {

	@Length(max = 128)
	@NotEmptyprivate String title;
	@Length(max = 1024)
	@NotEmptyprivate String body;
	@Length(max = 32, groups = Ad.class)
	@NotEmpty(groups = Ad.class)// 그룹을 지정할 수 있다. (기본 값은 javax.validation.groups.Default)private String contact;
	@Length(max = 64, groups = Ad.class)
	@NotEmpty(groups = Ad.class)
	private String removeGuide;

}

```

'Ad.class'는 단순히 그룹을 지정하기 위한 마커 인터페이스(Marker Interface)다.

```java
public interface Ad {
}

```

그룹이 지정된 Message의 유효성을 검사할 메서드는 다음과 같이 지정할 수 있다. 메서드에 검사할 그룹을 지정한 '@Validated(Ad.class)'를 추가한다.

```java
@Validated
@Service
public class MessageService {

	@Validated(Ad.class)// 메서드 호출 시 Ad 그룹이 지정된 제약만 검사한다.
	public void sendAdMessage(@Valid Message message) {
// Do Something
    }

	public void sendNormalMessage(@Valid Message message) {
// Do Something
    }

/**
     * 주의: 이렇게 호출하면 Spring AOP Proxy 구조상 @Valid를 설정한 메서드가 호출되어도 유효성 검사가 동작하지 않는다.
     * Spring의 AOP Proxy 구조에 대한 설명은 다음 링크를 참고하자.
     * - https://docs.spring.io/spring/docs/5.2.3.RELEASE/spring-framework-reference/core.html#aop-understanding-aop-proxies
     */
public void sendMessage(Message message,boolean isAd) {
			if (isAd) {
            sendAdMessage(message);
        }else {
            sendNormalMessage(message);
        }
    }

```

# 5. 클래스 단위 제약(Class Level Constraint)과 조건부 검사(Conditional Validation)

도메인 모델의 속성의 값에 따라 데이터 유효성 검사를 다르게 해야 되는 경우도 있다. 즉, 런타임에 속성의 값에 따라 데이터 유효성 검사 방법이 결정되는 경우다. 예를 들어 아래와 같이 광고 메시지 여부를 나태내는 속성(isAd)이 Message에 추가되고, 이 속성 값에 따라 연락처(contact), 광고 제거 가이드(removeGuide) 속성을 검사해야 된다고 해보자. 이 경우 새로운 클래스 단위의 제약을 구현해 해결할 수 있다.

```java
@AdMessageConstraint// 이 커스텀 제약을 구현할 것이다.
public class Message {
	@Length(max = 128)
	@NotEmptyprivate String title;
	@Length(max = 1024)
	@NotEmptyprivate String body;
	@Length(max = 32, groups = Ad.class)
	@NotEmpty(groups = Ad.class)
	private String contact;

	@Length(max = 64, groups = Ad.class)
	@NotEmpty(groups = Ad.class)
	private String removeGuide;

	private boolean isAd;// 광고 여부를 설정할 수 있는 속성
}

```

다음과 같이 새로운 제약을 구현한다.

```
@Target({TYPE})
@Retention(RUNTIME)
@Constraint(validatedBy = AdMessageConstraintValidator.class)
@Documentedpublic@interface AdMessageConstraint {
    Stringmessage()default "";

    Class<?>[] groups()default {};

    Class<? extends Payload>[] payload()default {};
}

```

아래 AdMessageConstraintValidator 구현 부분이 중요하다. isAd 속성이 참일 때 Group이 Ad로 설정된 속성들을 검사해야 한다. 이를 위해 생성자에서 Validator를 받는다. 그리고 isValid 메서드에서 Validator로 유효성 검사를 진행하고 결과를 다시 ConstraintValidatorContext에 추가한다.

```java

public class AdMessageConstraintValidator implements ConstraintValidator<AdMessageConstraint, Message> {
    private Validator validator;

    public AdMessageConstraintValidator(Validator validator) {
        this.validator = validator;
    }

    @Override
    public boolean isValid(Message value, ConstraintValidatorContext context) {
        if (value.isAd()) {
            final Set<ConstraintViolation<Object>> constraintViolations = validator.validate(value, Ad.class);
            if (CollectionUtils.isNotEmpty(constraintViolations)) {
                context.disableDefaultConstraintViolation();
                constraintViolations
                        .stream()
                        .forEach(constraintViolation -> {
                            context.buildConstraintViolationWithTemplate(constraintViolation.getMessageTemplate())
                                    .addPropertyNode(constraintViolation.getPropertyPath().toString())
                                    .addConstraintViolation();
                        });
                return false;
            }
        }

        return true;
    }
}
```

이렇게 클래스 레벨의 커스텀한 제약을 통해서 속성 상태에 따라 데이터 유효성 검사를 지정할 수 있다.

```java
@Validated
@Service
public class MessageService {
/**
     * message.isAd가 true이면 contcat, removeGuide 속성까지 검사한다.
     */
	public void sendMessage(@Valid Message message) {
// Do Something
    }

```

# 6. 오류 처리(Error Handling)

데이터 유효성 검사 시 실패가 발생하면 ConstraintViolationException을 발생시킨다. ConstraintViolationException은 실패 정보를 담고 있는 ConstraintViolation 객체들을 가지고 있는데, ConstraintViolationException에서 ConstraintViolation를 가져와 적절한 오류 응답을 만드는 것을 다음과 같이 구현할 수 있다.

```java
@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {
    @ExceptionHandler(value = ConstraintViolationException.class) // 유효성 검사 실패 시 발생하는 예외를 처리
    @ResponseBody
    protected Response handleException(ConstraintViolationException exception) {
        return Response
            .builder()
            .header(Header
                .builder()
                .isSuccessful(false)
                .resultCode(-400)
                .resultMessage(getResultMessage(exception.getConstraintViolations().iterator())) // 오류 응답을 생성
                .build())
            .build();
    }

    protected String getResultMessage(final Iterator<ConstraintViolation<?>> violationIterator) {
        final StringBuilder resultMessageBuilder = new StringBuilder();
        while (violationIterator.hasNext() == true) {
            final ConstraintViolation<?> constraintViolation = violationIterator.next();
            resultMessageBuilder
                .append("['")
                .append(getPopertyName(constraintViolation.getPropertyPath().toString())) // 유효성 검사가 실패한 속성
                .append("' is '")
                .append(constraintViolation.getInvalidValue()) // 유효하지 않은 값
                .append("'. ")
                .append(constraintViolation.getMessage()) // 유효성 검사 실패 시 메시지
                .append("]");

            if (violationIterator.hasNext() == true) {
                resultMessageBuilder.append(", ");
            }
        }

        return resultMessageBuilder.toString();
    }

    protected String getPopertyName(String propertyPath) {
        return propertyPath.substring(propertyPath.lastIndexOf('.') + 1); // 전체 속성 경로에서 속성 이름만 가져온다.
    }
}
```

데이터 유효성 검사가 실패하면 API는 다음과 같이 응답한다.

```
{
    "header" : {
        "isSuccessful" : false,
        "resultCode" : -400,
        "resultMessage" : "['title' is 'null'. must not be blank], ['body' is 'null'. must not be null]"
    }
}

```

# 7. 동적 메시지 생성(Message Interpolation)

마지막으로 메시지 생성에 대한 설명이다. Bean Validation은 기본적으로 제약(Constaint)의 message 속성에 오류에 대한 메시지를 정의할 수 있지만, 동적으로 메시지를 생성할 수 있는 기능을 이용해 더 자세하고, 동적인 메시지를 만들 수 있다. 기본적으로 다음과 같이 보통 message 속성에 정의한 메시지가 있다.

```java
...
public @interface NoEmoji{
    String message()default "Emoji is not allowed";

    ...

```

메시지 작성 시 다음과 같은 기능을 사용할 수 있다.

### 매개변수(Parameter)

메시지에 제약의 매개변수(Parameter)를 사용할 수 있다. 메시지에 매개변수를 사용하는 방법은 다음과 같다.

1. '{}' 또는 '${}'로 둘러싼다.
2. {, }, \, \$는 문자로 취급한다.
3. '{'는 매개변수의 시작, '}'는 매개변수의 끝, \는 확장 문자(Escaping Character) , '$'는 표현식 시작으로 취급한다.

|  | 메시지 정의 | 메시지 생성 결과 |
| --- | --- | --- |
| 검사한 값 | "Emoji[${validatedValue}] is not allowed" | "Emoji[:+1:] is not allowed" |
| 제약의 속성 | "Value must be between {min} and {max}" | "Value must be between 0 and 64" |

### 표현식(Expression)

메시지 정의 시 '${}'를 이용해 표현식도 사용할 수 있다. 다음은 Bean Validation에서 기본적으로 제공하는 제약인 '@DecimalMax'이다.

```
@Target({ METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE })
@Retention(RUNTIME)
@Repeatable(List.class)
@Documented@Constraint(validatedBy = {})
public@interface DecimalMax {
    ...
booleaninclusive()defaulttrue;
}

```

아래처럼 '${}' 표현식을 이용해 inclusive 속성 값에 따른 메시지를 생성할 수 있다.

| 메시지 정의 | 메시지 생성 결과(inclusive = true) | 메시지 생성 결과(inclusive = false) |
| --- | --- | --- |
| Must be greater than ${inclusive == true ? 'or equal to ' : ''}{value} | Must be greater than or equal to 10 | Must be greater than 10 |

### 국제화(i18n)

Bean Validation에서는 오류 메시지를 다양한 언어로 생성할 수 있는 기능도 제공해준다. 이를 위해서는 제약에 정의된 메시지를 메시지 파일(ValidationMessage.properties)로 옮겨야 한다. Bean Validation에서는 Class Path에 추가된 메시지 파일을 자동으로 불러와 메시지 생성 시 사용한다. 메시지 파일 이름 패턴은 'ValidationMessage_언어코드_국가코드.properties' 이다. 한국어인 경우 'ValidationMessage_ko_KR.properties'가 된다.

NoEmoji 제약을 예로 들면 영어는 'ValidationMessage.properties' 파일에 다음과 같이 정의할 수 있다.

```
com.toast.notification.beanvalidationexample.validation.NoEmoji.message=Emoji[${validatedValue}] is not allowed

```

한국어는 'ValidationMessage_ko_KR.properties' 파일에 영어와 같은 키(Key)에 값을 한국어로 한다.

```
com.toast.notification.beanvalidationexample.validation.NoEmoji.message=이모지[${validatedValue}]를 사용할 수 없습니다.

```

NoEmoji 제약의 message 속성에는 키를 적어준다.

```
public@interface NoEmoji {
        Stringmessage()default "{com.toast.notification.beanvalidationexample.validation.NoEmoji.message}"

```

다음과 같이 설정된 로케일에 맞는 메시지를 생성하는지 확인할 수 있다.

```java
@Test
public void test_default() {
        // Given
        Locale.setDefault(Locale.US);

        final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
        final Message message = Message
            .builder()
            .title(":+1:")
            .body("body")
            .build();

        // When
        final Collection<ConstraintViolation<Message>> constraintViolations = validator.validate(message);

        // Then
        Assert.assertEquals("Emoji[:+1:] is not allowed.", constraintViolations.iterator().next().getMessage());
    }

@Test
public void test_ko() {
        // Given
        Locale.setDefault(Locale.KOREAN);

        final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
        final Message message = Message
            .builder()
            .title(":+1:")
            .body("body")
            .build();

        // When
        final Collection<ConstraintViolation<Message>> constraintViolations = validator.validate(message);

        // Then
        Assert.assertEquals("이모지[:+1:]를 사용할 수 없습니다.", constraintViolations.iterator().next().getMessage());
    }
```

# 결론

지금까지 Bean Validation에 대한 소개와 TOAST Notification에서 Bean Validation을 어떻게 사용하고 있는지 설명했습니다. 앞서 설명한 것처럼 Bean Validation은 데이터 유효성 검사의 많은 점을 자동화해주고, 제약을 도메인 모델에 정의해 제약을 한눈에 확인할 수 있습니다. 그리고 비즈니스 로직과 데이터 유효성 검사 로직 분리를 통해 애플리케이션을 깔끔하게 개발할 수 있게 해줍니다.

기초적인 기능뿐만 아니라 Grouping 기능이나 커스텀 제약을 잘 활용한다면 대부분의 데이터 유효성 검사를 쉽게 해결할 수 있다고 생각합니다. 개발 시 데이터 유효성 검사나 오류 메시지 생성과 국제화에 대해 고민이 있는 개발자분들에게 도움이 되면 좋겠습니다.