MS 가 GitHub를 인수한 후 출시한 CI/CD 서비스이다.

### GitHub Action?

GitHub Action는 코드 저장소 (GitHub) 에서 제공하는 CI(Continuous Integration, 지속적 통합)와 CD(Continuous Deployment, 지속적 배포)를 위한 다른서비스들에 비해 비교적 최근에 출시된 서비스이다. GitHub에서 코드를 관리하고 있는 소프트웨어 프로젝트에서 사용이 가능하다.

GitHub 저장소는 누구나 무료로 생성할 수 있기 때문에 jenkins,travis CI 등 다른 서비스들에 비해 진입장벽이 낮은 편이다.

GitHub Action을 사용하면 자동으로 어떤 이벤트가 발생했을 때 특정 작업이 일어나게 하거나 주기적으로 어떤 작업들을 반복해서 실행시킬 수도 있다. 누군가가 Pull Request를 생성하게 되면 GitHub Actions를 통해 해당 코드 변경분에 문제가 없는지 각종 검사를 진행할 수 있고, 어떤 새로운 코드가 main  branch에 유입되면 GitHub Actions를 통해 소프트웨어 를 빌드하고 상용 서버에 배포(DEPLOY)를 할 수도 있다. 또, 특정 시각에 그날 통계 데이터를 수집시킬 수도 있다.

이렇게 소프트웨어 프로젝트에서 지속적으로 수행해야하는 반복 작업들을 업계에서는 소위 CI/CD라고 많이 줄여서 부른다. 사람이 매번 직접 하기에는 비효율적인데다가 실수할 위험도 있기 때문에 GitHub Actions와 같은 자동화시키는 것이 유리하다.

예전에는 CI/CD가 DevOps 엔지니어의 전유물로만 여겨지곤 했었는데 최근에는 GitHub Actions을 통해서 일반 개발자들도 어렵지 않게 CI/CD 설정을 스스로 할 수 있다.

### Workflows

WorkFlow(작업 흐름)는 GitHub Action에서 가장 상위 개념이다. 쉽게 말해서 자동화 해놓은 작업과정이라고 보면 된다. 워크플로우는 코드 저장소 내에서 .github/workflows 폴더 아래에 위치한 YAML 파일로 설정하며, 하나의 코드 저장소에는 여러개의 워크플로우,즉 여러개의 YAML 파일을 생성할 수 있다.

이 워크플로우 YAML 파일에는 크게 2가지를 정의해야하는데요. 첫번째는 `on` 속성을 통해서 해당 워크플로우가 언제 실행되는지를 정의

예를 들어, 코드 저장소의 `main` 브랜치에 `push` 이벤트가 발생할 때 마다 워크플로우를 실행하려면 다음과 같이 설정한다.

예를 들어, 코드 저장소의 `master` 브랜치에 `push`이벤트가 발생할 때 마다 워크플로우를 실행하려면 다음과 같이 설정해준다.

`.github/workflows/example.yml`

```yaml
on:
  push:
    branches:
      - master

jobs:
  # ...(생략)...
```

매일 자정에 워크 플로우를 실행하기 위해 다음과 같이 설정

`.github/workflows/test.yml`

```yaml
on:
  schedule:
  - cron: "0 0 * * *"

jobs:
  # ...(생략)...
```

여기까지는 워크플로우 동작에 대해서만 다뤘다.

워크플로우가 내부에서 구체적으로 어떤 행위를 하는지는 Jobs를 통해 설정할 수 있다.

### Jobs

GitHub Actions에서 작업(Job)이란 독립된 가상머신(VM) 또는 컨테이너(container)에서 돌아가는 하나의 처리 단위를 의미한다. 하나의 워크플로우는 여러 개의 작업으로 구성되며 적어도 하나의 작업은 있어야 한다. (아니라면 실행할 작업이 없으니 워크플로우가 의미가 없다.) 그리고 모든 작업은 기본적으로 동시에 실행되며 필요 시 작업 간에 의존 관계를 설정하여 작업이 실행되는 순서를 제어할 수도 있다.

작업은 워크플로우 YAML 파일 내에서 `jobs` 속성을 사용하며 작업 식별자(ID)와 작업 세부 내용 간의 맵핑(mapping) 형태로 명시

예를 들어, `job1`, `job2`, `job3`이라는 작업 ID를 가진 3개의 작업을 추가하려면 다음과 같이 설정한다.

`.github/workflows/example.yml`

```yaml
...
jobs:
  job_1:
    # job1에 대한 세부 내용
  job_2:
    # job2에 대한 세부 내용
  job_3:
    # job3에 대한 세부 내용
```

작업의 세부 내용으로는 여러 가지 내용을 명시할 수 있는데요. 필수로 들어거야 하는 `runs-on`
속성을 통해 해당 리눅스나 윈도우즈와 같은 실행 환경을 지정해줘야 한다.예를 들어,우분투의 최신 실행 환경에서 해당 작업을 실행하고 싶다면 다음과 같이 설정해야한다.

`.github/workflows/example.yml`

```yaml
...
jobs:
  job1:
    runs-on: ubuntu-latest    
		steps:
`...`
```

세부 동작에 대해서 정의를 했다면 이제 Job들의 실행 순서를 정해줘야한다.

### Steps

정말 단순한 작업이 아닌 이상 하나의 작업은 일반적으로 여러 단계의 명령을 순차적으로 실행하는 경우가 많다.그래서 GitHub Actions에서는 각 작업(job)이 하나 이상의 단계(step)로 모델링이 된다.

작업 단계는 단순한 커맨드(command)나 스크립트(script)가 될 수도 있고 다음 섹션에서 자세히 설명할 액션(action)이라고 하는 좀 더 복잡한 명령일 수도 있다. 커맨드나 스크립트를 실행할 때는 `run` 속성을 사용하며, 액션을 사용할 때는 `uses` 속성을 사용한다.

`.github/workflows/example.yml`

```yaml

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm install
      - run: npm test
```

예를 들어 자바스크립트 프로젝트에서 테스트를 돌리려면 코드 저장소에 코드를 작업 실행 환경으로 내려 받고, 패키지를 설치한 후, 테스트 스크립트를 실행해야한다. 이 3단계의 작업은 위와 같이 `steps` 속성을 통해서 명시될 수 있을 것이다.

### Actions

액션은 GitHub Actions에서 빈번하게 필요한 반복 단계를 재사용하기 용이하도록 제공되는 일종의 작업 공유 메커니즘이다. 이 액션은 하나의 코드 저장소 범위 내에서 여러 워크플로우 간에서 공유를 할 수 있을 뿐만 아니라, 공개 코드 저장소를 통해 액션을 공유하면 GitHub 상의 모든 코드 저장소에서 사용이 가능해진다.

뿐만 [GitHub Marketplace](https://github.com/marketplace?type=actions)에서는 수많은 벤더(vendor)가 공개해놓은 다양한 액션을 쉽게 접할 수가 있다. 한 마디로 이 액션을 중심으로 하나의 큰 커뮤니티가 형성이 되고 더 많은 사용자와 벤더가 GitHub Actions으로 몰려드는 선순환이 일어나고 있다.****