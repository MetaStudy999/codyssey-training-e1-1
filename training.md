# E1-1. AI/SW 개발 워크스테이션 구축 — 입문자 수행 가이드

> 코디세이 입학연수 · 개발 입문 · 학습시간 40시간  
> 주 실습환경: **macOS + OrbStack + Ubuntu 24.04 LTS VM + OrbStack Docker**  
> OrbStack VM 이름: **`codyssey-training`**

이 문서는 코디세이 E1-1 미션을 처음 수행하는 입문자가 환경 준비부터 Docker 실습, 증거 수집, GitHub 제출 및 동료평가 준비까지 순서대로 진행하도록 만든 실습 지침서입니다.

> **중요:** 아래 명령의 결과는 예시가 아닙니다. 본인의 환경에서 직접 실행하고, 실제 출력·스크린샷·문제 해결 과정을 저장소에 기록해야 합니다.

---

## 문서 표시 기준

| 표시 | 의미 |
|---|---|
| **[필수]** | 미션 문서에서 요구하는 항목 |
| **[권장]** | 입문자의 안정적인 수행·시험·평가 준비를 위한 보완 항목 |
| **[보너스]** | 미션 문서에 제시된 선택 과제 |
| **[macOS]** | Mac 터미널에서 실행하는 명령 |
| **[Ubuntu VM]** | OrbStack Ubuntu VM 안에서 실행하는 명령 |

---

# 목차

1. 미션 목표와 완료 기준
2. 전체 수행 흐름
3. 용어 먼저 이해하기
4. 저장소 구조 준비
5. macOS와 OrbStack 사전 점검
6. Ubuntu 24.04 VM 생성
7. Ubuntu VM 기본 환경 설정
8. OrbStack Docker 연동
9. GitHub 저장소 복제와 작업 위치 확정
10. 실행 환경 기준선 기록
11. 터미널 기본 조작 실습
12. 파일과 디렉터리 권한 실습
13. Docker 기본 점검
14. Docker 이미지와 컨테이너 운영
15. Dockerfile 기반 웹 서버 제작
16. 포트 매핑과 접속 검증
17. 바인드 마운트 변경 반영
18. Docker 볼륨 영속성 검증
19. Git·GitHub·VS Code 연동
20. 보안과 민감정보 점검
21. 트러블슈팅 기록
22. 요구사항·테스트·증거 추적
23. README 또는 결과 문서 작성 기준
24. 40시간 권장 학습계획
25. 단계별 품질 게이트
26. 시험·동료평가 대비
27. FAIL 이후 보완 절차
28. 보너스 과제
29. 최종 제출 체크리스트

---

# 1. 미션 목표와 완료 기준

## 1.1 [필수] 최종 목표

다음 내용을 GitHub 저장소에서 모두 확인할 수 있어야 합니다.

- 터미널로 파일과 디렉터리를 생성·복사·이동·삭제한다.
- 파일과 디렉터리의 권한을 확인하고 변경한다.
- Docker 버전과 엔진 상태를 확인한다.
- Docker 이미지와 컨테이너를 실행·중지·조회한다.
- `Dockerfile`을 직접 작성하여 커스텀 이미지를 빌드한다.
- 포트 매핑을 통해 Mac 브라우저 또는 `curl`로 웹 서버에 접속한다.
- 바인드 마운트로 파일 변경이 즉시 반영되는지 확인한다.
- Docker 볼륨으로 컨테이너 삭제 후에도 데이터가 유지되는지 확인한다.
- Git 사용자 설정과 GitHub/VS Code 연동 상태를 기록한다.
- 트러블슈팅을 최소 2건 이상 기록한다.
- 기술 문서만 보고 평가자가 동일한 절차를 재현할 수 있게 한다.
- 로그와 스크린샷에 토큰·비밀번호·개인키를 노출하지 않는다.

## 1.2 학습 후 설명할 수 있어야 하는 내용

- 절대 경로와 상대 경로의 차이
- 파일 권한 `r`, `w`, `x`의 의미
- `755`, `644`의 해석 방법
- Docker 이미지와 컨테이너의 차이
- Dockerfile과 이미지 빌드의 관계
- 호스트 포트와 컨테이너 포트의 차이
- 바인드 마운트와 Docker 볼륨의 차이
- 데이터 영속성이 필요한 이유
- Git과 GitHub의 역할 차이
- 오류를 문제 → 가설 → 확인 → 해결 순서로 분석하는 방법

---

# 2. 전체 수행 흐름

입문자는 다음 순서를 바꾸지 않고 진행합니다.

```text
1. Mac에서 OrbStack 실행 확인
2. Ubuntu 24.04 VM 생성
3. VM 이름을 codyssey-training으로 고정
4. VM 기본 패키지 설치
5. VM에서 OrbStack Docker 명령 연동
6. GitHub 저장소 clone
7. 환경 기준선 기록
8. 터미널 조작 실습
9. 권한 실습
10. Docker 기본 운영
11. Dockerfile 작성 및 이미지 빌드
12. 포트 매핑 검증
13. 바인드 마운트 검증
14. 볼륨 영속성 검증
15. Git·GitHub·VS Code 증거 정리
16. 트러블슈팅 2건 이상 작성
17. 요구사항·테스트·증거 추적표 완성
18. clean clone 재현 시험
19. 모의 동료평가
20. 최종 push 및 제출
```

---

# 3. 용어 먼저 이해하기

