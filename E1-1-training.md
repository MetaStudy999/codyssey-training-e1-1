# E1-1. AI/SW 개발 워크스테이션 구축 — 입문자 수행 가이드

> 코디세이 입학연수 · 개발 입문 · 학습시간 40시간  
> 주 실습환경: **macOS + OrbStack + Ubuntu 24.04 LTS + OrbStack Docker**  
> OrbStack Linux machine 이름: **`codyssey-training`**

이 문서는 입문자가 코디세이 E1-1 미션을 **환경 준비 → Linux 실습 → Docker 실습 → 증거 수집 → GitHub 제출 → 동료평가 준비** 순서로 수행하도록 만든 단계별 지침서입니다.

> 아래 명령은 본인의 환경에서 직접 실행해야 합니다. 문서의 예시 출력이나 다른 사람의 화면을 제출물로 사용하지 않습니다.

---

## 문서 표시 기준

| 표시 | 의미 |
|---|---|
| **[필수]** | 코디세이 미션 문서에서 요구하는 항목 |
| **[권장]** | 입문자의 안정적인 수행과 평가 준비를 위한 보완 항목 |
| **[보너스]** | 필수 과제를 완료한 뒤 수행하는 선택 항목 |
| **[macOS]** | Mac 터미널에서 실행 |
| **[Ubuntu]** | OrbStack의 `codyssey-training` Linux machine 안에서 실행 |

공식 문서 번호 `[R1]` 등은 문서 마지막의 **공식 참고문헌**과 연결됩니다.

---

# 목차

1. 미션 목표와 완료 기준
2. 전체 수행 순서
3. 구조와 용어 이해
4. 최종 저장소 구조
5. macOS와 OrbStack 사전 점검
6. Ubuntu 24.04 `codyssey-training` 생성
7. Ubuntu 기본 환경 설정
8. OrbStack Docker 연동
9. GitHub 저장소 복제
10. 환경 기준선 기록
11. 터미널 기본 조작
12. 파일과 디렉터리 권한
13. Docker 기본 점검
14. 이미지와 컨테이너 운영
15. Dockerfile 기반 웹 서버
16. 포트 매핑과 접속 검증
17. 바인드 마운트
18. Docker 볼륨 영속성
19. Git·GitHub·VS Code
20. 보안과 민감정보
21. 트러블슈팅
22. 요구사항·테스트·증거 추적
23. 결과 README 작성
24. 40시간 권장 학습계획
25. 품질 게이트
26. 시험·동료평가 대비
27. FAIL 이후 보완
28. 보너스 과제
29. 최종 제출 체크리스트
30. 공식 참고문헌

---

# 1. 미션 목표와 완료 기준

## 1.1 [필수] 최종 산출물

GitHub 저장소에서 다음 내용을 확인할 수 있어야 합니다.

- 터미널로 파일과 디렉터리를 생성·복사·이동·삭제한다.
- 파일과 디렉터리의 권한을 확인하고 변경한다.
- Docker 버전과 Engine 상태를 점검한다.
- Docker 이미지와 컨테이너를 실행·중지·조회한다.
- `Dockerfile`을 직접 작성하고 커스텀 이미지를 빌드한다.
- 포트 매핑으로 웹 서버에 접속한다.
- 바인드 마운트로 호스트 파일 변경이 반영되는지 확인한다.
- Docker 볼륨으로 컨테이너 삭제 후에도 데이터가 유지되는지 확인한다.
- Git 사용자 설정과 GitHub·VS Code 연동 상태를 기록한다.
- 트러블슈팅을 최소 2건 이상 기록한다.
- 기술 문서만 보고 평가자가 동일 절차를 재현할 수 있게 한다.
- 로그와 이미지에 토큰·비밀번호·개인키를 노출하지 않는다.

## 1.2 학습 후 설명할 수 있어야 하는 내용

- 절대 경로와 상대 경로의 차이
- 파일 권한 `r`, `w`, `x`와 `755`, `644`
- OrbStack Linux machine과 Docker 컨테이너의 차이
- Docker 이미지와 컨테이너의 차이
- Dockerfile과 이미지 빌드의 관계
- 호스트 포트와 컨테이너 포트의 차이
- 바인드 마운트와 Docker 볼륨의 차이
- Git과 GitHub의 역할 차이
- 오류를 `문제 → 가설 → 확인 → 해결 → 재검증`으로 분석하는 방법

---

# 2. 전체 수행 순서

입문자는 다음 순서를 유지합니다.

```text
1. Mac에서 OrbStack 실행 확인
2. Ubuntu 24.04 Linux machine 생성
3. machine 이름을 codyssey-training으로 고정
4. Ubuntu 기본 도구 설치
5. Ubuntu에서 OrbStack Docker 명령 연결
6. GitHub 저장소 clone
7. 실행 환경 기준선 기록
8. 터미널 조작 실습
9. 파일·디렉터리 권한 실습
10. Docker 기본 운영
11. Dockerfile 작성과 이미지 빌드
12. 포트 매핑 검증
13. 바인드 마운트 검증
14. 볼륨 영속성 검증
15. Git·GitHub·VS Code 증거 정리
16. 트러블슈팅 2건 이상 작성
17. 요구사항·테스트·증거 추적표 작성
18. clean clone 재현 시험
19. 모의 동료평가
20. 최종 push와 제출
```

