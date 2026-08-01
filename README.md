# E1-1. AI/SW 개발 워크스테이션 구축

> 코디세이 입학연수 개발 입문 미션 · 권장 학습시간 40시간

이 저장소는 **터미널, 파일 권한, Docker, Dockerfile, 포트 매핑, 바인드 마운트, Docker 볼륨, Git/GitHub**를 직접 구성하고, 실행 결과와 문제 해결 과정을 재현 가능한 기술 문서로 남기기 위한 미션 저장소입니다.

---

## 0. 문서 사용 규칙

이 문서에서는 항목의 성격을 다음과 같이 구분합니다.

| 표시 | 의미 |
|---|---|
| **[필수]** | 미션 요구사항에 포함된 항목 |
| **[권장]** | 입문자의 안정적인 수행과 평가 준비를 위한 항목 |
| **[보너스]** | 미션의 선택 과제 |
| **[환경 분기]** | 학교 iMac 또는 개인 WSL 환경에 따라 달라지는 항목 |

> 결과 예시는 참고용입니다. 폴더명, 포트 번호, 로그 문구를 그대로 복사하는 것이 목표가 아니라, 본인이 수행한 과정과 결과를 설명할 수 있어야 합니다.

---

# 1. 미션 목표

## 1.1 최종 목표

다음 내용을 충족하는 개발 워크스테이션을 구축합니다.

- 터미널에서 파일과 디렉터리를 조작한다.
- 파일과 디렉터리의 권한을 확인하고 변경한다.
- Docker 설치 또는 실행 환경을 점검한다.
- Docker 이미지와 컨테이너를 실행·중지·조회한다.
- Dockerfile로 커스텀 이미지를 빌드한다.
- 포트 매핑을 통해 웹 서버에 접속한다.
- 바인드 마운트로 호스트 파일 변경이 컨테이너에 반영되는지 확인한다.
- Docker 볼륨으로 컨테이너 삭제 후에도 데이터가 유지되는지 확인한다.
- Git 설정과 GitHub/VS Code 연동 상태를 증명한다.
- 문제 해결 과정을 최소 2건 이상 기록한다.
- README만 보고 평가자가 동일한 절차를 재현할 수 있도록 작성한다.

## 1.2 학습 후 설명할 수 있어야 하는 내용

- 절대 경로와 상대 경로의 차이
- 파일 권한 `r/w/x`의 의미
- `755`, `644` 권한 표기의 해석 방법
- Docker 이미지와 컨테이너의 차이
- Dockerfile을 이용해 커스텀 이미지를 만드는 과정
- 포트 매핑이 필요한 이유
- 바인드 마운트와 Docker 볼륨의 차이
- 데이터 영속성의 의미
- Git과 GitHub의 역할 차이
- 실행 오류를 문제 → 가설 → 확인 → 해결 순서로 분석하는 방법

---

# 2. 권장 저장소 구조

```text
codyssey-training-e1-1/
├── README.md
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
    └── verify.sh
```

> `scripts/verify.sh`는 선택 사항입니다. 필수 요구사항은 아니며, 반복 검증을 자동화하고 싶을 때 추가합니다.

---

# 3. 수행 전 준비

## 3.1 사전 점검표

- [ ] GitHub 계정에 로그인할 수 있다.
- [ ] 이 저장소에 push 권한이 있다.
- [ ] 터미널을 실행할 수 있다.
- [ ] VS Code를 실행할 수 있다.
- [ ] Git 버전을 확인할 수 있다.
- [ ] Docker 또는 OrbStack이 실행 가능한 상태다.
- [ ] 스크린샷 저장 위치를 정했다.
- [ ] 토큰·비밀번호·개인키를 캡처하지 않는 규칙을 확인했다.
- [ ] 이 미션에서 사용할 주 실행환경을 하나로 정했다.

## 3.2 주 실행환경 선택

### [환경 분기 A] 학교 iMac

학교 환경에서는 관리자 권한이 제한될 수 있으므로 **OrbStack**을 사용합니다.

- OrbStack 애플리케이션을 실행한다.
- 터미널에서 `docker` 명령이 동작하는지 확인한다.
- `sudo`가 필요한 설치 작업을 임의로 시도하지 않는다.
- 권한 제한으로 불가능한 작업은 문제와 대안을 README에 기록한다.

### [환경 분기 B] Windows 11 Pro + WSL + Ubuntu 24.04