| 용어 | 입문자 설명 |
|---|---|
| macOS 호스트 | OrbStack이 설치되어 있는 실제 Mac 컴퓨터 |
| OrbStack | Mac에서 Docker 컨테이너와 Linux VM을 실행하는 프로그램 |
| Linux machine / VM | OrbStack 안에서 동작하는 Ubuntu 실행환경 |
| `codyssey-training` | 이 과정에서 사용할 Ubuntu 24.04 VM 이름 |
| Docker Engine | 컨테이너를 실제로 생성하고 실행하는 백그라운드 엔진 |
| Docker CLI | `docker run`, `docker ps`와 같은 명령을 입력하는 도구 |
| 이미지 | 컨테이너 실행에 필요한 파일과 설정을 묶은 템플릿 |
| 컨테이너 | 이미지를 기반으로 실제 실행된 프로세스 환경 |
| Dockerfile | 커스텀 이미지를 만드는 절차를 기록한 파일 |
| 포트 매핑 | Mac의 포트와 컨테이너의 포트를 연결하는 작업 |
| 바인드 마운트 | 호스트 또는 VM의 실제 폴더를 컨테이너에 연결하는 방식 |
| Docker 볼륨 | Docker가 관리하는 영속 데이터 저장소 |
| Git | 로컬 변경 이력을 관리하는 도구 |
| GitHub | Git 저장소를 원격에서 공유·협업하는 서비스 |

---

# 4. 권장 저장소 구조

최종적으로 다음 구조를 권장합니다.

```text
codyssey-training-e1-1/
├── training.md
├── README.md                 # 선택: 최종 수행 결과 요약 문서
├── Dockerfile
├── .dockerignore
├── .gitignore
├── site/
│   └── index.html
├── docs/
│   ├── environment.md
│   ├── terminal-and-permissions.md
│   ├── docker-operations.md
│   ├── bind-mount.md
│   ├── volume-persistence.md
│   ├── troubleshooting.md
│   ├── test-results.md
│   ├── requirement-traceability.md
│   └── screenshots/
│       ├── environment/
│       ├── terminal/
│       ├── permissions/
│       ├── docker/
│       ├── port/
│       ├── mount/
│       ├── volume/
│       └── github/
└── scripts/
    └── verify.sh             # 선택
```

> `training.md`는 학습 지침서입니다. 실제 수행 결과는 `README.md`와 `docs/`에 기록하는 방식을 권장합니다.

---

# 5. macOS와 OrbStack 사전 점검

## 5.1 [macOS] OrbStack 실행

1. Mac에서 OrbStack 애플리케이션을 실행합니다.
2. 메뉴 막대에서 OrbStack이 실행 중인지 확인합니다.
3. Mac 터미널을 엽니다.

## 5.2 [macOS] OrbStack CLI 확인

```bash
orb version
orb status
orb list
```

정상 기준:

- `orb version`에서 버전이 출력된다.
- `orb status`에서 OrbStack이 실행 중인 것으로 확인된다.
- `orb list`가 오류 없이 실행된다.

## 5.3 [macOS] OrbStack Docker 확인

```bash
docker version
docker context ls
docker context show
```

`docker context show` 결과가 `orbstack`이 아니면 다음을 실행합니다.

```bash
docker context use orbstack
docker context show
```

정상 기준:

- Docker Client와 Server 정보가 모두 출력된다.
- 현재 Docker context가 `orbstack`이다.

> OrbStack은 자체 Docker Engine과 Docker CLI, Compose, buildx를 제공합니다. Mac에 별도의 Docker Engine을 중복 설치하지 않습니다.

---

# 6. Ubuntu 24.04 VM 생성

## 6.1 기존 VM 이름 확인

**[macOS]**

```bash
orb list
```

목록에 `codyssey-training`이 이미 존재하면 새로 만들지 말고 다음을 확인합니다.

```bash
orb info codyssey-training
```

기존 VM을 삭제하면 내부 데이터가 사라질 수 있으므로 입문자는 임의로 `orb delete`를 실행하지 않습니다.

## 6.2 Ubuntu 24.04 LTS VM 생성

`noble`은 Ubuntu 24.04 LTS의 코드명입니다.

**[macOS] 기본 생성**

```bash
orb create ubuntu:noble codyssey-training
```

**[macOS] 자원 제한을 지정하는 권장 예시**

```bash
orb create \
  --memory 4G \
  --cpus 2 \
  --disk 32G \
  ubuntu:noble \
  codyssey-training
```

> 위 두 명령 중 하나만 실행합니다. 이미 같은 이름의 VM이 있으면 생성 명령을 반복하지 않습니다.

## 6.3 VM 생성 확인

**[macOS]**

```bash
orb list
orb info codyssey-training
```

## 6.4 VM 접속

**[macOS]**

```bash
orb -m codyssey-training
```

이제 프롬프트가 Ubuntu VM의 셸로 바뀝니다.

## 6.5 Ubuntu 24.04 확인

**[Ubuntu VM]**

```bash
cat /etc/os-release
uname -a
uname -m
whoami
pwd
```

정상 기준:

- `/etc/os-release`에 Ubuntu 24.04 또는 `VERSION_CODENAME=noble`이 표시된다.
- 현재 사용자가 확인된다.
- 홈 디렉터리에서 시작한다.

## 6.6 VM 종료와 재접속

VM 셸에서 Mac 터미널로 돌아갈 때:

```bash
exit
```

다시 접속할 때:

```bash
orb -m codyssey-training
```

VM 자체를 중지·시작할 때:

