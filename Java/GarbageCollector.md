# GC(Garbage Collection)

**GC(Garbage Collection)**는 Java에서 자동으로 메모리를 관리해 주는 메커니즘이다. 프로그래머가 메모리를 관리하지 않아도 사용되지 않는 객체(Garbage)를 JVM이 알아서 제거하기 때문에 메모리 누수를 사전에 방지할 수 있고 애플리케이션이 안정적으로 동작하도록 해준다.
​
<img width="640" alt="다운로드" src="https://github.com/user-attachments/assets/19b0ed79-44ca-49a7-94bd-54a3630399dc">

## GC의 동작 방식

Java에서 객체가 생성되면, **Heap Memory Area**에 할당된다. 하지만 객체가 생성된 뒤로 메모리 관리를 하지 않으면 애플리케이션에 문제가 발생할 수 있다. 또한 이 작업을 개발자가 하게 되면 매우 번거로워진다.

GC(Garbage Collection)는 이 작업을 대신 해준다. GC는 참조되지 않는 객체들을 자동으로 탐지하여 제거한다.

자바 개발자라면 크게 신경 쓰지 않았을 것이다. GC가 뒤에서 객체 메모리 관리 작업을 해주고 있다는 것만 알아두면 된다.

## GC(Garbage Collection)의 단계

### 📍 Mark
- **Mark 단계**는 GC가 Heap Memory에서 어떤 객체가 여전히 사용 중인지 확인하는 단계이다.

### 📍 Sweep
- 마크되지 않은(미사용 객체) 객체들을 실제로 메모리에서 제거하는 과정이다. 이를 통해 메모리 공간을 확보한다.

### 📍 Compact
- **Compact 단계**는 메모리 단편화를 방지하기 위해 살아있는 객체들을 Heap Memory 한쪽으로 이동시켜 연속된 메모리 공간을 확보하는 단계이다.

### 📍 Evacuation
- **Evacuation 단계**는 **Generational GC**에서 주로 사용되며, **Young Generation**에서 **Old Generation**으로 객체를 이동시키는 과정이다.

### 📍 Concurrent
- **Concurrent 단계**는 ZGC, Shenandoah, CMS와 같은 GC에서 사용되며, 대부분의 작업을 애플리케이션과 동시에 수행하여 Stop-the-World 시간을 최소화하는 단계이다.

​
```
import java.util.ArrayList;
import java.util.List;
​
public class EX_GC {
    public static void main(String[] args) {
        List<Object> list = new ArrayList<>();
        
        for (int i = 0; i < 1000000; i++) {
            list.add(new Object()); // 객체를 계속 생성하여 메모리를 채움
            if (i % 10000 == 0) {
                list.clear(); // 일정 주기마다 리스트를 비워서 GC 대상 객체로 만듦
            }
        }
       
    }
}
```
​
우선 EX_GC라는 파일을 생성했다. 위 코드를 보면 객체가 무분별하게 생성된다. GC를 실행시키기 위한 임의의 코드이다.
​
```
javac EX_GC.java
```
​
우선 텍스트 파일을 컴파일한다.
​
```
java -Xms16M -Xmx16M '-Xlog:gc*:file=gc.log:time' EX_GC
```


​
이제 힙 메모리 공간을 설정하고 GC 로그를 활성화한 다음 Java를 실행시키면 GC가 동작하는 걸 볼 수 있다.
​

​<img width="640" alt="다운로드 (1)" src="https://github.com/user-attachments/assets/276a54f8-aafe-439f-a064-1884fb4ed29c">

GC가 동작하면 위 그림처럼 로그가 발생한다. 만약에 메모리가 부족해서 java 실행이 실패하면 로그에
​
<img width="640" alt="다운로드 (2)" src="https://github.com/user-attachments/assets/225d1882-f4fa-400a-bc29-9086bcb3ead7">  
이런 식으로 로그가 남을 것이다. 이제 로그를 몇 개만 까보자 
​