- WSL Ubuntu 터미널에서 수행한다.
- VS Code Remote 연결 여부를 확인한다.
- Windows 경로와 Linux 경로를 혼합하지 않는다.
- Docker 명령이 어느 환경에서 실행되는지 README에 명확히 기록한다.

> 같은 미션 안에서 macOS 터미널, WSL 터미널, Windows PowerShell의 결과를 무분별하게 섞지 않습니다. 주 실행환경을 고정하고 보조 환경 결과는 별도 구역에 기록합니다.

---

# 4. 환경 기준선 기록

## 4.1 [필수] 실행 환경 정보

아래 명령을 실행하고 결과를 `docs/environment.md` 또는 이 README에 기록합니다.

```bash
uname -a

# Linux 계열
cat /etc/os-release

# macOS
sw_vers

# 현재 셸
printf '%s\n' "$SHELL"

# Git
Git --version 2>/dev/null || git --version

# Docker
docker --version
docker info
```

## 4.2 기록 템플릿

```text
OS:
OS 버전:
Shell:
Terminal:
Docker 실행 방식:
Docker 버전:
Git 버전:
VS Code 버전:
작업 경로:
GitHub 저장소:
확인 날짜:
```

## 4.3 환경 기준선 완료 조건

- [ ] OS와 버전이 기록되어 있다.
- [ ] 셸과 터미널이 기록되어 있다.
- [ ] Docker 버전과 실행 가능 여부가 기록되어 있다.
- [ ] Git 버전이 기록되어 있다.
- [ ] 개인 PC에 종속된 경로나 설정이 있으면 주의사항이 기록되어 있다.

---

# 5. 터미널 기본 조작

## 5.1 [필수] 수행 명령

```bash
pwd
ls
ls -la
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

## 5.2 증거 기록 기준

다음 내용을 함께 남깁니다.

- 입력한 명령
- 명령 실행 결과
- 작업 전 상태
- 작업 후 상태
- 실패한 명령이 있다면 오류 메시지

## 5.3 설명 준비

다음 질문에 답할 수 있어야 합니다.

1. `pwd`와 `ls`의 차이는 무엇인가?
2. 절대 경로와 상대 경로는 무엇이 다른가?
3. `cp`와 `mv`는 무엇이 다른가?
4. `rm` 명령은 왜 주의해야 하는가?
5. `.`과 `..`은 각각 무엇을 의미하는가?

---

# 6. 파일과 디렉터리 권한

## 6.1 권한 기초

```text
r = read    = 4
w = write   = 2
x = execute = 1
```

| 권한 | 소유자 | 그룹 | 기타 사용자 |
|---|---|---|---|
| `755` | `rwx` | `r-x` | `r-x` |
| `644` | `rw-` | `r--` | `r--` |

## 6.2 [필수] 파일 권한 실습

```bash
touch permission-file.txt
ls -l permission-file.txt
chmod 644 permission-file.txt
ls -l permission-file.txt
chmod 600 permission-file.txt
ls -l permission-file.txt
```

## 6.3 [필수] 디렉터리 권한 실습

```bash
mkdir permission-dir
ls -ld permission-dir
chmod 755 permission-dir
ls -ld permission-dir
chmod 700 permission-dir
ls -ld permission-dir
```

## 6.4 기록할 내용

- 변경 전 권한
- 실행한 `chmod` 명령
- 변경 후 권한
- 해당 권한을 선택한 이유
- 파일과 디렉터리에서 실행 권한의 의미 차이

## 6.5 완료 조건

- [ ] 파일 1개 이상 권한 변경
- [ ] 디렉터리 1개 이상 권한 변경
- [ ] 변경 전·후 비교 자료
- [ ] `755`와 `644`를 말로 설명 가능

---

# 7. Docker 설치·실행 환경 점검

## 7.1 [필수] 버전과 데몬 점검

```bash
docker --version
docker info
```

## 7.2 점검 결과 분류

| 결과 | 의미 | 다음 행동 |
|---|---|---|
| 버전과 정보 모두 출력 | Docker 사용 가능 | 기본 실습 진행 |
| 버전은 출력되나 `docker info` 실패 | 클라이언트는 있으나 엔진 연결 문제 가능 | OrbStack 또는 Docker 실행 상태 확인 |
| 명령을 찾을 수 없음 | Docker CLI 경로 또는 설치 상태 문제 | 환경 담당 방식 확인 후 기록 |
| 권한 오류 | 실행 사용자 또는 소켓 접근 문제 가능 | 임의 우회 전에 원인 확인 |

> 오류가 발생하면 바로 삭제하거나 우회하지 말고, 원문 오류 메시지를 먼저 기록합니다.

---

# 8. Docker 기본 운영

## 8.1 [필수] 이미지 확인

```bash
docker images
```

## 8.2 [필수] hello-world 실행

```bash
docker run --name e1-1-hello hello-world