```bash
orb stop codyssey-training
orb start codyssey-training
```

---

# 7. Ubuntu VM 기본 환경 설정

## 7.1 패키지 목록 갱신

**[Ubuntu VM]**

```bash
sudo apt update
```

## 7.2 기본 도구 설치

```bash
sudo apt install -y \
  ca-certificates \
  curl \
  wget \
  git \
  vim \
  nano \
  tree \
  jq \
  unzip \
  zip
```

## 7.3 설치 확인

```bash
git --version
curl --version | head -n 1
tree --version
jq --version
```

## 7.4 파일 공유 위치 이해

OrbStack에서는 다음 경로를 사용할 수 있습니다.

- Ubuntu VM에서 Mac 파일 보기: `/mnt/mac`
- Mac Finder에서 VM 파일 보기: `~/OrbStack`
- 다른 OrbStack VM 파일 보기: `/mnt/machines`

이 미션의 주 작업 폴더는 파일 권한과 Linux 동작을 안정적으로 실습하기 위해 **Ubuntu VM의 홈 디렉터리 아래**에 둡니다.

```bash
mkdir -p ~/codyssey-training
cd ~/codyssey-training
pwd
```

---

# 8. OrbStack Docker 연동

## 8.1 연동 원칙

이 과정에서는 다음 구조를 사용합니다.

```text
Ubuntu 24.04 VM의 터미널
        ↓ docker 명령
Mac에서 실행 중인 OrbStack Docker CLI
        ↓
OrbStack Docker Engine
        ↓
Docker 이미지·컨테이너·볼륨
```

> Ubuntu VM 내부에 `docker.io`, `docker-ce`, `containerd`를 별도로 설치하지 않습니다. 별도 Docker Engine을 설치하면 OrbStack Docker와 다른 엔진이 생겨 입문자가 컨테이너·이미지·포트를 혼동할 수 있습니다.

## 8.2 Mac의 Docker 명령 위치 확인

**[Ubuntu VM]**

```bash
mac which docker
```

Mac에 OrbStack Docker CLI가 정상 설치되어 있으면 경로가 출력됩니다.

## 8.3 VM에서 기존 Docker 명령 확인

```bash
command -v docker || true
type -a docker || true
```

Docker 명령이 정상 실행되는지 확인합니다.

```bash
docker version
docker context show
```

두 명령이 정상이라면 **8.4는 건너뜁니다.**

## 8.4 Docker 명령이 없을 때 연결

OrbStack의 Mac 명령 연결 기능을 사용합니다.

```bash
mac link docker
hash -r
command -v docker
docker version
docker context show
```

정상 기준:

- `command -v docker`가 경로를 출력한다.
- `docker version`에 Client와 Server가 모두 표시된다.
- `docker context show`에서 `orbstack`이 표시된다.

## 8.5 Docker 연결이 깨졌을 때 복구

다음과 같은 경우에만 실행합니다.

- `command -v docker`는 나오지만 실행이 실패한다.
- `/opt/orbstack-guest/.../cmdlinks/docker` 관련 오류가 발생한다.
- 기존 링크가 손상된 것으로 판단된다.

```bash
mac unlink docker
mac link docker
hash -r
exec "$SHELL" -l
```

새 셸에서 다시 확인합니다.

```bash
command -v docker
docker version
docker context show
```

그래도 실패하면 Mac 터미널에서 다음을 확인합니다.

```bash
orb status
docker context use orbstack
docker version
orb restart docker
```

그 후 VM에 다시 접속합니다.

```bash
orb -m codyssey-training
```

## 8.6 Docker 연동 최종 시험

**[Ubuntu VM]**

```bash
docker run --rm hello-world
docker ps
docker ps -a
docker images
```

**[macOS]** 별도 터미널에서도 같은 이미지를 확인합니다.

```bash
docker images
```

Ubuntu VM과 Mac에서 동일한 OrbStack Docker Engine의 이미지 목록이 보이면 연동된 것입니다.

## 8.7 연동 증거로 남길 내용

- `orb list`
- Ubuntu 24.04 확인 결과
- `command -v docker`
- `docker context show`
- `docker version`
- `docker run --rm hello-world`
- Mac과 VM에서 확인한 `docker images`

---

# 9. GitHub 저장소 복제와 작업 위치 확정

## 9.1 Git 사용자 정보 확인

**[Ubuntu VM]**

```bash
git config --global user.name
git config --global user.email
```

값이 없다면 본인의 GitHub 사용 정보로 설정합니다.

```bash
git config --global user.name "YOUR_NAME"
git config --global user.email "YOUR_EMAIL"
git config --global init.defaultBranch main
```

> README나 스크린샷을 공개할 때 이메일 노출 여부를 확인합니다.

## 9.2 저장소 clone

```bash
cd ~/codyssey-training

git clone https://github.com/MetaStudy999/codyssey-training-e1-1.git
cd codyssey-training-e1-1
```

## 9.3 저장소 상태 확인

```bash
pwd
git status
git branch --show-current
git remote -v
ls -la
```

정상 기준:

- 현재 경로가 `~/codyssey-training/codyssey-training-e1-1`이다.
- 현재 브랜치가 `main`이다.
- 원격 저장소가 `MetaStudy999/codyssey-training-e1-1`을 가리킨다.

## 9.4 작업 원칙