---

# 3. 구조와 용어 이해

## 3.1 전체 구조

```text
Mac
├── macOS
├── OrbStack 애플리케이션
│   ├── Linux machine: codyssey-training
│   │   └── Ubuntu 24.04 LTS
│   │       └── Git 저장소 작업 폴더
│   └── OrbStack Docker Engine
│       ├── images
│       ├── containers
│       └── volumes
└── 브라우저 / VS Code
```

OrbStack은 Docker 컨테이너와 Linux machine을 실행할 수 있습니다. Linux machine은 경량 Linux 실행환경이고, Docker 컨테이너는 Docker 이미지에서 실행되는 격리된 프로세스 환경입니다. 두 개념을 혼동하지 않습니다. [R1][R2]

## 3.2 핵심 용어

| 용어 | 의미 |
|---|---|
| macOS 호스트 | OrbStack이 설치된 실제 Mac |
| OrbStack | Mac에서 Docker와 Linux machine을 실행·관리하는 도구 |
| Linux machine | OrbStack 안에서 실행되는 Linux 환경 |
| `codyssey-training` | 이 과정의 Ubuntu 24.04 machine 이름 |
| Docker Engine | 이미지·컨테이너·네트워크·볼륨을 관리하는 엔진 |
| Docker CLI | `docker run`, `docker ps` 등의 명령 도구 |
| Docker context | Docker CLI가 연결할 Engine 대상을 나타내는 설정 |
| 이미지 | 컨테이너 실행에 필요한 파일과 설정의 템플릿 |
| 컨테이너 | 이미지를 기반으로 실행한 인스턴스 |
| Dockerfile | 이미지를 만드는 명령을 기록한 텍스트 문서 |
| 포트 매핑 | 호스트 포트와 컨테이너 포트를 연결하는 작업 |
| 바인드 마운트 | 실제 디렉터리를 컨테이너 경로에 직접 연결하는 방식 |
| 볼륨 | Docker가 관리하는 영속 저장소 |
| Git | 로컬 변경 이력 관리 도구 |
| GitHub | Git 저장소를 원격에서 저장·공유·협업하는 서비스 |

---

# 4. 최종 저장소 구조

```text
codyssey-training-e1-1/
├── E1-1-training.md          # 현재 학습 지침서
├── README.md                 # 실제 수행 결과와 평가용 문서
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

`E1-1-training.md`는 수행 방법을 설명합니다. 실제 명령 출력, 화면, 문제 해결 결과는 `README.md`와 `docs/`에 기록합니다.

---

# 5. macOS와 OrbStack 사전 점검

## 5.1 [macOS] OrbStack 실행

1. OrbStack 애플리케이션을 실행합니다.
2. 메뉴 막대에서 실행 상태를 확인합니다.
3. Mac 터미널을 엽니다.

## 5.2 [macOS] OrbStack CLI 확인

```bash
orb version
orb status
orb list
```

정상 기준:

- `orb version`에 버전이 출력된다.
- `orb status`가 오류 없이 실행된다.
- `orb list`에서 machine 목록을 볼 수 있다.

OrbStack은 GUI뿐 아니라 `orb` 명령으로 machine 생성·접속·시작·중지 등을 수행할 수 있습니다. [R3]

## 5.3 [macOS] OrbStack Docker 확인

```bash
docker version
docker context ls
docker context show
```

현재 context가 `orbstack`이 아니면 다음을 실행합니다.

```bash
docker context use orbstack
docker context show
```

정상 기준:

- Docker Client와 Server 정보가 출력된다.
- 현재 context가 `orbstack`이다.

---

# 6. Ubuntu 24.04 `codyssey-training` 생성

OrbStack은 Ubuntu를 포함한 여러 Linux 배포판과 버전을 지원합니다. Ubuntu 24.04 LTS의 코드명은 `noble`이며, 공식 문서는 `orb create ubuntu:noble` 형식을 제시합니다. [R2][R4]

## 6.1 기존 machine 확인

**[macOS]**

```bash
orb list
```

`codyssey-training`이 이미 있으면 새로 만들지 않습니다.

```bash
orb info codyssey-training
```

> `orb delete`는 machine 내부 데이터를 삭제할 수 있으므로 입문자는 임의로 실행하지 않습니다.

## 6.2 새 machine 생성

다음 두 방식 중 **하나만** 실행합니다.

### 기본 생성

```bash
orb create ubuntu:noble codyssey-training
```

### 자원 제한을 포함한 권장 생성

```bash
orb create \
  --memory 4G \
  --cpus 2 \
  --disk 32G \
  ubuntu:noble \
  codyssey-training