docker ps
docker ps -a
docker logs e1-1-hello
```

## 8.3 [필수] Ubuntu 컨테이너 실행

```bash
docker run -it --name e1-1-ubuntu ubuntu bash
```

컨테이너 내부에서 실행합니다.

```bash
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

호스트에서 상태를 확인합니다.

```bash
docker ps
docker ps -a
docker start e1-1-ubuntu
docker exec e1-1-ubuntu bash -lc 'echo "exec test" && ls -la /'
docker logs e1-1-ubuntu
```

## 8.4 [필수] 운영 명령

```bash
docker images
docker ps
docker ps -a
docker logs <container-name>
docker stats --no-stream
```

## 8.5 설명 준비

- 이미지와 컨테이너는 무엇이 다른가?
- 실행 중 컨테이너와 종료된 컨테이너는 어떻게 확인하는가?
- `docker exec`와 컨테이너 최초 실행은 무엇이 다른가?
- `docker logs`와 `docker stats`는 각각 무엇을 확인하는가?

---

# 9. Dockerfile 기반 커스텀 웹 서버

## 9.1 [필수] 웹 콘텐츠 작성

`site/index.html`

```html
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Codyssey E1-1</title>
</head>
<body>
  <h1>AI/SW 개발 워크스테이션 구축</h1>
  <p>Dockerfile로 빌드한 커스텀 웹 서버입니다.</p>
</body>
</html>
```

## 9.2 [필수] Dockerfile 작성

```dockerfile
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-e1-1-web"
LABEL org.opencontainers.image.description="Codyssey E1-1 custom web server"

COPY site/ /usr/share/nginx/html/

EXPOSE 80
```

## 9.3 권장 `.dockerignore`

```text
.git
.gitignore
docs
README.md
*.log
```

## 9.4 [필수] 이미지 빌드

```bash
docker build -t codyssey-e1-1-web:1.0 .
docker images
```

## 9.5 [필수] 컨테이너 실행

```bash
docker run -d \
  --name codyssey-e1-1-web \
  -p 8080:80 \
  codyssey-e1-1-web:1.0
```

## 9.6 실행 확인

```bash
docker ps
docker logs codyssey-e1-1-web
curl http://localhost:8080
```

브라우저에서도 다음 주소를 확인합니다.

```text
http://localhost:8080
```

## 9.7 기술 문서에 기록할 내용

- 선택한 베이스 이미지
- 해당 베이스 이미지를 선택한 이유
- 본인이 추가하거나 변경한 내용
- Dockerfile 각 명령의 역할
- 빌드 명령과 결과
- 실행 명령과 결과
- 웹 접속 결과

---

# 10. 포트 매핑 검증

## 10.1 포트 표기 해석

```text
-p <host-port>:<container-port>
```

예시:

```text
-p 8080:80
```

- `8080`: 호스트에서 접속할 포트
- `80`: 컨테이너 내부의 웹 서버 포트

## 10.2 [필수] 접속 증거

다음 중 하나 이상을 남깁니다.

- 브라우저 주소창에 포트가 포함된 화면
- `curl` 명령과 HTTP 응답
- 컨테이너 목록의 포트 매핑 정보

```bash
docker ps
curl http://localhost:8080
```

## 10.3 권장 추가 검증

다른 호스트 포트로 두 번째 컨테이너를 실행합니다.

```bash
docker run -d \
  --name codyssey-e1-1-web-8081 \
  -p 8081:80 \
  codyssey-e1-1-web:1.0

curl http://localhost:8081
```

> 두 번째 포트 실행은 이해를 돕는 권장 실습입니다. 미션의 핵심은 포트 매핑을 직접 설정하고 접속 결과를 증명하는 것입니다.

---

# 11. 바인드 마운트 검증

## 11.1 목적

호스트의 파일을 컨테이너 경로에 직접 연결하고, 호스트 파일 변경이 컨테이너에 반영되는지 확인합니다.

## 11.2 [필수] 실행

먼저 기존 포트와 충돌하지 않도록 별도 포트를 사용합니다.

```bash
docker run -d \
  --name codyssey-e1-1-bind \
  -p 8082:80 \
  -v "$(pwd)/site:/usr/share/nginx/html:ro" \
  nginx:alpine
```

## 11.3 변경 전 확인