- 미션 파일은 저장소 내부에서 작성합니다.
- 스크린샷은 `docs/screenshots/` 아래에 정리합니다.
- 각 실습이 끝날 때 작은 단위로 commit합니다.
- 토큰·비밀번호·개인키는 commit하지 않습니다.

---

# 10. 실행 환경 기준선 기록

`docs/environment.md`를 만들고 다음 정보를 기록합니다.

```bash
mkdir -p docs/screenshots/{environment,terminal,permissions,docker,port,mount,volume,github}
touch docs/environment.md
```

## 10.1 [Ubuntu VM] 수집 명령

```bash
cat /etc/os-release
uname -a
uname -m
printf '%s\n' "$SHELL"
git --version
docker --version
docker context show
docker info
pwd
```

## 10.2 [macOS] 수집 명령

```bash
sw_vers
uname -m
orb version
orb list
docker version
docker context show
```

## 10.3 기록 템플릿

```markdown
# 실행 환경

## macOS 호스트
- Mac 모델:
- CPU 아키텍처:
- macOS 버전:
- OrbStack 버전:
- Docker context:

## OrbStack Ubuntu VM
- VM 이름: codyssey-training
- 배포판: Ubuntu 24.04 LTS
- CPU 아키텍처:
- Shell:
- Git 버전:
- Docker CLI 경로:
- Docker 버전:
- 작업 경로:
- 확인 날짜:
```

---

# 11. 터미널 기본 조작 실습

## 11.1 현재 위치와 목록

```bash
pwd
ls
ls -la
```

## 11.2 생성·복사·이동·삭제

```bash
mkdir -p practice/source
cd practice

touch sample.txt
echo "Codyssey E1-1" > sample.txt
cat sample.txt

cp sample.txt sample-copy.txt
mv sample-copy.txt renamed.txt

mkdir archive
mv renamed.txt archive/
ls -la archive

rm archive/renamed.txt
rmdir archive
```

## 11.3 반드시 기록할 내용

- 명령 입력 화면
- 출력 결과
- 작업 전후의 `ls -la`
- 절대 경로와 상대 경로 사용 예시
- 실패한 명령이 있으면 오류 원문

## 11.4 설명 질문

1. `pwd`와 `ls`는 무엇이 다른가?
2. 절대 경로와 상대 경로는 무엇이 다른가?
3. `cp`와 `mv`는 무엇이 다른가?
4. `rm`은 왜 주의해야 하는가?
5. `.`과 `..`은 각각 무엇인가?

---

# 12. 파일과 디렉터리 권한 실습

## 12.1 권한 기초

```text
r = read    = 4
w = write   = 2
x = execute = 1
```

| 권한 | 소유자 | 그룹 | 기타 사용자 |
|---|---|---|---|
| `755` | `rwx` | `r-x` | `r-x` |
| `644` | `rw-` | `r--` | `r--` |

## 12.2 파일 권한 변경

```bash
cd ~/codyssey-training/codyssey-training-e1-1/practice

touch permission-file.txt
ls -l permission-file.txt
chmod 644 permission-file.txt
ls -l permission-file.txt
chmod 600 permission-file.txt
ls -l permission-file.txt
```

## 12.3 디렉터리 권한 변경

```bash
mkdir -p permission-dir
ls -ld permission-dir
chmod 755 permission-dir
ls -ld permission-dir
chmod 700 permission-dir
ls -ld permission-dir
```

## 12.4 기록 기준

- 변경 전 권한
- 실행한 `chmod` 명령
- 변경 후 권한
- 권한 숫자를 계산한 방법
- 파일의 `x`와 디렉터리의 `x`가 의미하는 차이

---

# 13. Docker 기본 점검

**[Ubuntu VM]** 저장소 루트로 이동합니다.

```bash
cd ~/codyssey-training/codyssey-training-e1-1
```

## 13.1 버전과 엔진

```bash
docker --version
docker version
docker info
```

## 13.2 기본 상태

```bash
docker images
docker ps
docker ps -a
docker stats --no-stream
```

## 13.3 확인할 내용

- Docker Client와 Server의 차이
- 현재 Docker context
- 실행 중 컨테이너 수
- 저장된 이미지 목록
- CPU와 메모리 사용량

---

# 14. Docker 이미지와 컨테이너 운영

## 14.1 hello-world

```bash
docker run --name e1-1-hello hello-world
docker ps
docker ps -a
docker logs e1-1-hello
```

이미 같은 이름이 있다고 나오면 확인 후 기존 컨테이너를 제거합니다.

```bash
docker rm e1-1-hello
docker run --name e1-1-hello hello-world
```

## 14.2 Ubuntu 컨테이너

```bash
docker run -it --name e1-1-ubuntu ubuntu:24.04 bash
```

컨테이너 안에서:

```bash
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

호스트 Ubuntu VM 셸에서:

```bash
docker ps
docker ps -a
docker start e1-1-ubuntu
docker exec e1-1-ubuntu bash -lc 'echo "docker exec test" && ls -la /'
docker logs e1-1-ubuntu
```

## 14.3 중지·시작·삭제

```bash
docker stop e1-1-ubuntu
docker start e1-1-ubuntu
docker rm -f e1-1-ubuntu
```

## 14.4 설명 질문

- 이미지와 컨테이너의 차이는 무엇인가?
- `docker ps`와 `docker ps -a`의 차이는 무엇인가?
- `docker run`과 `docker start`의 차이는 무엇인가?
- `docker exec`는 언제 사용하는가?
- 컨테이너를 삭제해도 이미지는 남는 이유는 무엇인가?

---

# 15. Dockerfile 기반 웹 서버 제작

## 15.1 웹 페이지 작성

```bash
cd ~/codyssey-training/codyssey-training-e1-1
mkdir -p site
cat > site/index.html <<'EOF'
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Codyssey E1-1</title>
</head>
<body>
  <h1>AI/SW 개발 워크스테이션 구축</h1>
  <p>OrbStack Ubuntu 24.04 VM에서 빌드한 Docker 웹 서버입니다.</p>