```

OrbStack 공식 문서는 생성 시 CPU·메모리·디스크 제한을 지정할 수 있다고 설명합니다. [R2]

## 6.3 생성 결과 확인

```bash
orb list
orb info codyssey-training
```

## 6.4 machine 접속

```bash
orb -m codyssey-training
```

특정 machine과 사용자를 지정하는 형식은 OrbStack 공식 명령 문서에서 확인할 수 있습니다. [R3]

## 6.5 Ubuntu 버전 확인

**[Ubuntu]**

```bash
cat /etc/os-release
uname -a
uname -m
whoami
pwd
```

정상 기준:

- Ubuntu 24.04 또는 `VERSION_CODENAME=noble`이 표시된다.
- 현재 사용자와 홈 디렉터리가 확인된다.

## 6.6 종료·재접속·중지·시작

Ubuntu 셸에서 Mac으로 돌아가기:

```bash
exit
```

다시 접속하기:

```bash
orb -m codyssey-training
```

machine 중지와 시작:

```bash
orb stop codyssey-training
orb start codyssey-training
```

사용 중인 OrbStack 버전의 정확한 옵션은 다음 명령으로 확인합니다.

```bash
orb stop --help
orb start --help
```

---

# 7. Ubuntu 기본 환경 설정

## 7.1 패키지 목록 갱신

**[Ubuntu]**

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

## 7.4 파일 공유 위치 확인

OrbStack Linux machine에서는 Mac 파일을 `/mnt/mac`에서 볼 수 있으며, Mac에서는 Linux 파일을 `~/OrbStack` 또는 Finder의 OrbStack 항목에서 볼 수 있습니다. [R2][R5]

```bash
ls -la /mnt/mac | head
```

실습 저장소는 Linux 권한과 경로를 안정적으로 연습하도록 Ubuntu 홈 디렉터리에 둡니다.

```bash
mkdir -p ~/codyssey-training
cd ~/codyssey-training
pwd
```

---

# 8. OrbStack Docker 연동

## 8.1 사용 구조

```text
Ubuntu 24.04 machine의 터미널
        ↓ docker 명령
macOS의 OrbStack Docker CLI
        ↓
OrbStack Docker Engine
        ↓
이미지·컨테이너·볼륨
```

이 과정에서는 Ubuntu machine 안에 `docker.io`, `docker-ce`, `containerd`를 별도 설치하지 않습니다. 별도 Engine을 설치하면 OrbStack Docker와 서로 다른 이미지·컨테이너·볼륨을 보게 되어 입문자가 혼동할 수 있습니다.

OrbStack은 Docker 컨테이너 실행환경을 제공하고, Linux machine은 `mac` 명령과 command linking으로 macOS 명령을 사용할 수 있습니다. [R3][R6]

## 8.2 [Ubuntu] macOS의 Docker 위치 확인

```bash
mac which docker
```

## 8.3 기존 Docker 명령 확인

```bash
command -v docker || true
type -a docker || true
docker version
docker context show
```

정상 실행되면 8.4를 건너뜁니다.

## 8.4 Docker 명령이 없을 때 연결

```bash
mac link docker
hash -r
command -v docker
docker version
docker context show
```

`mac link`는 macOS 명령을 Linux machine에서 일반 명령처럼 사용할 수 있게 연결합니다. [R3]

## 8.5 링크가 깨졌을 때

다음 증상이 있을 때만 실행합니다.

- `command -v docker`는 출력되지만 실행 실패
- `/opt/orbstack-guest/.../cmdlinks/docker` 관련 오류
- 오래된 command link가 남아 있는 것으로 판단됨

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

Mac에서도 확인합니다.

```bash
orb status
docker context use orbstack
docker version
```

OrbStack 자체 재시작이 필요하면 앱 메뉴를 이용하거나 현재 버전의 도움말을 먼저 확인합니다.

```bash
orb restart --help
```

## 8.6 최종 연동 시험

**[Ubuntu]**

```bash
docker run --rm hello-world
docker ps
docker ps -a
docker images
```

**[macOS]** 별도 터미널:

```bash
docker images
```

Mac과 Ubuntu에서 같은 이미지 목록이 보이면 같은 OrbStack Docker Engine을 사용하는 것입니다.

## 8.7 증거로 남길 내용

- `orb list`
- Ubuntu 24.04 확인 결과
- `command -v docker`
- `docker context show`
- `docker version`
- `docker run --rm hello-world`
- Mac과 Ubuntu의 `docker images`

---

# 9. GitHub 저장소 복제

GitHub 저장소를 clone하면 원격 저장소의 로컬 복사본이 생성됩니다. [R17][R18]

## 9.1 Git 사용자 정보 설정

**[Ubuntu]**

```bash
git config --global user.name
git config --global user.email
```

값이 없으면 설정합니다.

```bash
git config --global user.name "YOUR_NAME"
git config --global user.email "YOUR_EMAIL"
git config --global init.defaultBranch main
```

Git 초기 설정과 GitHub 인증 방식은 GitHub 공식 문서를 기준으로 확인합니다. [R17]

## 9.2 저장소 clone

```bash
cd ~/codyssey-training