```bash
curl http://localhost:8082
```

## 11.4 호스트 파일 변경

`site/index.html`의 문구를 수정합니다.

```html
<p>바인드 마운트 변경 반영 확인 완료</p>
```

## 11.5 변경 후 확인

```bash
curl http://localhost:8082
```

## 11.6 기록할 증거

- 컨테이너 실행 명령
- 변경 전 응답
- 호스트 파일 변경 내용
- 변경 후 응답
- 바인드 마운트의 목적 설명

---

# 12. Docker 볼륨 영속성 검증

## 12.1 목적

컨테이너를 삭제한 뒤에도 Docker 볼륨에 저장한 데이터가 유지되는지 확인합니다.

## 12.2 [필수] 볼륨 생성

```bash
docker volume create codyssey-e1-1-data
docker volume ls
```

## 12.3 첫 번째 컨테이너에 연결

```bash
docker run -d \
  --name e1-1-volume-test-1 \
  -v codyssey-e1-1-data:/data \
  ubuntu sleep infinity
```

## 12.4 데이터 생성과 확인

```bash
docker exec e1-1-volume-test-1 \
  bash -lc 'echo "persistent data" > /data/result.txt && cat /data/result.txt'
```

## 12.5 첫 번째 컨테이너 삭제

```bash
docker rm -f e1-1-volume-test-1
```

## 12.6 새 컨테이너에서 데이터 확인

```bash
docker run -d \
  --name e1-1-volume-test-2 \
  -v codyssey-e1-1-data:/data \
  ubuntu sleep infinity


docker exec e1-1-volume-test-2 \
  bash -lc 'cat /data/result.txt'
```

예상 확인 내용:

```text
persistent data
```

## 12.7 기록할 증거

- 볼륨 생성 명령
- 첫 번째 컨테이너의 데이터 작성 결과
- 첫 번째 컨테이너 삭제 결과
- 두 번째 컨테이너의 데이터 확인 결과
- 컨테이너와 볼륨의 수명 차이 설명

---

# 13. Git 설정과 GitHub/VS Code 연동

## 13.1 [필수] Git 설정 확인

```bash
git config --global user.name
git config --global user.email
git config --global init.defaultBranch
git config --list
```

> 공개 문서와 스크린샷에는 불필요한 개인정보를 노출하지 않습니다.

## 13.2 저장소 상태 확인

```bash
git status
git branch
git remote -v
git log --oneline --graph --all
```

## 13.3 권장 커밋 계획

| 순서 | 작업 | 커밋 예시 |
|---:|---|---|
| 1 | README 기본 구조 | `Docs: initialize E1-1 mission guide` |
| 2 | 터미널·권한 기록 | `Docs: add terminal and permission evidence` |
| 3 | 웹 콘텐츠 | `Feat: add static web content` |
| 4 | Dockerfile | `Feat: add custom nginx image` |
| 5 | 포트 매핑 결과 | `Docs: document port mapping verification` |
| 6 | 바인드 마운트 결과 | `Docs: add bind mount verification` |
| 7 | 볼륨 영속성 결과 | `Docs: add volume persistence evidence` |
| 8 | 트러블슈팅 | `Docs: record troubleshooting cases` |
| 9 | 최종 검증 | `Docs: complete reproduction checklist` |

## 13.4 VS Code/GitHub 연동 증거

다음을 확인할 수 있는 자료를 남깁니다.

- VS Code에서 저장소 폴더가 열려 있음
- Source Control에서 저장소가 인식됨
- GitHub 저장소와 원격 연결됨
- push된 파일이 GitHub에서 확인됨

> 인증 토큰, 개인키, 비밀번호, 인증 코드는 캡처하지 않습니다.

---

# 14. 보안과 개인정보 보호

## 14.1 저장소에 올리면 안 되는 정보

- GitHub 액세스 토큰
- 비밀번호
- SSH 개인키
- 인증 코드
- 클라우드 자격증명
- `.env`의 비밀값
- 사내·학교 내부 민감정보

## 14.2 권장 `.gitignore`

```gitignore
.env
.env.*
*.pem
*.key
*.log
.DS_Store
.vscode/settings.json
```

## 14.3 커밋 전 점검

```bash
git status
git diff --cached
```

추가 확인:

- [ ] 스크린샷에 토큰이 보이지 않는다.
- [ ] 터미널 프롬프트에 민감정보가 없다.
- [ ] `git remote -v` 결과에 자격증명이 포함되지 않는다.
- [ ] 개인키 파일이 추적되지 않는다.
- [ ] 의심되는 정보가 있으면 push 전에 제거한다.