</body>
</html>
EOF
```

## 15.2 Dockerfile 작성

```bash
cat > Dockerfile <<'EOF'
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-e1-1-web"
LABEL org.opencontainers.image.description="Codyssey E1-1 custom web server"

COPY site/ /usr/share/nginx/html/

EXPOSE 80
EOF
```

## 15.3 `.dockerignore`

```bash
cat > .dockerignore <<'EOF'
.git
.gitignore
docs
practice
*.log
EOF
```

## 15.4 `.gitignore`

```bash
cat > .gitignore <<'EOF'
.DS_Store
*.log
.env
.env.*
!.env.example
EOF
```

## 15.5 이미지 빌드

```bash
docker build -t codyssey-e1-1-web:1.0 .
docker images
```

## 15.6 이미지 정보 확인

```bash
docker image inspect codyssey-e1-1-web:1.0
```

## 15.7 설명 질문

- `FROM`은 무엇을 지정하는가?
- `COPY`는 무엇을 하는가?
- `EXPOSE 80`은 자동으로 Mac 포트를 열어 주는가?
- 이미지 태그 `1.0`은 왜 사용하는가?
- `.dockerignore`가 필요한 이유는 무엇인가?

---

# 16. 포트 매핑과 접속 검증

## 16.1 컨테이너 실행

```bash
docker run -d \
  --name e1-1-web \
  -p 8080:80 \
  codyssey-e1-1-web:1.0
```

## 16.2 상태와 로그

```bash
docker ps
docker logs e1-1-web
docker port e1-1-web
```

## 16.3 Ubuntu VM에서 접속

```bash
curl http://localhost:8080
```

## 16.4 Mac 브라우저에서 접속

Mac 브라우저 주소창에 입력합니다.

```text
http://localhost:8080
```

## 16.5 증거 기준

스크린샷에는 다음이 함께 보여야 합니다.

- 브라우저 주소창
- `localhost:8080`
- 웹 페이지 응답
- 가능하면 관련 `docker ps` 결과

## 16.6 포트 충돌 처리

`8080` 포트가 이미 사용 중이면 먼저 확인합니다.

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}'
```

기존 컨테이너를 임의 삭제하지 말고, 다른 포트를 사용합니다.

```bash
docker run -d \
  --name e1-1-web-8081 \
  -p 8081:80 \
  codyssey-e1-1-web:1.0
```

---

# 17. 바인드 마운트 변경 반영

## 17.1 기존 웹 컨테이너 정리

```bash
docker rm -f e1-1-web 2>/dev/null || true
```

## 17.2 바인드 마운트 실행

```bash
docker run -d \
  --name e1-1-bind \
  -p 8080:80 \
  -v "$PWD/site:/usr/share/nginx/html:ro" \
  nginx:alpine
```

## 17.3 최초 화면 확인

```bash
curl http://localhost:8080
```

## 17.4 호스트 파일 변경

```bash
cat > site/index.html <<'EOF'
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>Bind Mount Test</title>
</head>
<body>
  <h1>바인드 마운트 반영 성공</h1>
  <p>파일을 변경한 뒤 이미지를 다시 빌드하지 않았습니다.</p>
</body>
</html>
EOF
```

## 17.5 변경 반영 확인

```bash
curl http://localhost:8080
```

Mac 브라우저에서도 새로고침합니다.

## 17.6 기록할 내용

- 실행 명령
- 변경 전 화면
- 수정한 파일 내용
- 변경 후 화면
- 이미지를 다시 빌드하지 않아도 변경된 이유
- `:ro` 옵션의 의미

---

# 18. Docker 볼륨 영속성 검증

## 18.1 볼륨 생성

```bash
docker volume create e1-1-data
docker volume ls
```

## 18.2 첫 번째 컨테이너에 연결

```bash
docker run -d \
  --name e1-1-volume-1 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity
```

## 18.3 데이터 작성

```bash
docker exec e1-1-volume-1 \
  bash -lc 'echo "persistent data" > /data/result.txt && cat /data/result.txt'
```

## 18.4 첫 번째 컨테이너 삭제

```bash
docker rm -f e1-1-volume-1
```

## 18.5 새 컨테이너에 같은 볼륨 연결

```bash
docker run -d \
  --name e1-1-volume-2 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity
```

## 18.6 데이터 유지 확인

```bash
docker exec e1-1-volume-2 cat /data/result.txt
```

`persistent data`가 출력되면 영속성이 확인된 것입니다.

## 18.7 설명 질문

- 컨테이너를 삭제했는데 파일이 남은 이유는 무엇인가?
- 바인드 마운트와 볼륨은 누가 저장 위치를 관리하는가?
- 소스코드와 데이터베이스 데이터는 각각 어느 방식이 적합한가?

---

# 19. Git·GitHub·VS Code 연동

## 19.1 Git 설정

```bash
git config --global user.name
git config --global user.email
git config --global init.defaultBranch
git config --list
```

공개 문서에는 토큰·자격증명·민감한 URL이 노출되지 않았는지 확인합니다.