**Heap region size: 1M**  
* 힙 메모리는 1MB 크기의 여러 영역(region)으로 나뉘어 관리되고 있다.
​
Using G1
* VM이 **G1 GC**를 사용하고 있음을 나타낸다.  
​
**Heap address, size: 16MB**  
* 힙 메모리의 주소와 크기 정보이다. 
​
**GC(0) Pause Young (Normal) (G1 Evacuation Pause)**  
* 이 로그는 **첫 번째 GC 이벤트**를 의미한다.  
​
**GC(0) Pause Young (Normal) (G1 Evacuation Pause) 7M->0M(16M) 0.520ms**  
​* 첫 번째 GC 후, 힙 메모리 사용량이 **7MB에서 0MB로 줄어들었고**, 전체 힙 크기는 16MB이다. GC 이벤트는 **0.520ms**의 짧은 시간 동안 발생했다.
​
**Heap**
​
GC 후 힙 메모리 상태를 보여줍니다. 총 16MB의 힙에서 현재 **1.772MB**가 사용 중이며, GC 후 Eden 영역에서 살아남은 객체가 **3개의 Young 영역**에 위치해 있습니다.
​
(로그는 하나하나 설명하면 루즈해질 것 같아서 몇 개 빼곤 생략했다. 모르는 게 있으면 얼마든지 댓글로 남겨주시면 감사하겠습니다.)
​
---
​
이제 GC의 기본적인 동작은 모두 봤으니 GC의 종류를 한번 보자 (이번글의 핵심이기도 하다)
## 📍 GC의 종류
Java에서는 다양한 GC 알고리즘이 제공되며, 각 알고리즘은 서로 다른 성능 특성과 목적을 가지고 있다.

### 1. Serial GC
- **Java 1.2**에 도입되었고 단일 스레드로 GC를 처리한다.
- 작은 애플리케이션에서 적합하며, Stop-the-World 시간이 길 수 있다.
- `-XX:+UseSerialGC` 옵션으로 사용.

### 2. Parallel GC
- **Java 1.4**에 도입되었고 여러 스레드로 동시에 GC를 처리하여 병렬로 수행된다.
- 대규모 애플리케이션에서 힙 메모리 관리에 효과적이다.
- `-XX:+UseParallelGC` 옵션으로 사용.

### 3. CMS (Concurrent Mark-Sweep) GC
- **Java 1.5**에 도입되었고, 응답 시간이 중요한 애플리케이션에서 사용된다.
- 마킹과 스윕 단계를 애플리케이션과 병렬로 수행하여 Stop-the-World 시간을 줄인다.
- `-XX:+UseConcMarkSweepGC` 옵션으로 사용.

### 4. G1 GC (Garbage First)
- **Java 1.7**부터 시범운영을 하고 **Java 9**부터 기본 GC로 사용된다.
- 대규모 애플리케이션에서 성능을 최적화하기 위해 설계되었다.
- 힙 메모리를 여러 개의 작은 영역으로 나누고, 우선적으로 가비지가 많은 영역을 먼저 정리한다.
- `-XX:+UseG1GC` 옵션으로 사용.

### 5. ZGC (Z Garbage Collector)
- **Java 11**에 도입된 최신 GC로, 대용량 힙에서도 매우 짧은 Stop-the-World 시간을 보장한다(10ms 이하).
- 초대형 메모리 시스템을 위해 설계되었으며, 거의 실시간에 가까운 GC 처리가 가능하다.
- ZGC는 기본 GC가 아니고 시범운영만 했지만 **Java 15**부터는 기본 기능으로 사용 가능하다.
- `-XX:+UseZGC` 옵션으로 사용.

#### ZGC의 특징
- **작업 병렬화**: 대부분의 GC 작업을 애플리케이션과 병렬로 수행한다. Stop-the-World 시간이 매우 짧고, 큰 힙 메모리에서도 10ms 이하의 지연 시간을 유지할 수 있다.
- **컬러드 포인터(Colored Pointers)**: ZGC는 컬러드 포인터라는 기술을 사용해 객체 참조를 추적하고, 객체가 이동할 때도 애플리케이션이 중단되지 않도록 한다. 이로 인해 매우 빠른 GC 작업이 가능하다.
- **대용량 힙에 적합**: 수백 GB에서 몇 TB의 힙 메모리에서도 효율적으로 작동하며, 메모리 사용량이 매우 큰 애플리케이션에 적합하다.

### 6. Shenandoah GC
- CMS와 비슷하지만 더욱 짧은 Stop-the-World 시간을 제공하며, 대규모 멀티스레드 환경에 적합하다.
- `-XX:+UseShenandoahGC` 옵션으로 사용.