## 14.4 노출이 의심될 때

1. 문서와 파일에서 즉시 제거한다.
2. Git 히스토리에 남았는지 확인한다.
3. 노출된 토큰·비밀번호·키를 폐기 또는 재발급한다.
4. 조치 과정을 트러블슈팅 문서에 기록하되 비밀값 자체는 기록하지 않는다.

---

# 15. 트러블슈팅 기록

## 15.1 [필수] 최소 2건

다음 구조로 최소 2건을 기록합니다.

```markdown
## 문제 ID: TS-01

### 발생 환경
- OS:
- Shell:
- Docker 실행 방식:

### 문제
어떤 작업에서 어떤 문제가 발생했는가?

### 실행 명령
```bash
실행한 명령
```

### 오류 메시지
```text
오류 원문
```

### 원인 가설
1. 가설 1
2. 가설 2

### 확인 과정
- 어떤 명령과 자료로 가설을 확인했는가?

### 실제 원인
- 확인된 원인은 무엇인가?

### 해결 또는 대안
- 어떤 조치를 수행했는가?

### 해결 검증
```bash
검증 명령
```

### 재발 방지
- 다음에는 무엇을 먼저 확인할 것인가?
```

## 15.2 권장 문제 후보

- Docker 엔진이 실행되지 않음
- 포트가 이미 사용 중임
- 컨테이너 이름이 중복됨
- Dockerfile 경로가 잘못됨
- `COPY` 대상 파일이 없음
- 바인드 마운트 경로가 잘못됨
- 파일 권한 때문에 읽기 실패
- 볼륨 이름을 다르게 연결함
- Git 원격 저장소가 잘못 설정됨
- README의 실행 명령과 실제 파일 구조가 다름

---

# 16. 요구사항 추적표

아래 표는 진행하면서 갱신합니다.

| ID | 구분 | 요구사항 | 구현·기록 위치 | 검증 방법 | 증거 | 상태 |
|---|---|---|---|---|---|---|
| E1-1-R01 | 필수 | 프로젝트 개요 | `README.md` | 문서 검토 | README | ⬜ |
| E1-1-R02 | 필수 | 실행 환경 기록 | `docs/environment.md` | 버전 명령 | 환경 로그 | ⬜ |
| E1-1-R03 | 필수 | 터미널 기본 조작 | `docs/terminal-and-permissions.md` | CLI 실행 | 명령+출력 | ⬜ |
| E1-1-R04 | 필수 | 파일 권한 변경 | `docs/terminal-and-permissions.md` | `ls -l` 전후 비교 | 캡처/로그 | ⬜ |
| E1-1-R05 | 필수 | Docker 점검 | `docs/docker-operations.md` | `docker --version`, `docker info` | 로그 | ⬜ |
| E1-1-R06 | 필수 | Docker 기본 운영 | `docs/docker-operations.md` | images/ps/logs/stats | 로그 | ⬜ |
| E1-1-R07 | 필수 | hello-world | `docs/docker-operations.md` | 컨테이너 실행 | 로그 | ⬜ |
| E1-1-R08 | 필수 | Ubuntu 컨테이너 | `docs/docker-operations.md` | 내부 명령 실행 | 로그 | ⬜ |
| E1-1-R09 | 필수 | Dockerfile 커스텀 이미지 | `Dockerfile` | build/run | 로그 | ⬜ |
| E1-1-R10 | 필수 | 포트 매핑 | `docs/docker-operations.md` | 브라우저/curl | 접속 증거 | ⬜ |
| E1-1-R11 | 필수 | 바인드 마운트 | `docs/bind-mount.md` | 파일 변경 전후 | 응답 비교 | ⬜ |
| E1-1-R12 | 필수 | 볼륨 영속성 | `docs/volume-persistence.md` | 컨테이너 삭제 전후 | 데이터 비교 | ⬜ |
| E1-1-R13 | 필수 | Git 설정·GitHub 연동 | README 또는 docs | Git 명령·화면 | 로그/캡처 | ⬜ |
| E1-1-R14 | 필수 | 트러블슈팅 2건 | `docs/troubleshooting.md` | 문서 검토 | TS-01, TS-02 | ⬜ |
| E1-1-R15 | 필수 | 민감정보 보호 | 전체 저장소 | 수동 점검 | 체크 결과 | ⬜ |
| E1-1-R16 | 필수 | README 재현성 | 전체 저장소 | clean clone | 재현 로그 | ⬜ |

상태 표기:

- ⬜ 미수행
- 🟨 진행 중
- ✅ 완료
- ❌ 재작업 필요

---

# 17. 테스트 매트릭스

| 테스트 ID | 대상 | 입력·조건 | 기대 결과 | 실제 결과 | 상태 |
|---|---|---|---|---|---|
| T-01 | Docker 점검 | 엔진 실행 상태 | `docker info` 성공 |  | ⬜ |
| T-02 | hello-world | 최초 실행 | 성공 메시지 출력 |  | ⬜ |
| T-03 | Ubuntu 컨테이너 | 내부 `echo` | 문자열 출력 |  | ⬜ |
| T-04 | Dockerfile | 이미지 빌드 | 빌드 성공 |  | ⬜ |
| T-05 | 포트 매핑 | `localhost:8080` | 웹 화면 출력 |  | ⬜ |
| T-06 | 바인드 마운트 | 호스트 파일 수정 | 새 문구 즉시 반영 |  | ⬜ |
| T-07 | 볼륨 | 컨테이너 삭제 후 재연결 | 기존 파일 유지 |  | ⬜ |
| T-08 | 오류 처리 | 사용 중 포트 실행 | 오류 메시지 확인·원인 기록 |  | ⬜ |
| T-09 | Git | push 후 GitHub 확인 | 파일 반영 |  | ⬜ |
| T-10 | 재현성 | 새 폴더에 clone | README만으로 재현 |  | ⬜ |
| T-11 | 보안 | 저장소·스크린샷 검사 | 민감정보 없음 |  | ⬜ |

---

# 18. 증거 인덱스

| 증거 ID | 내용 | 파일·링크 | 확인 상태 |
|---|---|---|---|
| EV-01 | OS·Shell·Git·Docker 버전 |  | ⬜ |
| EV-02 | 터미널 기본 조작 |  | ⬜ |
| EV-03 | 파일 권한 변경 전후 |  | ⬜ |
| EV-04 | `docker info` |  | ⬜ |
| EV-05 | hello-world 실행 |  | ⬜ |
| EV-06 | Ubuntu 컨테이너 내부 명령 |  | ⬜ |
| EV-07 | 이미지 빌드 |  | ⬜ |
| EV-08 | 포트 접속 |  | ⬜ |
| EV-09 | 바인드 마운트 변경 전후 |  | ⬜ |
| EV-10 | 볼륨 삭제 전후 데이터 |  | ⬜ |
| EV-11 | GitHub/VS Code 연동 |  | ⬜ |
| EV-12 | 트러블슈팅 2건 |  | ⬜ |
| EV-13 | clean clone 재현 |  | ⬜ |

> README에서 모든 증거 파일로 이동할 수 있도록 상대 링크를 연결합니다.

---

# 19. 품질 게이트

## Gate 0. 환경 준비

- [ ] 터미널 실행 가능
- [ ] Git 실행 가능
- [ ] GitHub 접근 가능
- [ ] Docker 또는 OrbStack 실행 가능
- [ ] 작업 경로 확정

## Gate 1. 기능 수행

- [ ] CLI 기본 조작 완료
- [ ] 권한 실습 완료
- [ ] Docker 기본 운영 완료
- [ ] Dockerfile 빌드 완료
- [ ] 포트 매핑 완료
- [ ] 바인드 마운트 완료
- [ ] 볼륨 영속성 완료

## Gate 2. 문서와 증거

- [ ] 명령과 출력이 함께 기록됨
- [ ] 스크린샷 경로가 정상임
- [ ] 주소창 또는 curl 응답이 있음
- [ ] 트러블슈팅 2건 이상 있음
- [ ] 민감정보가 없음

## Gate 3. Git

- [ ] 모든 변경이 commit됨
- [ ] 원격 저장소에 push됨
- [ ] Default branch 내용이 최신임
- [ ] `git status`가 깨끗함
- [ ] 커밋 메시지가 작업 내용을 설명함

## Gate 4. 설명 가능성

- [ ] Docker 이미지와 컨테이너를 설명할 수 있음
- [ ] Dockerfile 각 명령을 설명할 수 있음
- [ ] 포트 매핑을 설명할 수 있음
- [ ] 바인드 마운트와 볼륨 차이를 설명할 수 있음
- [ ] 권한 755와 644를 설명할 수 있음
- [ ] 트러블슈팅 2건을 순서대로 설명할 수 있음

## Gate 5. 재현성과 평가 준비