## 19.2 VS Code 실행

OrbStack은 `code` 명령을 기본 연결할 수 있습니다.

```bash
command -v code
code .
```

`code`가 없으면 Mac에 VS Code가 설치되어 있는지 확인한 뒤 다음을 시도합니다.

```bash
mac link code
hash -r
code .
```

## 19.3 Git 상태 확인

```bash
git status
git diff
git branch --show-current
git remote -v
```

## 19.4 권장 커밋 순서

```text
1. Docs: add OrbStack Ubuntu environment baseline
2. Docs: record terminal and permission practice
3. Docs: record Docker basic operations
4. Feat: add custom NGINX Dockerfile and web content
5. Docs: add port mapping verification
6. Docs: add bind mount verification
7. Docs: add Docker volume persistence verification
8. Docs: add troubleshooting cases
9. Docs: add test results and evidence index
10. Docs: finalize E1-1 submission guide
```

## 19.5 commit과 push

```bash
git add .
git status
git commit -m "Docs: record E1-1 workstation practice"
git push origin main
```

> commit 전에 반드시 `git diff --cached` 또는 `git status`로 포함 파일을 확인합니다.

---

# 20. 보안과 민감정보 점검

## 20.1 저장소에 포함하면 안 되는 정보

- GitHub Personal Access Token
- 비밀번호
- SSH 개인키
- 인증 코드
- `.env`의 비밀값
- 사설 시스템 내부 주소
- 학교 또는 회사 계정의 민감정보

## 20.2 점검 명령

```bash
git status
git diff --cached
git grep -n -i -E 'token|password|secret|private.?key' || true
find . -maxdepth 3 -type f \( -name '.env' -o -name '*.pem' -o -name 'id_rsa' \)
```

## 20.3 노출했을 때

1. 더 이상 push하지 않습니다.
2. 노출된 토큰·비밀번호·키를 즉시 폐기 또는 재발급합니다.
3. 파일만 삭제하지 말고 Git 히스토리 제거가 필요한지 확인합니다.
4. 조치 과정을 공개 문서에 비밀값 없이 기록합니다.

---

# 21. 트러블슈팅 기록

미션에서는 최소 2건 이상을 요구합니다. `docs/troubleshooting.md`에 작성합니다.

## 21.1 표준 양식

```markdown
## 문제 ID: TS-01

- 발생 환경:
- 실행 명령:
- 오류 메시지 원문:
- 재현 방법:
- 초기 가설:
- 확인한 명령:
- 실제 원인:
- 해결 또는 대안:
- 해결 검증:
- 재발 방지:
```

## 21.2 권장 주제

- `docker info`에서 엔진 연결 실패
- Docker context가 `orbstack`이 아님
- VM에서 Docker 명령 링크 오류
- 포트 `8080` 충돌
- 컨테이너 이름 중복
- 바인드 마운트 경로 오류
- 파일 권한 때문에 수정 불가
- Git push 인증 실패

## 21.3 좋은 기록의 기준

- 오류 메시지를 그대로 남긴다.
- 추측과 확인된 원인을 구분한다.
- 해결 명령만 적지 않고 왜 해결됐는지 설명한다.
- 같은 문제가 재발했을 때 다시 따라 할 수 있다.

---

# 22. 요구사항·테스트·증거 추적

`docs/requirement-traceability.md`를 작성합니다.

| ID | 요구사항 | 구현·실습 위치 | 검증 명령 | 증거 위치 | 상태 |
|---|---|---|---|---|---|
| E1-1-ENV-01 | Ubuntu 24.04 VM | `codyssey-training` | `cat /etc/os-release` | environment 문서 | ⬜ |
| E1-1-ENV-02 | OrbStack Docker 연동 | VM Docker CLI | `docker version` | Docker 스크린샷 | ⬜ |
| E1-1-CLI-01 | 터미널 기본 조작 | `practice/` | `pwd`, `ls -la` | terminal 문서 | ⬜ |
| E1-1-PERM-01 | 파일 권한 변경 | permission file | `ls -l` | permissions 문서 | ⬜ |
| E1-1-PERM-02 | 디렉터리 권한 변경 | permission dir | `ls -ld` | permissions 문서 | ⬜ |
| E1-1-DOC-01 | Docker 점검 | OrbStack Engine | `docker info` | docker 문서 | ⬜ |
| E1-1-DOC-02 | hello-world | container | `docker logs` | docker 문서 | ⬜ |
| E1-1-IMG-01 | 커스텀 이미지 | `Dockerfile` | `docker build` | build 로그 | ⬜ |
| E1-1-PORT-01 | 포트 매핑 | `8080:80` | `curl` | 브라우저 캡처 | ⬜ |
| E1-1-MOUNT-01 | 바인드 마운트 | `site/` | 변경 전후 비교 | mount 문서 | ⬜ |
| E1-1-VOL-01 | 볼륨 영속성 | `e1-1-data` | 삭제 전후 `cat` | volume 문서 | ⬜ |
| E1-1-GIT-01 | GitHub 연동 | main branch | `git remote -v` | GitHub 캡처 | ⬜ |
| E1-1-TS-01 | 트러블슈팅 2건 | troubleshooting | 재현·복구 | 문서 링크 | ⬜ |
| E1-1-SEC-01 | 민감정보 점검 | 전체 저장소 | `git diff --cached` | 점검 기록 | ⬜ |

---

# 23. README 또는 결과 문서 작성 기준