git clone https://github.com/MetaStudy999/codyssey-training-e1-1.git
cd codyssey-training-e1-1
```

## 9.3 상태 확인

```bash
pwd
git status
git branch --show-current
git remote -v
ls -la
```

정상 기준:

- 현재 경로: `~/codyssey-training/codyssey-training-e1-1`
- 현재 브랜치: `main`
- 원격 저장소: `MetaStudy999/codyssey-training-e1-1`

---

# 10. 환경 기준선 기록

```bash
mkdir -p docs/screenshots/{environment,terminal,permissions,docker,port,mount,volume,github}
touch docs/environment.md
```

## 10.1 [Ubuntu] 수집 명령

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

## OrbStack Ubuntu
- machine 이름: codyssey-training
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

# 11. 터미널 기본 조작

GNU Coreutils 공식 문서는 `pwd`, `ls`, `mkdir`, `touch`, `cp`, `mv`, `rm`, `rmdir`, `cat`, `chmod` 등 기본 명령의 기준 문서입니다. [R16]

## 11.1 위치와 목록

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

## 11.3 기록 항목

- 명령 입력과 출력
- 작업 전후의 `ls -la`
- 절대 경로와 상대 경로 사용 예
- 오류가 발생했다면 오류 원문

## 11.4 설명 질문

1. `pwd`와 `ls`는 무엇이 다른가?
2. 절대 경로와 상대 경로는 무엇이 다른가?
3. `cp`와 `mv`는 무엇이 다른가?
4. `rm`은 왜 주의해야 하는가?
5. `.`과 `..`은 무엇인가?

---

# 12. 파일과 디렉터리 권한

## 12.1 권한 계산

```text
r = read    = 4
w = write   = 2
x = execute = 1
```

| 권한 | 소유자 | 그룹 | 기타 사용자 |
|---|---|---|---|
| `755` | `rwx` | `r-x` | `r-x` |
| `644` | `rw-` | `r--` | `r--` |

`chmod`는 파일의 접근 권한을 변경하는 명령입니다. 구체적인 모드 해석과 옵션은 GNU Coreutils 공식 문서를 따릅니다. [R15][R16]

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

## 12.4 기록 항목

- 변경 전 권한
- 실행한 `chmod`
- 변경 후 권한
- 숫자를 계산한 방법
- 파일과 디렉터리에서 `x`의 의미 차이

---

# 13. Docker 기본 점검

```bash
cd ~/codyssey-training/codyssey-training-e1-1
```

## 13.1 버전과 Engine

```bash
docker --version
docker version
docker info
```

## 13.2 상태 확인

```bash
docker images
docker ps
docker ps -a
docker stats --no-stream
```

Docker 명령의 정확한 옵션은 Docker CLI 공식 레퍼런스를 기준으로 확인합니다. [R7]

---

# 14. 이미지와 컨테이너 운영

## 14.1 hello-world

```bash
docker run --name e1-1-hello hello-world
docker ps
docker ps -a
docker logs e1-1-hello
```

같은 이름이 이미 있으면 확인 후 제거합니다.

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

Ubuntu machine 셸에서:

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

- 이미지와 컨테이너의 차이
- `docker ps`와 `docker ps -a`의 차이
- `docker run`과 `docker start`의 차이
- `docker exec`의 사용 목적
- 컨테이너 삭제 후에도 이미지가 남는 이유

---

# 15. Dockerfile 기반 웹 서버

Dockerfile은 이미지를 조립하는 명령을 기록한 텍스트 문서입니다. `FROM`, `COPY`, `EXPOSE`의 정확한 의미는 Dockerfile 공식 레퍼런스를 따릅니다. [R8]

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
  <p>OrbStack Ubuntu 24.04에서 빌드한 Docker 웹 서버입니다.</p>
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

`.dockerignore`는 빌드 컨텍스트에서 불필요한 파일을 제외합니다. [R9]

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

## 15.5 이미지 빌드와 확인

```bash
docker build -t codyssey-e1-1-web:1.0 .
docker images
docker image inspect codyssey-e1-1-web:1.0
```

## 15.6 설명 질문

- `FROM`의 역할
- `COPY`의 역할
- `EXPOSE 80`과 실제 포트 공개의 차이
- 이미지 태그 `1.0`의 목적
- `.dockerignore`의 필요성

---

# 16. 포트 매핑과 접속 검증

Docker 공식 문서에서 `-p 8080:80`은 Docker 호스트의 8080 포트를 컨테이너의 80 포트에 매핑합니다. [R10]

## 16.1 컨테이너 실행

```bash
docker run -d \
  --name e1-1-web \
  -p 8080:80 \
  codyssey-e1-1-web:1.0