- [ ] 새 디렉터리에서 저장소 clone
- [ ] README만 보고 빌드·실행
- [ ] 모든 링크 확인
- [ ] 평가 대상 Default branch 확인
- [ ] 모의 설명 완료

---

# 20. 권장 40시간 학습 운영

> 아래 시간표는 공식 배점표가 아니라 입문자의 수행을 돕기 위한 권장 계획입니다.

| 단계 | 학습 내용 | 권장 시간 |
|---|---|---:|
| 1 | 미션 분석·환경 진단 | 3시간 |
| 2 | 터미널·경로·권한 | 6시간 |
| 3 | Docker 개념·기본 운영 | 7시간 |
| 4 | Dockerfile·커스텀 이미지 | 6시간 |
| 5 | 포트 매핑·접속 검증 | 3시간 |
| 6 | 바인드 마운트 | 3시간 |
| 7 | 볼륨 영속성 | 3시간 |
| 8 | Git/GitHub·VS Code 연동 | 3시간 |
| 9 | 트러블슈팅·README·증거 | 4시간 |
| 10 | clean clone·모의평가 | 2시간 |
| **합계** |  | **40시간** |

---

# 21. 모의 점검과 시험 대비

> 제공된 미션 문서에는 공식 시험 문항·배점·합격점이 제시되어 있지 않습니다. 아래 내용은 주차별 학습점검과 동료평가 대비용입니다.

## 21.1 개념 점검

1. 터미널과 셸은 무엇이 다른가?
2. 절대 경로와 상대 경로의 차이는 무엇인가?
3. `755`와 `644`는 어떻게 해석하는가?
4. Docker 이미지와 컨테이너의 차이는 무엇인가?
5. Dockerfile은 왜 필요한가?
6. `-p 8080:80`은 무엇을 의미하는가?
7. 바인드 마운트와 볼륨은 무엇이 다른가?
8. 컨테이너 삭제 후 볼륨 데이터가 유지되는 이유는 무엇인가?
9. Git과 GitHub는 무엇이 다른가?
10. 트러블슈팅 한 건을 문제 → 가설 → 확인 → 해결 순서로 설명하라.

## 21.2 실기 점검

제한시간 안에 다음을 수행합니다.

1. 현재 위치와 파일 목록 확인
2. 파일·디렉터리 생성 및 권한 변경
3. Docker 버전과 엔진 확인
4. hello-world 실행
5. Dockerfile 이미지 빌드
6. 포트 매핑 컨테이너 실행
7. `curl` 또는 브라우저 접속
8. 바인드 마운트 변경 반영
9. 볼륨 영속성 확인
10. Git status·branch·log 확인

## 21.3 오류 진단 점검

- Docker 엔진이 실행되지 않을 때 무엇부터 확인할 것인가?
- 포트 충돌이 발생하면 어떤 명령과 정보로 확인할 것인가?
- Dockerfile의 `COPY`가 실패하면 무엇을 확인할 것인가?
- 바인드 마운트 변경이 반영되지 않으면 어떤 경로를 확인할 것인가?
- 볼륨 데이터가 사라졌다면 볼륨 이름과 마운트 경로를 어떻게 확인할 것인가?

---

# 22. 동료평가 준비

## 22.1 평가 전 피평가자 점검

```bash
git status
git branch
git remote -v
git log --oneline --graph --all
```

- [ ] Default branch가 평가 대상 내용과 일치한다.
- [ ] 최신 변경이 push되어 있다.
- [ ] 미커밋 변경사항이 없다.
- [ ] README의 실행 방법이 실제 구조와 일치한다.
- [ ] 필수 기능을 처음부터 다시 시연할 수 있다.
- [ ] 코드와 문서를 본인의 말로 설명할 수 있다.

## 22.2 권장 발표 순서

1. 미션 목표
2. 실행환경
3. 저장소 구조
4. 터미널·권한 실습
5. Docker 기본 운영
6. Dockerfile과 커스텀 이미지
7. 포트 매핑
8. 바인드 마운트
9. 볼륨 영속성
10. GitHub 연동
11. 트러블슈팅 2건
12. 한계와 개선점

## 22.3 답변 구조

각 기능은 다음 순서로 설명합니다.

```text
무엇을 구현했는가
→ 왜 그렇게 구현했는가
→ 어떻게 검증했는가
→ 문제가 있었을 때 어떻게 해결했는가
→ 남은 한계는 무엇인가
```

---

# 23. FAIL 또는 재작업 발생 시

## 23.1 근거 기록

- 실패한 요구사항
- 재현 명령
- 실제 출력
- 기대 결과
- 관련 파일 또는 문서