`training.md`는 수행 방법이고, 실제 평가용 결과는 `README.md` 또는 연결된 `docs/`에서 확인할 수 있어야 합니다.

## 23.1 권장 README 목차

```text
1. 프로젝트 개요
2. 미션 목표
3. 실행 환경
4. OrbStack Ubuntu VM 구성
5. OrbStack Docker 연동
6. 터미널 조작 결과
7. 권한 실습 결과
8. Docker 기본 운영 결과
9. Dockerfile과 커스텀 이미지
10. 포트 매핑 결과
11. 바인드 마운트 결과
12. 볼륨 영속성 결과
13. Git·GitHub·VS Code 연동
14. 트러블슈팅
15. 테스트 결과
16. 증거 인덱스
17. 보안 점검
18. 회고와 제한사항
```

## 23.2 명령 기록 원칙

나쁜 예:

```text
Docker가 잘 실행되었다.
```

좋은 예:

```bash
$ docker context show
orbstack

$ docker run --rm hello-world
Hello from Docker!
```

명령 입력과 출력 결과가 함께 있어야 합니다.

---

# 24. 권장 40시간 학습계획

| 단계 | 시간 | 학습 내용 | 결과물 |
|---|---:|---|---|
| 1 | 2시간 | 미션·용어·요구사항 분석 | 요구사항 표 |
| 2 | 4시간 | OrbStack·Ubuntu VM 생성 | 환경 기준선 |
| 3 | 3시간 | OrbStack Docker 연동 | hello-world 증거 |
| 4 | 4시간 | 터미널·경로·파일 조작 | CLI 로그 |
| 5 | 3시간 | 권한 실습 | 변경 전후 자료 |
| 6 | 5시간 | Docker 이미지·컨테이너 운영 | 운영 로그 |
| 7 | 5시간 | Dockerfile·이미지 빌드 | 웹 이미지 |
| 8 | 3시간 | 포트 매핑 | 접속 증거 |
| 9 | 3시간 | 바인드 마운트 | 변경 반영 증거 |
| 10 | 3시간 | 볼륨 영속성 | 삭제 전후 증거 |
| 11 | 2시간 | Git·GitHub·VS Code | 연동 증거 |
| 12 | 2시간 | 트러블슈팅·문서화 | 문제 2건 이상 |
| 13 | 1시간 | clean clone·모의평가 | 최종 점검 |
| 합계 | 40시간 |  |  |

---

# 25. 단계별 품질 게이트

## Gate 0. 환경 준비

- [ ] OrbStack이 실행된다.
- [ ] `codyssey-training` VM이 존재한다.
- [ ] Ubuntu 24.04 LTS가 확인된다.
- [ ] VM에서 `docker version`이 정상이다.
- [ ] Docker context가 `orbstack`이다.
- [ ] 저장소가 VM 홈 디렉터리에 clone되어 있다.

## Gate 1. 터미널·권한

- [ ] 파일과 디렉터리를 생성·복사·이동·삭제했다.
- [ ] 파일 권한을 변경했다.
- [ ] 디렉터리 권한을 변경했다.
- [ ] `755`와 `644`를 설명할 수 있다.

## Gate 2. Docker 기본 운영

- [ ] `docker --version`, `docker info`를 기록했다.
- [ ] `hello-world`를 실행했다.
- [ ] Ubuntu 컨테이너에 진입했다.
- [ ] `images`, `ps`, `ps -a`, `logs`, `stats`를 실행했다.

## Gate 3. Dockerfile·포트

- [ ] Dockerfile을 직접 작성했다.
- [ ] 커스텀 이미지 빌드에 성공했다.
- [ ] `8080:80` 포트 매핑에 성공했다.
- [ ] Mac 브라우저 주소창이 포함된 캡처가 있다.

## Gate 4. 스토리지

- [ ] 바인드 마운트 변경 전후를 비교했다.
- [ ] 볼륨에 데이터를 저장했다.
- [ ] 컨테이너 삭제 후 새 컨테이너에서 데이터를 확인했다.

## Gate 5. 제출 준비

- [ ] 트러블슈팅이 2건 이상이다.
- [ ] 민감정보가 없다.
- [ ] 모든 링크와 이미지가 열린다.
- [ ] Default branch가 `main`이다.
- [ ] 원격 저장소에 최종 내용이 push되어 있다.
- [ ] 문서만 보고 clean clone 재현에 성공했다.

---

# 26. 시험·동료평가 대비

## 26.1 피평가자 시연 순서

1. 미션 목표 설명
2. macOS·OrbStack·Ubuntu VM 구조 설명
3. `codyssey-training` VM 확인
4. OrbStack Docker 연동 확인
5. 환경 버전 확인
6. 터미널 조작 시연
7. 권한 변경 시연
8. Docker 이미지와 컨테이너 시연
9. Dockerfile 빌드
10. 포트 매핑 접속
11. 바인드 마운트 변경 반영
12. 볼륨 영속성
13. Git 이력
14. 트러블슈팅 2건
15. 보안 점검

## 26.2 예상 구두질문