#### Shenandoah GC의 특징
- **병렬 및 동시성**: Shenandoah는 거의 모든 GC 작업을 애플리케이션과 동시에 수행한다. 힙 메모리가 매우 크더라도 지연 시간을 최소화하며, 대규모 멀티코어 환경에서 효율적으로 동작한다.
- **동시 압축(concurrent compaction)**: Shenandoah는 힙 메모리의 조각화를 방지하기 위해, 객체 이동 및 압축 작업도 애플리케이션과 동시에 수행할 수 있다.
- **동시 마킹과 스윕**: 객체의 생존 여부를 확인하는 마킹 단계와 메모리 해제 작업을 동시에 처리하여 성능을 향상한다.
\-XX:+UseZGC 옵션으로 사용.
​
6. **Shenandoah GC**
​
CMS와 비슷하지만 더욱 짧은 **Stop-the-World** 시간을 제공하며, 대규모 멀티스레드 환경에 적합하다.
​
• **병렬 및 동시성**: Shenandoah는 거의 모든 GC 작업을 애플리케이션과 **동시에** 수행한다. 힙 메모리가 매우 크더라도 지연 시간을 최소화하며, 대규모 멀티코어 환경에서 효율적으로 동작한다.
​
• **동시 압축(concurrent compaction)**: Shenandoah는 힙 메모리의 조각화를 방지하기 위해, 객체 이동 및 압축 작업도 애플리케이션과 동시에 수행할 수 있다.
​
• **동시 마킹과 스윕**: 객체의 생존 여부를 확인하는 마킹 단계와 메모리 해제 작업을 동시에 처리하여 성능을 향상한다.
​
**\-XX:+UseShenandoahGC** 옵션으로 사용.
​
자 이런 변천사를 봤는데 공통적인 포인트가 있다. **Stop-the-World** (멈춰! 그 세계)가 공통적으로 들어있다. 점점 루즈해지니 빨리 설명하겠다.  
---

## Stop-the-World란?

**Stop-the-World** 는 GC가 실행되는 동안 JVM이 모든 애플리케이션 스레드를 일시 중지하고, GC 작업에 필요한 메모리 정리를 완료할 때까지 기다리는 시간을 의미한다. GC는 힙 메모리에서 객체를 수집할 때, 애플리케이션이 메모리를 사용할 수 없도록 하기 위해 이런 일시 중단을 발생시킨다.

## Stop-the-World가 발생하는 이유
메모리 관리 작업은 매우 중요한 작업으로, 메모리의 일관성을 유지하기 위해 GC는 애플리케이션의 스레드가 메모리 객체를 동시에 변경하지 않도록 모든 스레드를 멈추게 한다. 이것이 Stop-the-World 이벤트이다.

### 각 GC에서의 Stop-the-World
- **Serial GC**는 단일 스레드라 Heap Memory가 커질수록 Stop-the-World가 길어진다.
- **Parallel GC**는 병렬 스레드를 사용하지만 Stop-the-World 시간이 상대적으로 길어 애플리케이션 성능에 영향을 미칠 수 있다.
- **CMS**와 **G1 GC**는 Stop-the-World 시간을 줄이려는 목표를 가지고 있으며, 애플리케이션과 병렬로 GC 작업을 수행한다.
- **ZGC**와 **Shenandoah**는 가장 짧은 Stop-the-World 시간을 목표로 하며, 대부분의 GC 작업을 애플리케이션과 동시에 처리하여 매우 짧은 지연 시간(10ms 이하)을 유지한다.  
​  
성능영향? 멈춘다? 개발자들은 알레르기 반응이 슬슬 올라올 거다. 하지만 자바 8 이상이라면 두 눈 뜨고 실제로 보긴 힘들 거다.(그 이하버전을 쓰신다면 유감입니다.)
GC가 메모리 정리를 효율적으로 마칠 때까지 모든 애플리케이션 스레드는 멈추게 된다. 그러나 **Stop-the-World** 시간이 너무 길어지면 애플리케이션 성능에 큰 영향을 미칠 수 있다. 이를 최소화하는 것이 GC의 주요 목표 중 하나이다.    
​개념적인 내용은 끝이 났다. GC를 이렇게 글로 다룬 이유는 갑자기 개발을 하다가 GC를 파보고 싶어서 파 봤는데 내가 **그냥 GC? 그거 메모리 비워주고 관리해 주는 거 아니야?라고 생각했던 나 자신 반성하도록,,,,,,개인적으로 재밌었다. 다음 성능개선점을 찾을 때 이게 도움이 될지는 모르지만 뭔가 언젠간 분명 이게 차별점이 될 거라 믿는다.  
​ 
아 그리고 ZGC는 따로 한번 더 다뤄볼 예정이다.
​
---
​
#### ****📍** 참고자료**
​
**[https://coderstea.in/post/java/get-ready-to-deep-dive-java-memory-management-garbage-collector/](https://coderstea.in/post/java/get-ready-to-deep-dive-java-memory-management-garbage-collector/)**
​
[https://www.geeksforgeeks.org/garbage-collection-java/](https://www.geeksforgeeks.org/garbage-collection-java/)
​
[https://d2.naver.com/helloworld/1329](https://d2.naver.com/helloworld/1329)