```

## 16.2 상태·로그·포트

```bash
docker ps
docker logs e1-1-web
docker port e1-1-web
```

## 16.3 Ubuntu에서 접속

```bash
curl http://localhost:8080
```

## 16.4 Mac 브라우저에서 접속

```text
http://localhost:8080
```

스크린샷에는 주소창, 포트, 웹 페이지가 함께 보여야 합니다.

## 16.5 포트 충돌

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}'
```

기존 서비스를 임의 삭제하지 말고 다른 포트를 선택합니다.

```bash
docker run -d \
  --name e1-1-web-8081 \
  -p 8081:80 \
  codyssey-e1-1-web:1.0
```

---

# 17. 바인드 마운트

바인드 마운트는 호스트의 파일 또는 디렉터리를 컨테이너에 직접 연결합니다. 호스트 디렉터리 구조에 의존하며 기본적으로 쓰기 권한이 있으므로, 필요하면 읽기 전용으로 제한합니다. [R11]

## 17.1 기존 컨테이너 정리

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

## 17.3 최초 화면

```bash
curl http://localhost:8080
```

## 17.4 파일 변경

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
  <p>이미지를 다시 빌드하지 않고 파일 변경을 반영했습니다.</p>
</body>
</html>
EOF
```

## 17.5 변경 확인

```bash
curl http://localhost:8080
```

브라우저도 새로고침합니다.

## 17.6 기록 항목

- 실행 명령
- 변경 전 화면
- 수정한 파일
- 변경 후 화면
- 다시 빌드하지 않아도 반영된 이유
- `:ro`의 의미

---

# 18. Docker 볼륨 영속성

Docker 볼륨은 Docker가 생성·관리하는 영속 저장소이며, 사용하는 컨테이너가 제거되어도 데이터가 유지될 수 있습니다. [R12][R13]

## 18.1 볼륨 생성

```bash
docker volume create e1-1-data
docker volume ls
```

## 18.2 첫 번째 컨테이너

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

## 18.5 새 컨테이너 연결

```bash
docker run -d \
  --name e1-1-volume-2 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity
```

## 18.6 데이터 확인

```bash
docker exec e1-1-volume-2 cat /data/result.txt
```

`persistent data`가 출력되어야 합니다.

## 18.7 설명 질문

- 컨테이너 삭제 후 데이터가 남은 이유
- 바인드 마운트와 볼륨의 저장 위치 관리 주체
- 소스코드 공유와 장기 데이터 저장에 적합한 방식

---

# 19. Git·GitHub·VS Code

## 19.1 Git 상태 확인

```bash
git config --global user.name
git config --global user.email
git config --global init.defaultBranch
git status
git branch --show-current
git remote -v
```

Git 명령의 정확한 동작은 Git 공식 레퍼런스를 기준으로 확인합니다. [R14]

## 19.2 VS Code 실행

OrbStack은 일부 macOS 명령을 Linux machine에서 사용할 수 있도록 연결하며 `code`가 기본 연결되는 경우가 있습니다. [R3]

```bash
command -v code
code .
```

없으면 Mac에 VS Code가 설치되어 있는지 확인한 뒤:

```bash
mac link code
hash -r
code .
```

VS Code의 Git·GitHub 연동 방식은 VS Code 공식 문서를 참고합니다. [R21][R22]

## 19.3 권장 커밋 계획

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
10. Docs: finalize E1-1 submission
```

## 19.4 commit과 push

```bash
git add .
git status
git diff --cached
git commit -m "Docs: record E1-1 workstation practice"
git push origin main
```

---

# 20. 보안과 민감정보

## 20.1 저장소에 포함하지 않을 정보

- GitHub Personal Access Token
- 비밀번호
- SSH 개인키
- 인증 코드
- `.env`의 비밀값
- 학교·회사 내부 시스템의 민감정보

## 20.2 commit 전 점검

```bash
git status
git diff --cached
git grep -n -i -E 'token|password|secret|private.?key' || true
find . -maxdepth 3 -type f \( -name '.env' -o -name '*.pem' -o -name 'id_rsa' \)
```

## 20.3 노출 시 대응

1. 추가 push를 중단합니다.
2. 노출된 비밀값을 즉시 폐기하거나 교체합니다.
3. 파일 삭제만으로 끝내지 않습니다.
4. Git 히스토리 제거 필요성을 검토합니다.
5. 공개 문서에는 비밀값을 제외한 조치 과정만 기록합니다.

GitHub는 노출된 secret을 코드에서 삭제하는 것만으로는 충분하지 않으며, 우선 폐기·교체하고 필요하면 저장소 이력에서 제거하도록 안내합니다. [R19][R20]

---

# 21. 트러블슈팅