1. OrbStack Linux VM과 Docker 컨테이너는 무엇이 다른가?
2. 왜 VM 이름을 `codyssey-training`으로 지정했는가?
3. Ubuntu VM 안에 Docker Engine을 별도로 설치하지 않은 이유는 무엇인가?
4. Docker context `orbstack`은 무엇을 의미하는가?
5. 이미지와 컨테이너는 무엇이 다른가?
6. `-p 8080:80`의 두 포트는 각각 무엇인가?
7. Dockerfile의 `FROM`, `COPY`, `EXPOSE`를 설명하라.
8. 바인드 마운트와 Docker 볼륨을 비교하라.
9. 컨테이너를 삭제했는데 볼륨 데이터가 남는 이유는 무엇인가?
10. 권한 `755`와 `644`를 설명하라.
11. Git과 GitHub의 차이는 무엇인가?
12. 가장 어려웠던 오류를 문제→원인→해결 순서로 설명하라.

## 26.3 평가자가 확인할 항목

- GitHub Default branch의 내용인지
- 문서대로 실제 재현 가능한지
- 명령과 출력이 함께 기록되어 있는지
- 필수 기능이 실제 동작하는지
- 설명이 본인의 이해에 기반하는지
- 민감정보가 노출되지 않았는지

---

# 27. FAIL 이후 보완 절차

1. FAIL 근거를 요구사항 ID와 연결합니다.
2. 재현 명령과 실제 출력을 기록합니다.
3. 원인을 다음 중 하나로 분류합니다.
   - 개념 부족
   - 환경 설정 오류
   - Docker 연동 오류
   - 구현 누락
   - 증거 누락
   - 문서 오류
   - 설명 부족
4. 작은 단위로 수정합니다.
5. 관련 테스트를 다시 실행합니다.
6. 다른 필수 기능이 깨지지 않았는지 회귀 테스트합니다.
7. clean clone으로 재현합니다.
8. 모의 구두설명을 다시 진행합니다.
9. 수정 내용을 별도 commit으로 남깁니다.

---

# 28. 보너스 과제

필수 항목을 모두 완료한 후에만 수행합니다.

## 28.1 Docker Compose 단일 서비스

```yaml
services:
  web:
    build: .
    ports:
      - "8080:80"
```

```bash
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

## 28.2 멀티 컨테이너

- 웹 서버와 보조 서비스 2개 이상 실행
- 서비스 이름을 통한 컨테이너 간 통신 확인
- Compose 네트워크 설명

## 28.3 환경 변수

- Dockerfile 또는 Compose에서 환경 변수 주입
- 설정과 코드 분리 이유 설명

## 28.4 GitHub SSH

OrbStack은 Mac의 SSH agent를 Linux VM에 전달할 수 있습니다.

```bash
echo "$SSH_AUTH_SOCK"
ssh -T git@github.com
```

개인키 파일을 저장소에 복사하거나 commit하지 않습니다.

---

# 29. 최종 제출 체크리스트

## 환경

- [ ] OrbStack 버전 기록
- [ ] `codyssey-training` VM 확인
- [ ] Ubuntu 24.04 LTS 확인
- [ ] VM에서 OrbStack Docker 연동 확인
- [ ] Docker context `orbstack` 확인

## 터미널과 권한

- [ ] 위치·목록·이동·생성·복사·이름변경·삭제 기록
- [ ] 파일 내용 확인 및 빈 파일 생성
- [ ] 파일 권한 변경 전후
- [ ] 디렉터리 권한 변경 전후

## Docker

- [ ] `docker --version`
- [ ] `docker info`
- [ ] `docker images`
- [ ] `docker ps`
- [ ] `docker ps -a`
- [ ] `docker logs`
- [ ] `docker stats`
- [ ] `hello-world`
- [ ] Ubuntu 컨테이너

## Dockerfile과 네트워크

- [ ] Dockerfile 직접 작성
- [ ] 커스텀 이미지 빌드
- [ ] 컨테이너 실행
- [ ] 포트 매핑
- [ ] Mac 브라우저 주소창 포함 접속 증거

## 스토리지

- [ ] 바인드 마운트 실행 명령
- [ ] 변경 전후 화면
- [ ] 볼륨 생성·연결
- [ ] 컨테이너 삭제 전후 데이터 유지

## Git·문서·평가

- [ ] Git 사용자와 기본 브랜치 설정
- [ ] GitHub/VS Code 연동 증거
- [ ] 트러블슈팅 2건 이상
- [ ] 요구사항 추적표
- [ ] 테스트 결과
- [ ] 증거 인덱스
- [ ] 민감정보 마스킹
- [ ] 모든 변경 commit·push
- [ ] Default branch 확인
- [ ] clean clone 재현 성공
- [ ] 구두 설명 준비

---

# 공식 참고 문서

- OrbStack Linux machines: <https://docs.orbstack.dev/machines/>
- OrbStack Linux distributions: <https://docs.orbstack.dev/machines/distros>
- OrbStack machine commands: <https://docs.orbstack.dev/machines/commands>
- OrbStack Docker: <https://docs.orbstack.dev/docker/>
- OrbStack file sharing: <https://docs.orbstack.dev/machines/file-sharing>

---

## 최종 완료 정의

다음 문장을 모두 만족하면 E1-1 미션 제출 준비가 완료된 것입니다.

> `codyssey-training`이라는 OrbStack Ubuntu 24.04 VM에서 작업했다.  
> Ubuntu VM의 Docker 명령은 Mac의 OrbStack Docker Engine과 연결되어 있다.  
> 터미널·권한·Docker·Dockerfile·포트·마운트·볼륨·GitHub 실습을 직접 수행했다.  
> 모든 결과는 명령과 출력, 스크린샷, 트러블슈팅 문서로 검증할 수 있다.  
> 평가자는 저장소 문서만 보고 동일한 절차를 재현할 수 있다.