## 23.2 원인 분류

- 개념 부족
- 환경 문제
- 명령 오류
- Docker 설정 오류
- 권한 오류
- Git·제출 오류
- 문서·증거 누락
- 설명 부족

## 23.3 수정과 재검증

1. 작은 단위로 수정한다.
2. 수정 내용을 commit한다.
3. 실패한 테스트를 다시 실행한다.
4. 다른 필수 기능도 회귀 테스트한다.
5. 새 폴더에서 다시 clone한다.
6. README 절차를 다시 검증한다.
7. 무엇을 놓쳤는지 회고한다.

---

# 24. 보너스 과제

## 24.1 [보너스] Docker Compose 기초

- `compose.yml` 또는 `docker-compose.yml` 작성
- 단일 서비스를 Compose로 실행
- 명령형 실행을 문서화된 설정으로 전환하는 이유 설명

## 24.2 [보너스] 멀티 컨테이너

- 웹 서버와 보조 서비스 2개 이상 실행
- 컨테이너 간 네트워크 통신 확인
- 서비스 이름 기반 통신 개념 정리

## 24.3 [보너스] Compose 운영 명령

```bash
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

## 24.4 [보너스] 환경 변수

- Dockerfile 또는 Compose에 환경 변수 주입
- 코드와 설정을 분리하는 이유 정리

## 24.5 [보너스] GitHub SSH 인증

- HTTPS와 SSH 인증 방식 차이 정리
- SSH 키 등록과 push 확인
- 개인키 비공개 원칙 확인

---

# 25. 최종 제출 체크리스트

## 저장소

- [ ] GitHub Repository 링크로 제출 가능
- [ ] Default branch에 최신 결과 반영
- [ ] README에서 모든 산출물 접근 가능

## 기술 문서

- [ ] 프로젝트 개요
- [ ] 실행 환경
- [ ] 수행 항목 체크리스트
- [ ] 명령과 출력 로그
- [ ] 검증 방법과 결과 링크
- [ ] 트러블슈팅 2건 이상
- [ ] 개인 환경 종속성 또는 대안

## 터미널·권한

- [ ] 위치·목록·이동·생성·복사·이름변경·삭제
- [ ] 파일 내용 확인·빈 파일 생성
- [ ] 파일 권한 변경
- [ ] 디렉터리 권한 변경
- [ ] 변경 전·후 비교

## Docker

- [ ] `docker --version`
- [ ] `docker info`
- [ ] `docker images`
- [ ] `docker ps`
- [ ] `docker ps -a`
- [ ] `docker logs`
- [ ] `docker stats`
- [ ] hello-world
- [ ] Ubuntu 컨테이너
- [ ] Dockerfile 빌드
- [ ] 커스텀 이미지 실행
- [ ] 포트 매핑 접속
- [ ] 바인드 마운트 변경 반영
- [ ] 볼륨 영속성

## Git/GitHub

- [ ] Git 사용자 정보와 기본 브랜치 설정 확인
- [ ] GitHub 원격 저장소 연결
- [ ] VS Code 연동 증거
- [ ] push 완료

## 보안

- [ ] 토큰 없음
- [ ] 비밀번호 없음
- [ ] 개인키 없음
- [ ] 인증 코드 없음
- [ ] 민감정보 마스킹 완료

## 재현성

- [ ] 새 폴더에 clone
- [ ] README만 보고 빌드
- [ ] README만 보고 실행
- [ ] 브라우저 또는 curl 응답 확인
- [ ] 모든 링크 정상

---

# 26. 최종 완료 기준

이 미션은 단순히 Docker 컨테이너가 한 번 실행되었다고 끝나는 것이 아닙니다.

다음 조건을 모두 만족해야 완료로 판단합니다.

1. **실행 가능:** 필수 명령과 기능이 동작한다.
2. **검증 가능:** 명령과 출력, 접속 화면, 데이터 유지 증거가 있다.
3. **재현 가능:** 다른 사람이 README만 보고 동일 결과를 확인할 수 있다.
4. **설명 가능:** 각 설정과 선택 이유를 본인의 말로 설명할 수 있다.
5. **복구 가능:** 오류 발생 시 원인을 기록하고 해결 또는 대안을 제시할 수 있다.
6. **안전:** 저장소와 스크린샷에 민감정보가 없다.

> **환경을 설치하는 것보다 중요한 것은, 그 환경이 왜 동작하는지 설명하고 다른 사람이 재현할 수 있도록 증명하는 것입니다.**