`docs/troubleshooting.md`에 최소 2건을 기록합니다.

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
- 참고한 공식 문서:
```

## 21.2 권장 주제

- Docker Engine 연결 실패
- Docker context가 `orbstack`이 아님
- Ubuntu에서 Docker command link 실패
- 포트 8080 충돌
- 컨테이너 이름 중복
- 바인드 마운트 경로 오류
- 파일 권한 오류
- Git push 인증 실패

## 21.3 좋은 기록의 기준

- 오류 원문을 보존한다.
- 추측과 확인된 사실을 분리한다.
- 해결 명령뿐 아니라 해결된 이유를 설명한다.
- 공식 문서 링크를 남긴다.
- 같은 문제가 발생해도 재현·복구할 수 있다.

---

# 22. 요구사항·테스트·증거 추적

`docs/requirement-traceability.md`를 작성합니다.

| ID | 요구사항 | 구현·실습 | 검증 명령 | 증거 | 상태 |
|---|---|---|---|---|---|
| ENV-01 | Ubuntu 24.04 | `codyssey-training` | `cat /etc/os-release` | environment | ⬜ |
| ENV-02 | OrbStack Docker | Docker link | `docker version` | Docker 화면 | ⬜ |
| CLI-01 | 터미널 조작 | `practice/` | `pwd`, `ls -la` | terminal | ⬜ |
| PERM-01 | 파일 권한 | permission file | `ls -l` | permissions | ⬜ |
| PERM-02 | 디렉터리 권한 | permission dir | `ls -ld` | permissions | ⬜ |
| DOC-01 | Docker 점검 | OrbStack Engine | `docker info` | docker | ⬜ |
| DOC-02 | hello-world | container | `docker logs` | docker | ⬜ |
| IMG-01 | 커스텀 이미지 | `Dockerfile` | `docker build` | build log | ⬜ |
| PORT-01 | 포트 매핑 | `8080:80` | `curl` | 브라우저 | ⬜ |
| MOUNT-01 | 바인드 마운트 | `site/` | 변경 비교 | mount | ⬜ |
| VOL-01 | 볼륨 영속성 | `e1-1-data` | 삭제 전후 `cat` | volume | ⬜ |
| GIT-01 | GitHub 연동 | `main` | `git remote -v` | GitHub | ⬜ |
| TS-01 | 문제 해결 2건 | troubleshooting | 재현·복구 | 문서 | ⬜ |
| SEC-01 | 민감정보 점검 | 전체 | `git diff --cached` | 점검 기록 | ⬜ |

---

# 23. 결과 README 작성

`E1-1-training.md`는 학습 지침서입니다. 평가용 결과는 `README.md` 또는 README에서 연결한 `docs/`에 기록합니다.

## 23.1 README 권장 목차

```text
1. 프로젝트 개요
2. 미션 목표
3. 실행 환경
4. OrbStack Ubuntu 구성
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
19. 참고문헌
```

## 23.2 기록 원칙

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

명령 입력과 출력 결과를 함께 기록합니다.

---

# 24. 40시간 권장 학습계획

| 단계 | 시간 | 학습 내용 | 결과물 |
|---|---:|---|---|
| 1 | 2시간 | 미션·용어·요구사항 | 요구사항 표 |
| 2 | 4시간 | OrbStack·Ubuntu 생성 | 환경 기준선 |
| 3 | 3시간 | OrbStack Docker 연결 | hello-world 증거 |
| 4 | 4시간 | 터미널·경로 | CLI 로그 |
| 5 | 3시간 | 권한 | 전후 비교 |
| 6 | 5시간 | Docker 운영 | 운영 로그 |
| 7 | 5시간 | Dockerfile·빌드 | 웹 이미지 |
| 8 | 3시간 | 포트 매핑 | 접속 증거 |
| 9 | 3시간 | 바인드 마운트 | 변경 증거 |
| 10 | 3시간 | 볼륨 | 영속성 증거 |
| 11 | 2시간 | Git·GitHub·VS Code | 연동 증거 |
| 12 | 2시간 | 문제 해결·문서화 | 문제 2건 |
| 13 | 1시간 | clean clone·모의평가 | 최종 점검 |
| 합계 | 40시간 |  |  |

---

# 25. 품질 게이트

## Gate 0. 환경

- [ ] OrbStack 실행
- [ ] `codyssey-training` 존재
- [ ] Ubuntu 24.04 확인
- [ ] Ubuntu에서 `docker version` 정상
- [ ] Docker context `orbstack`
- [ ] 저장소 clone 완료

## Gate 1. 터미널·권한

- [ ] 파일·디렉터리 생성·복사·이동·삭제
- [ ] 파일 권한 변경
- [ ] 디렉터리 권한 변경
- [ ] `755`, `644` 설명 가능

## Gate 2. Docker 운영

- [ ] `docker --version`, `docker info`
- [ ] `hello-world`
- [ ] Ubuntu 컨테이너
- [ ] `images`, `ps`, `ps -a`, `logs`, `stats`

## Gate 3. Dockerfile·포트

- [ ] Dockerfile 직접 작성
- [ ] 이미지 빌드 성공
- [ ] `8080:80` 성공
- [ ] 주소창 포함 브라우저 캡처

## Gate 4. 스토리지

- [ ] 바인드 마운트 전후 비교
- [ ] 볼륨 데이터 작성
- [ ] 컨테이너 삭제 후 데이터 확인

## Gate 5. 제출

- [ ] 트러블슈팅 2건 이상
- [ ] 공식 참고문헌 포함
- [ ] 민감정보 없음
- [ ] 이미지와 링크 정상
- [ ] Default branch `main`
- [ ] 최종 push
- [ ] clean clone 재현 성공

---

# 26. 시험·동료평가 대비

## 26.1 시연 순서

1. 미션 목표
2. macOS·OrbStack·Ubuntu 구조
3. `codyssey-training` 확인
4. Docker 연동 확인
5. 환경 버전
6. 터미널 조작
7. 권한 변경
8. 이미지와 컨테이너
9. Dockerfile 빌드
10. 포트 접속
11. 바인드 마운트
12. 볼륨 영속성
13. Git 이력
14. 트러블슈팅 2건
15. 보안 점검
16. 참고한 공식 문서

## 26.2 예상 질문

1. OrbStack Linux machine과 Docker 컨테이너의 차이는 무엇인가?
2. `ubuntu:noble`은 무엇인가?
3. Ubuntu 안에 별도 Docker Engine을 설치하지 않은 이유는 무엇인가?
4. Docker context `orbstack`의 의미는 무엇인가?
5. 이미지와 컨테이너의 차이는 무엇인가?
6. `-p 8080:80`을 설명하라.
7. `FROM`, `COPY`, `EXPOSE`를 설명하라.
8. 바인드 마운트와 볼륨을 비교하라.
9. 컨테이너 삭제 후 볼륨 데이터가 남는 이유는 무엇인가?
10. `755`, `644`를 설명하라.
11. Git과 GitHub의 차이는 무엇인가?
12. 공식 문서를 사용해 해결한 오류를 설명하라.

---

# 27. FAIL 이후 보완

1. FAIL 근거를 요구사항 ID와 연결한다.
2. 재현 명령과 실제 출력을 기록한다.
3. 원인을 분류한다.
   - 개념 부족
   - 환경 설정 오류
   - Docker 연동 오류
   - 구현 누락
   - 증거 누락
   - 문서 오류
   - 설명 부족
4. 공식 문서에서 관련 항목을 다시 확인한다.
5. 작은 단위로 수정한다.
6. 관련 테스트를 재실행한다.
7. 전체 필수 기능 회귀 테스트를 수행한다.
8. clean clone으로 재현한다.
9. 수정 내용을 별도 commit으로 남긴다.

---

# 28. 보너스 과제

필수 요구사항을 완료한 뒤 수행합니다.

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

Compose의 파일 형식과 CLI는 Docker 공식 레퍼런스를 사용합니다. [R7]

## 28.2 멀티 컨테이너

- 웹 서버와 보조 서비스 2개 이상
- 서비스 이름을 통한 통신 확인
- Compose 네트워크 설명

## 28.3 환경 변수

- Dockerfile 또는 Compose에서 환경 변수 주입
- 설정과 코드 분리 설명

## 28.4 GitHub SSH

OrbStack은 Mac SSH agent를 Linux machine에 전달할 수 있습니다. GitHub SSH 설정과 연결 시험은 GitHub 공식 문서를 사용합니다. [R2][R23]

```bash
echo "$SSH_AUTH_SOCK"
ssh -T git@github.com
```

개인키를 저장소에 복사하거나 commit하지 않습니다.

---

# 29. 최종 제출 체크리스트

## 환경

- [ ] OrbStack 버전
- [ ] `codyssey-training` 확인
- [ ] Ubuntu 24.04 확인
- [ ] OrbStack Docker 연결
- [ ] context `orbstack`

## 터미널·권한

- [ ] 위치·목록·이동·생성·복사·이름변경·삭제
- [ ] 파일 내용 확인·빈 파일 생성
- [ ] 파일 권한 전후
- [ ] 디렉터리 권한 전후

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

## Dockerfile·네트워크·스토리지

- [ ] Dockerfile
- [ ] 커스텀 이미지
- [ ] 포트 매핑
- [ ] 주소창 포함 접속 증거
- [ ] 바인드 마운트 변경 전후
- [ ] 볼륨 생성·연결
- [ ] 컨테이너 삭제 전후 데이터 유지

## Git·문서·평가

- [ ] Git 설정
- [ ] GitHub·VS Code 연동
- [ ] 트러블슈팅 2건 이상
- [ ] 요구사항 추적표
- [ ] 테스트 결과
- [ ] 증거 인덱스
- [ ] 공식 참고문헌
- [ ] 민감정보 마스킹
- [ ] 모든 변경 commit·push
- [ ] Default branch 확인
- [ ] clean clone 재현
- [ ] 구두 설명 준비

---

# 30. 공식 참고문헌

> 확인일: **2026-08-02**  
> 아래 자료는 제품·프로젝트의 공식 문서만 사용했습니다. 명령 옵션은 설치된 버전에 따라 달라질 수 있으므로 `--help`와 해당 공식 문서를 함께 확인합니다.

## 30.1 OrbStack 공식 문서

- **[R1] OrbStack, _What is OrbStack?_**  
  <https://docs.orbstack.dev/>
- **[R2] OrbStack, _Linux machines_** — machine 생성, 자원 제한, 파일 공유, SSH agent 전달  
  <https://docs.orbstack.dev/machines/>
- **[R3] OrbStack, _Commands_** — `orb`, `orb -m`, `mac`, `mac link`  
  <https://docs.orbstack.dev/machines/commands>
- **[R4] OrbStack, _Linux distributions_** — Ubuntu 24.04 LTS `ubuntu:noble`  
  <https://docs.orbstack.dev/machines/distros>
- **[R5] OrbStack, _File sharing_**  
  <https://docs.orbstack.dev/machines/file-sharing>
- **[R6] OrbStack, _Docker containers_**  
  <https://docs.orbstack.dev/docker/>

## 30.2 Docker 공식 문서

- **[R7] Docker, _Reference documentation_** — Docker CLI와 Compose 레퍼런스  
  <https://docs.docker.com/reference/>
- **[R8] Docker, _Dockerfile reference_** — `FROM`, `COPY`, `EXPOSE`, `LABEL`  
  <https://docs.docker.com/reference/dockerfile>
- **[R9] Docker, _Build context_** — 빌드 컨텍스트와 `.dockerignore`  
  <https://docs.docker.com/build/concepts/context/>
- **[R10] Docker, _Port publishing and mapping_**  
  <https://docs.docker.com/engine/network/port-publishing/>
- **[R11] Docker, _Bind mounts_**  
  <https://docs.docker.com/engine/storage/bind-mounts/>
- **[R12] Docker, _Storage_**  
  <https://docs.docker.com/engine/storage/>
- **[R13] Docker, _Volumes_**  
  <https://docs.docker.com/engine/storage/volumes/>

## 30.3 Git·Linux 명령 공식 문서

- **[R14] Git Project, _Git Reference_** — config, status, add, commit, branch, log, pull, push  
  <https://git-scm.com/docs>
- **[R15] GNU Project, _chmod invocation_**  
  <https://www.gnu.org/software/coreutils/manual/html_node/chmod-invocation.html>
- **[R16] GNU Project, _GNU Coreutils Manual_** — 파일·디렉터리 기본 명령  
  <https://www.gnu.org/software/coreutils/manual/coreutils.html>

## 30.4 GitHub·VS Code 공식 문서

- **[R17] GitHub Docs, _Set up Git_**  
  <https://docs.github.com/en/get-started/git-basics/set-up-git>
- **[R18] GitHub Docs, _Cloning a repository_**  
  <https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository>
- **[R19] GitHub Docs, _Remediating a leaked secret in your repository_**  
  <https://docs.github.com/en/code-security/tutorials/remediate-leaked-secrets/remediating-a-leaked-secret>
- **[R20] GitHub Docs, _Removing sensitive data from a repository_**  
  <https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository>
- **[R21] Visual Studio Code, _Source Control in VS Code_**  
  <https://code.visualstudio.com/docs/sourcecontrol/overview/>
- **[R22] Visual Studio Code, _Working with GitHub in VS Code_**  
  <https://code.visualstudio.com/docs/sourcecontrol/github>
- **[R23] GitHub Docs, _Connecting to GitHub with SSH_**  
  <https://docs.github.com/en/authentication/connecting-to-github-with-ssh>

## 30.5 참고문헌 사용 원칙

- 명령이 실패하면 블로그보다 먼저 공식 문서를 확인합니다.
- 문서 작성 시 참고한 자료 번호를 해당 트러블슈팅에 기록합니다.
- 공식 문서의 예시는 본인의 환경에서 검증한 뒤 사용합니다.
- 버전 차이가 있으면 `orb <command> --help`, `docker <command> --help`, `git help <command>` 결과를 우선 확인합니다.

---

## 최종 완료 정의

> `codyssey-training`이라는 OrbStack Ubuntu 24.04 Linux machine에서 작업했다.  
> Ubuntu의 Docker 명령은 Mac의 OrbStack Docker Engine과 연결되어 있다.  
> 터미널·권한·Docker·Dockerfile·포트·마운트·볼륨·GitHub 실습을 직접 수행했다.  
> 모든 결과는 명령과 출력, 스크린샷, 트러블슈팅 문서로 검증할 수 있다.  
> 공식 문서를 근거로 구현과 문제 해결 과정을 설명할 수 있다.  
> 평가자는 저장소 문서만 보고 동일한 절차를 재현할 수 있다.
