### 알고리즘
    알고리즘은 어떠한 문제를 해결하기 위한 여러 동작들의 모임을 의미한다.

### 버블소트
    버블소트는 서로 인접한 두 원소를 비교하여 정렬하는 알고리즘이다.
    0번 인덱스 부터 n-1번 인덱스까지 n번까지의 모든 인덱스를 비교하며 정렬함.
    시간복잡도는 O(n^2)

### 힙소트
    힙소트는 주어진 데이터를 힙 자료구조로 만들어 최대값 또는 최소값부터 하나씩 꺼내서 정렬하는 알고리즘이다.
    힙소트가 가장 유용한 경우는 전체를 정렬하는 것이 아니라 가장 큰 값 몇개만을 필요로 하는 경우이다.
    시간복잡도는 O(nlog2n)

### 머지소트
    머지소트는 주어진 배열을 크기가 1인 배열로 분할하고 합병하면서 정렬을 진행하는 분할/정복 알고리즘이다.
    시간복잡도는 O(nlog2n)

### 퀵소트
    퀵소드는 매우 빠른 정렬 속도를 가진 분할 정복 알고리즘 중 하나로 합병 정렬과 달리 리스트를 비균등하게 분할한다.
    피봇을 설정하고 피봇보다 큰값과 작은값으로 분할하여 정렬을 합니다. 시간복잡도는 O(nlog2n)이며 리스트가 계속해서 불균등하게 나눠지는 경우 시간 복잡도가 O(n^2)까지 나빠질 수 있다.

### 삽입소트
    삽입정렬은 두번째 값부터 시작하여 그 앞에 존재하는 원소들과 비교하여 삽입할 위치를 찾아 삽입하는 정렬 알고리즘이다.
    삽입 정렬의 평균 시간복잡도는 O(n^2)이고, 가장 빠른 경우 O(n)까지 높아질 수 있다.

### 동적 프로그래밍(Dynamic Programing)
동적 프로그래밍은 주어진 문제를 풀기 위해서, 문제를 여러 개의 하위문제로 나누어 푼 다음, 그것을 결합하여 해결하는 방식이다.
동적 프로그래밍에서는 어떤 부분 문제가 다른 문제들을 해결하는데 사용될수 있어, 답을 여러번 계산하는 대신 한번만 계산하고 그 결과를 재활용하는 메모이제이션기법으로 속도를 향상 시킬 수 있다.

* 동적 프로그래밍의 두가지 조건
  * Overlapping Subproblem(중복되는 부분 문제) : 주어진 문제는 같은 부분 문제가 여러번 재사용된다.
  * Optimal Substructure(최적 부분구조): 새로운 부분 문제의 정답을 다른 부분 문제의 정답으로 부터 구할 수 있다. 

### 재귀 알고리즘
재귀 알고리즘은 함수 내부에서 함수가 자기 자신을 또 다시 호출하여 문제를 해결하는 알고리즘이다. 재귀 알고리즘은 자기가 계속해서 자신을 호출하므로 끝없이 반복되게 되므로 반복을 중단할 조건이 필요하다.
시간복잡도 O(n)