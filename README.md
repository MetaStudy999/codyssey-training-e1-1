# E1-1. AI/SW 개발 워크스테이션 구축

> 코디세이 입학연수 · 개발 입문 · 학습시간 40시간

이 저장소는 **터미널, 파일 권한, Docker, Dockerfile, 포트 매핑, 바인드 마운트, Docker 볼륨, Git/GitHub**를 직접 다루고, 모든 수행 결과를 재현 가능한 기술 문서로 남기기 위한 미션 저장소입니다.

---

## 문서 표시 기준

| 표시 | 의미 |
|---|---|
| **[필수]** | 미션 문서에 명시된 요구사항 |
| **[권장]** | 입문자의 수행·시험·평가 준비를 위한 보완 항목 |
| **[보너스]** | 미션 문서의 선택 과제 |
| **[환경 분기]** | 학교 iMac과 개인 WSL 환경에 따라 달라지는 항목 |

> 결과 예시는 참고 자료입니다. 예시의 폴더명·포트·출력 문구를 그대로 복사하는 것이 아니라, 본인이 수행한 과정과 선택 이유를 설명할 수 있어야 합니다.

---

# 1. 미션 완료 기준

## 1.1 [필수] 최종 산출물

- GitHub Repository
- 프로젝트 개요와 실행 환경이 포함된 기술 문서
- 터미널 기본 조작 로그
- 파일과 디렉터리 권한 변경 전·후 기록
- Docker 설치·실행 환경 점검 결과
- Docker 이미지·컨테이너 운영 로그
- `hello-world` 실행 결과
- Ubuntu 컨테이너 실행 및 내부 명령 결과
- Dockerfile 기반 커스텀 이미지
- 포트 매핑 및 웹 접속 증거
- 바인드 마운트 변경 반영 증거
- Docker 볼륨 영속성 증거
- Git 설정 및 GitHub/VS Code 연동 증거
- 트러블슈팅 2건 이상
- 민감정보가 제거된 로그와 스크린샷
- README만 보고 다시 수행할 수 있는 재현 절차

## 1.2 학습 후 설명할 수 있어야 하는 내용

- 절대 경로와 상대 경로의 차이
- 파일 권한 `r/w/x`와 `755`, `644`의 의미
- Docker 이미지와 컨테이너의 차이
- Dockerfile의 역할과 커스텀 이미지 빌드 과정
- 포트 매핑이 필요한 이유
- 바인드 마운트와 Docker 볼륨의 차이
- 컨테이너 삭제 후에도 볼륨 데이터가 유지되는 이유
- Git과 GitHub의 역할 차이
- 문제를 가설·확인·해결 순서로 분석하는 방법

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
└── docs/
    ├── environment.md
    ├── terminal-and-permissions.md
    ├── docker-operations.md
    ├── bind-mount.md
    ├── volume-persistence.md
    ├── troubleshooting.md
    ├── test-results.md
    └── screenshots/
        ├── environment/
        ├── terminal/
        ├── permissions/
        ├── docker/
        ├── port/
        ├── mount/
        ├── volume/
        └── github/
```

README에서 `docs/`의 모든 문서와 증거 파일로 이동할 수 있도록 상대 링크를 연결합니다.

---

# 3. 수행 전 환경 준비

## 3.1 사전 점검

- [ ] GitHub 계정 로그인
- [ ] 저장소 push 권한 확인
- [ ] 터미널 실행
- [ ] VS Code 실행
- [ ] Git 실행 가능
- [ ] Docker 또는 OrbStack 실행 가능
- [ ] 스크린샷 저장 위치 결정
- [ ] 토큰·비밀번호·개인키 비공개 원칙 확인
- [ ] 미션의 주 실행환경 결정

## 3.2 [환경 분기 A] 학교 iMac

학교 환경에서는 시스템 보안 정책으로 `sudo` 권한이 제한될 수 있으므로 **OrbStack**을 사용합니다.

1. OrbStack 애플리케이션을 실행합니다.
2. 터미널에서 `docker` 명령이 동작하는지 확인합니다.
3. 관리자 권한이 필요한 설치를 임의로 시도하지 않습니다.
4. 권한 제한 때문에 수행할 수 없는 작업은 문제와 대안을 문서화합니다.

## 3.3 [환경 분기 B] Windows 11 Pro + WSL + Ubuntu 24.04

이 항목은 사용자 실습환경을 위한 권장 분기입니다.

- WSL Ubuntu 터미널에서 미션을 수행합니다.
- VS Code Remote 연결 여부를 확인합니다.
- Windows 경로와 Linux 경로를 혼합하지 않습니다.
- Docker 명령을 어느 환경에서 실행했는지 기록합니다.
- 한 미션 안에서는 주 실행환경을 고정합니다.

---

# 4. 실행 환경 기준선

## 4.1 [필수] 환경 확인 명령

Linux 또는 WSL:

```bash
uname -a
cat /etc/os-release
printf '%s\n' "$SHELL"
git --version
docker --version
docker info
```

macOS:

```bash
sw_vers
printf '%s\n' "$SHELL"
git --version
docker --version
docker info
```

## 4.2 기록 양식

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

완료 조건:

- [ ] OS·버전 기록
- [ ] Shell·Terminal 기록
- [ ] Docker 버전과 엔진 동작 상태 기록
- [ ] Git 버전 기록
- [ ] 개인 PC에 종속된 설정과 대안 기록

---

# 5. 터미널 기본 조작

## 5.1 [필수] 실습 명령

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

## 5.2 기록할 내용

- 입력한 명령
- 출력 결과
- 작업 전 상태
- 작업 후 상태
- 오류가 발생했다면 원문 오류 메시지

## 5.3 설명 질문

1. `pwd`와 `ls`의 차이는 무엇인가?
2. 절대 경로와 상대 경로는 무엇인가?
3. `cp`와 `mv`는 무엇이 다른가?
4. `rm` 사용 시 무엇을 주의해야 하는가?
5. `.`과 `..`은 무엇을 의미하는가?

---

# 6. 파일과 디렉터리 권한

## 6.1 권한 해석

```text
r = read    = 4
w = write   = 2
x = execute = 1
```

| 표기 | 소유자 | 그룹 | 기타 사용자 |
|---|---|---|---|
| `755` | `rwx` | `r-x` | `r-x` |
| `644` | `rw-` | `r--` | `r--` |

## 6.2 [필수] 파일 권한 변경

```bash
touch permission-file.txt
ls -l permission-file.txt
chmod 644 permission-file.txt
ls -l permission-file.txt
chmod 600 permission-file.txt
ls -l permission-file.txt
```

## 6.3 [필수] 디렉터리 권한 변경

```bash
mkdir permission-dir
ls -ld permission-dir
chmod 755 permission-dir
ls -ld permission-dir
chmod 700 permission-dir
ls -ld permission-dir
```

완료 조건:

- [ ] 파일 1개 이상 권한 변경
- [ ] 디렉터리 1개 이상 권한 변경
- [ ] 변경 전·후 출력 비교
- [ ] 변경한 권한의 선택 이유 기록
- [ ] `755`와 `644`를 구두 설명 가능

---

# 7. Docker 설치·실행 환경 점검

## 7.1 [필수] 점검

```bash
docker --version
docker info
```

| 결과 | 해석 | 확인할 내용 |
|---|---|---|
| 두 명령 모두 성공 | Docker 사용 가능 | 다음 단계 진행 |
| 버전만 성공 | Docker CLI는 있으나 엔진 연결 문제 가능 | OrbStack/Docker 실행 상태 |
| 명령을 찾을 수 없음 | 명령 경로 또는 실행환경 문제 | 설치 방식과 PATH |
| 권한 오류 | 사용자 권한 또는 소켓 접근 문제 가능 | 임의 우회 전 원인 확인 |

> 오류 메시지를 삭제하거나 바로 우회하지 말고 먼저 그대로 기록합니다.

---

# 8. Docker 기본 운영

## 8.1 [필수] 이미지 목록

```bash
docker images
```

## 8.2 [필수] hello-world

```bash
docker run --name e1-1-hello hello-world
docker ps
docker ps -a
docker logs e1-1-hello
```

같은 이름의 컨테이너가 이미 있으면 상태를 확인한 후 제거하거나 다른 이름을 사용합니다.

## 8.3 [필수] Ubuntu 컨테이너

```bash
docker run -d \
  --name e1-1-ubuntu \
  ubuntu sleep infinity


docker exec -it e1-1-ubuntu bash
```

컨테이너 내부:

```bash
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

호스트:

```bash
docker ps
docker ps -a
docker exec e1-1-ubuntu bash -lc 'echo "exec test" && ls -la /'
docker stop e1-1-ubuntu
docker start e1-1-ubuntu
```

## 8.4 [필수] 운영 명령

```bash
docker images
docker ps
docker ps -a
docker logs <container-name>
docker stats --no-stream
```

설명 준비:

- 이미지와 컨테이너의 차이
- 실행 중·중지된 컨테이너 확인 방법
- `docker run`과 `docker exec`의 차이
- `docker logs`와 `docker stats`의 목적

---

# 9. Dockerfile 기반 커스텀 웹 서버

## 9.1 [필수] `site/index.html`

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

## 9.2 [필수] `Dockerfile`

```dockerfile
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-e1-1-web"
LABEL org.opencontainers.image.description="Codyssey E1-1 custom web server"

COPY site/ /usr/share/nginx/html/

EXPOSE 80
```

## 9.3 [권장] `.dockerignore`

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

## 9.5 [필수] 실행

```bash
docker run -d \
  --name codyssey-e1-1-web \
  -p 8080:80 \
  codyssey-e1-1-web:1.0
```

## 9.6 [필수] 접속 확인

```bash
docker ps
docker logs codyssey-e1-1-web
curl http://localhost:8080
```

브라우저:

```text
http://localhost:8080
```

기록할 내용:

- 선택한 베이스 이미지와 선택 이유
- 변경한 정적 콘텐츠 또는 설정
- Dockerfile 각 명령의 역할
- 빌드 명령과 결과
- 실행 명령과 결과
- 웹 접속 결과

---

# 10. 포트 매핑

```text
-p <host-port>:<container-port>
```

`-p 8080:80`의 의미:

- `8080`: 호스트에서 접속하는 포트
- `80`: 컨테이너 내부 NGINX 포트

## 10.1 [필수] 증거

다음 정보가 함께 보이도록 기록합니다.

- `docker ps`의 포트 정보
- 브라우저 주소창과 웹 응답 화면 또는 `curl` 명령과 응답
- 사용한 호스트 포트와 컨테이너 포트

## 10.2 [권장] 두 번째 포트 검증

```bash
docker run -d \
  --name codyssey-e1-1-web-8081 \
  -p 8081:80 \
  codyssey-e1-1-web:1.0

curl http://localhost:8081
```

---

# 11. 바인드 마운트

## 11.1 [필수] 컨테이너 실행

```bash
docker run -d \
  --name codyssey-e1-1-bind \
  -p 8082:80 \
  -v "$(pwd)/site:/usr/share/nginx/html:ro" \
  nginx:alpine
```

## 11.2 변경 전 확인

```bash
curl http://localhost:8082
```

## 11.3 호스트 파일 변경

`site/index.html`에 다음과 같은 문구를 추가합니다.

```html
<p>바인드 마운트 변경 반영 확인 완료</p>
```

## 11.4 변경 후 확인

```bash
curl http://localhost:8082
```

완료 조건:

- [ ] 실행 명령 기록
- [ ] 변경 전 응답 기록
- [ ] 호스트 파일 변경 내용 기록
- [ ] 변경 후 응답 기록
- [ ] 바인드 마운트 목적 설명

---

# 12. Docker 볼륨 영속성

## 12.1 [필수] 볼륨 생성

```bash
docker volume create codyssey-e1-1-data
docker volume ls
```

## 12.2 첫 번째 컨테이너

```bash
docker run -d \
  --name e1-1-volume-test-1 \
  -v codyssey-e1-1-data:/data \
  ubuntu sleep infinity


docker exec e1-1-volume-test-1 \
  bash -lc 'echo "persistent data" > /data/result.txt && cat /data/result.txt'
```

## 12.3 컨테이너 삭제

```bash
docker rm -f e1-1-volume-test-1
```

## 12.4 두 번째 컨테이너에서 확인

```bash
docker run -d \
  --name e1-1-volume-test-2 \
  -v codyssey-e1-1-data:/data \
  ubuntu sleep infinity


docker exec e1-1-volume-test-2 \
  bash -lc 'cat /data/result.txt'
```

예상 결과:

```text
persistent data
```

완료 조건:

- [ ] 볼륨 생성 기록
- [ ] 데이터 작성 기록
- [ ] 첫 번째 컨테이너 삭제 기록
- [ ] 새 컨테이너에서 기존 데이터 확인
- [ ] 컨테이너와 볼륨의 수명 차이 설명

---

# 13. Git 설정과 GitHub/VS Code 연동

## 13.1 [필수] Git 설정

```bash
git config --global user.name
git config --global user.email
git config --global init.defaultBranch
git config --list
```

## 13.2 저장소 상태

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
| 2 | 환경·터미널·권한 | `Docs: add environment and permission evidence` |
| 3 | 웹 콘텐츠 | `Feat: add static web content` |
| 4 | Dockerfile | `Feat: add custom nginx image` |
| 5 | 포트 매핑 | `Docs: document port mapping verification` |
| 6 | 바인드 마운트 | `Docs: add bind mount verification` |
| 7 | 볼륨 영속성 | `Docs: add volume persistence evidence` |
| 8 | 트러블슈팅 | `Docs: record troubleshooting cases` |
| 9 | 최종 검증 | `Docs: complete reproduction checklist` |

## 13.4 [필수] 연동 증거

- VS Code에서 저장소가 열려 있음
- Source Control에서 Git 저장소가 인식됨
- GitHub 원격 저장소 연결 상태
- push 후 GitHub에서 파일 확인

---

# 14. 보안과 개인정보 보호

## 14.1 저장소에 올리면 안 되는 정보

- GitHub 액세스 토큰
- 비밀번호
- SSH 개인키
- 인증 코드
- 클라우드 자격증명
- `.env`의 비밀값
- 학교·기관 내부 민감정보

## 14.2 [권장] `.gitignore`

```gitignore
.env
.env.*
*.pem
*.key
*.log
.DS_Store
```

## 14.3 커밋 전 확인

```bash
git status
git diff --cached
```

- [ ] 스크린샷에 토큰이 없다.
- [ ] 비밀번호와 인증 코드가 없다.
- [ ] 개인키가 추적되지 않는다.
- [ ] 원격 저장소 주소에 자격증명이 없다.
- [ ] 터미널 화면의 민감정보를 마스킹했다.

민감정보 노출이 의심되면 파일에서 지우는 데서 끝내지 않고, Git 히스토리 잔존 여부와 자격증명 폐기·재발급 필요성을 확인합니다.

---

# 15. 트러블슈팅 2건 이상

`docs/troubleshooting.md`에 아래 구조로 기록합니다.

## TS-01. 문제 제목

### 발생 환경

- OS:
- Shell:
- Docker 실행 방식:

### 문제

어떤 작업에서 어떤 문제가 발생했는지 작성합니다.

### 실행 명령

```bash
문제가 발생한 명령
```

### 오류 메시지

```text
오류 원문
```

### 원인 가설

1. 첫 번째 가설
2. 두 번째 가설

### 확인 과정

어떤 명령과 자료로 가설을 확인했는지 기록합니다.

### 실제 원인

확인된 원인을 작성합니다.

### 해결 또는 대안

수행한 조치 또는 학교 환경에서 가능한 대안을 작성합니다.

### 해결 검증

```bash
검증 명령
```

### 재발 방지

다음에는 무엇을 먼저 확인할지 작성합니다.

권장 문제 후보:

- Docker 엔진 미실행
- 사용 중인 포트
- 컨테이너 이름 중복
- Dockerfile 경로 오류
- `COPY` 대상 파일 누락
- 바인드 마운트 호스트 경로 오류
- 파일 권한으로 인한 읽기 실패
- 다른 이름의 볼륨 연결
- Git 원격 저장소 설정 오류
- README와 실제 파일 구조 불일치

---

# 16. 요구사항 추적표

| ID | 요구사항 | 구현·기록 위치 | 검증 방법 | 증거 | 상태 |
|---|---|---|---|---|---|
| R-01 | 프로젝트 개요 | `README.md` | 문서 검토 | README | ⬜ |
| R-02 | 실행 환경 | `docs/environment.md` | 버전 확인 | 환경 로그 | ⬜ |
| R-03 | 터미널 조작 | `docs/terminal-and-permissions.md` | CLI 실행 | 명령+출력 | ⬜ |
| R-04 | 권한 변경 | `docs/terminal-and-permissions.md` | `ls -l` 비교 | 전·후 자료 | ⬜ |
| R-05 | Docker 점검 | `docs/docker-operations.md` | version/info | 로그 | ⬜ |
| R-06 | Docker 운영 | `docs/docker-operations.md` | images/ps/logs/stats | 로그 | ⬜ |
| R-07 | hello-world | `docs/docker-operations.md` | 컨테이너 실행 | 로그 | ⬜ |
| R-08 | Ubuntu 컨테이너 | `docs/docker-operations.md` | 내부 명령 | 로그 | ⬜ |
| R-09 | 커스텀 이미지 | `Dockerfile` | build/run | 로그 | ⬜ |
| R-10 | 포트 매핑 | `docs/docker-operations.md` | 브라우저/curl | 접속 증거 | ⬜ |
| R-11 | 바인드 마운트 | `docs/bind-mount.md` | 변경 전·후 | 응답 비교 | ⬜ |
| R-12 | 볼륨 영속성 | `docs/volume-persistence.md` | 삭제 전·후 | 데이터 비교 | ⬜ |
| R-13 | GitHub/VS Code | README 또는 docs | Git 상태·화면 | 로그/캡처 | ⬜ |
| R-14 | 트러블슈팅 2건 | `docs/troubleshooting.md` | 문서 검토 | TS-01/02 | ⬜ |
| R-15 | 민감정보 보호 | 전체 저장소 | 수동 점검 | 점검 결과 | ⬜ |
| R-16 | 재현성 | 전체 저장소 | clean clone | 재현 로그 | ⬜ |

상태 표기:

- ⬜ 미수행
- 🟨 진행 중
- ✅ 완료
- ❌ 재작업 필요

---

# 17. 테스트 매트릭스

| ID | 대상 | 조건 | 기대 결과 | 실제 결과 | 상태 |
|---|---|---|---|---|---|
| T-01 | Docker 점검 | 엔진 실행 | `docker info` 성공 |  | ⬜ |
| T-02 | hello-world | 최초 실행 | 성공 메시지 |  | ⬜ |
| T-03 | Ubuntu | 내부 `echo` | 문자열 출력 |  | ⬜ |
| T-04 | Dockerfile | 이미지 빌드 | 빌드 성공 |  | ⬜ |
| T-05 | 포트 | `localhost:8080` | 웹 응답 |  | ⬜ |
| T-06 | 바인드 마운트 | 호스트 파일 수정 | 변경 반영 |  | ⬜ |
| T-07 | 볼륨 | 컨테이너 삭제 후 재연결 | 데이터 유지 |  | ⬜ |
| T-08 | 오류 진단 | 사용 중 포트 | 오류 원인 기록 |  | ⬜ |
| T-09 | Git | push | GitHub에 반영 |  | ⬜ |
| T-10 | 재현성 | 새 폴더 clone | README로 재현 |  | ⬜ |
| T-11 | 보안 | 저장소·스크린샷 검사 | 민감정보 없음 |  | ⬜ |

---

# 18. 증거 인덱스

| ID | 내용 | 파일·링크 | 상태 |
|---|---|---|---|
| EV-01 | OS·Shell·Git·Docker 버전 |  | ⬜ |
| EV-02 | 터미널 기본 조작 |  | ⬜ |
| EV-03 | 파일·디렉터리 권한 전후 |  | ⬜ |
| EV-04 | `docker info` |  | ⬜ |
| EV-05 | hello-world |  | ⬜ |
| EV-06 | Ubuntu 내부 명령 |  | ⬜ |
| EV-07 | 이미지 빌드 |  | ⬜ |
| EV-08 | 포트 접속 |  | ⬜ |
| EV-09 | 바인드 마운트 전후 |  | ⬜ |
| EV-10 | 볼륨 데이터 유지 |  | ⬜ |
| EV-11 | GitHub/VS Code 연동 |  | ⬜ |
| EV-12 | 트러블슈팅 2건 |  | ⬜ |
| EV-13 | clean clone 재현 |  | ⬜ |

---

# 19. 품질 게이트

## Gate 0. 환경

- [ ] 터미널·Git·GitHub 사용 가능
- [ ] Docker 또는 OrbStack 사용 가능
- [ ] 주 작업 경로 확정

## Gate 1. 기능

- [ ] 터미널·권한 실습
- [ ] Docker 기본 운영
- [ ] Dockerfile 빌드·실행
- [ ] 포트 매핑
- [ ] 바인드 마운트
- [ ] 볼륨 영속성

## Gate 2. 문서와 증거

- [ ] 명령과 출력이 함께 있음
- [ ] 주소창 또는 curl 응답이 있음
- [ ] 트러블슈팅 2건 이상
- [ ] README에서 모든 증거 접근 가능
- [ ] 민감정보 없음

## Gate 3. Git

- [ ] 모든 변경 commit
- [ ] 원격 저장소 push
- [ ] Default branch 최신
- [ ] `git status` 정리
- [ ] 작업을 설명하는 커밋 메시지

## Gate 4. 설명

- [ ] 이미지와 컨테이너 설명
- [ ] Dockerfile 설명
- [ ] 포트 매핑 설명
- [ ] 바인드 마운트와 볼륨 비교
- [ ] `755`, `644` 설명
- [ ] 트러블슈팅 2건 설명

## Gate 5. 재현성과 평가

- [ ] 새 디렉터리에서 clone
- [ ] README만 보고 빌드·실행
- [ ] 링크와 증거 확인
- [ ] 평가 대상 Default branch 확인
- [ ] 구두 모의평가 완료

---

# 20. 권장 40시간 운영

> 아래 시간 배분은 공식 배점이나 시험 일정이 아니라 입문자용 권장 계획입니다.

| 단계 | 내용 | 시간 |
|---|---|---:|
| 1 | 미션 분석·환경 진단 | 3시간 |
| 2 | 터미널·경로·권한 | 6시간 |
| 3 | Docker 개념·기본 운영 | 7시간 |
| 4 | Dockerfile·커스텀 이미지 | 6시간 |
| 5 | 포트 매핑 | 3시간 |
| 6 | 바인드 마운트 | 3시간 |
| 7 | 볼륨 영속성 | 3시간 |
| 8 | Git/GitHub·VS Code | 3시간 |
| 9 | 트러블슈팅·README·증거 | 4시간 |
| 10 | clean clone·모의평가 | 2시간 |
| **합계** |  | **40시간** |

---

# 21. 모의시험·동료평가 대비

> 미션 소스에는 공식 시험 문항·배점·합격점이 제시되어 있지 않습니다. 아래 항목은 학습점검과 동료평가 준비용입니다.

## 21.1 구두 질문

1. 터미널과 셸은 무엇이 다른가?
2. 절대 경로와 상대 경로의 차이는 무엇인가?
3. `755`와 `644`를 설명하라.
4. Docker 이미지와 컨테이너의 차이는 무엇인가?
5. Dockerfile은 왜 필요한가?
6. `-p 8080:80`은 무엇을 의미하는가?
7. 바인드 마운트와 볼륨의 차이는 무엇인가?
8. 컨테이너를 삭제해도 볼륨 데이터가 유지되는 이유는 무엇인가?
9. Git과 GitHub의 역할은 무엇이 다른가?
10. 트러블슈팅 한 건을 문제 → 가설 → 확인 → 해결 순서로 설명하라.

## 21.2 실기 점검

1. 현재 위치와 파일 목록 확인
2. 파일·디렉터리 생성 및 권한 변경
3. Docker 버전과 엔진 확인
4. hello-world 실행
5. Dockerfile 이미지 빌드
6. 포트 매핑 컨테이너 실행
7. 브라우저 또는 curl 접속
8. 바인드 마운트 변경 반영
9. 볼륨 영속성 확인
10. Git status·branch·log 확인

## 21.3 평가 직전 확인

```bash
git status
git branch
git remote -v
git log --oneline --graph --all
```

- [ ] Default branch가 평가 대상 결과와 일치한다.
- [ ] 최신 변경이 push되어 있다.
- [ ] 미커밋 변경이 없다.
- [ ] README 실행 방법이 실제 파일 구조와 일치한다.
- [ ] 모든 필수 기능을 처음부터 시연할 수 있다.
- [ ] 각 선택을 본인의 말로 설명할 수 있다.

## 21.4 발표 순서

1. 미션 목표
2. 실행환경
3. 저장소 구조
4. 터미널·권한
5. Docker 기본 운영
6. Dockerfile과 커스텀 이미지
7. 포트 매핑
8. 바인드 마운트
9. 볼륨 영속성
10. GitHub 연동
11. 트러블슈팅
12. 한계와 개선점

설명 구조:

```text
무엇을 수행했는가
→ 왜 이 방법을 선택했는가
→ 어떻게 검증했는가
→ 문제가 발생했을 때 어떻게 해결했는가
→ 남은 한계는 무엇인가
```

---

# 22. FAIL 또는 재작업 절차

1. 실패한 요구사항을 식별합니다.
2. 재현 명령·실제 출력·기대 결과를 기록합니다.
3. 원인을 개념·환경·명령·권한·Docker·Git·문서·설명 문제로 분류합니다.
4. 작은 단위로 수정하고 commit합니다.
5. 실패한 테스트를 재실행합니다.
6. 다른 필수 기능도 회귀 테스트합니다.
7. 새 폴더에서 다시 clone합니다.
8. README 절차를 다시 검증합니다.
9. 무엇을 몰랐고 왜 미리 발견하지 못했는지 회고합니다.

---

# 23. 보너스 과제

## 23.1 [보너스] Docker Compose 기초

- 단일 서비스를 Compose로 실행
- 실행 명령이 문서화된 설정으로 바뀌는 이유 정리

## 23.2 [보너스] 멀티 컨테이너

- 웹 서버와 보조 서비스 2개 이상 실행
- 컨테이너 간 네트워크 통신 확인

## 23.3 [보너스] Compose 운영

```bash
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

## 23.4 [보너스] 환경 변수

- Dockerfile 또는 Compose에 환경 변수 주입
- 코드와 설정의 분리 설명

## 23.5 [보너스] GitHub SSH 인증

- HTTPS와 SSH 인증 방식 비교
- SSH push 확인
- 개인키 비공개 원칙 확인

---

# 24. 최종 제출 체크리스트

## 저장소와 문서

- [ ] GitHub Repository 링크로 제출 가능
- [ ] Default branch에 최신 결과 반영
- [ ] 프로젝트 개요와 실행 환경
- [ ] 수행 체크리스트
- [ ] 명령과 출력 로그
- [ ] 검증 방법과 증거 링크
- [ ] 트러블슈팅 2건 이상
- [ ] 개인 환경 종속성과 대안

## 터미널과 권한

- [ ] 위치·목록·이동·생성·복사·이름변경·삭제
- [ ] 파일 내용 확인·빈 파일 생성
- [ ] 파일 권한 변경 전후
- [ ] 디렉터리 권한 변경 전후

## Docker

- [ ] `docker --version`
- [ ] `docker info`
- [ ] `docker images`
- [ ] `docker ps`, `docker ps -a`
- [ ] `docker logs`, `docker stats`
- [ ] hello-world
- [ ] Ubuntu 컨테이너
- [ ] Dockerfile 빌드·실행
- [ ] 포트 매핑 접속
- [ ] 바인드 마운트 변경 반영
- [ ] 볼륨 영속성

## Git/GitHub와 보안

- [ ] Git 사용자 정보·기본 브랜치 확인
- [ ] GitHub 원격 저장소 연결
- [ ] VS Code 연동 증거
- [ ] push 완료
- [ ] 토큰·비밀번호·개인키·인증 코드 없음
- [ ] 스크린샷 민감정보 마스킹

## 재현성

- [ ] 새 폴더에 clone
- [ ] README만 보고 빌드
- [ ] README만 보고 실행
- [ ] 브라우저 또는 curl 응답 확인
- [ ] 모든 링크 정상

---

# 25. 최종 완료 정의

이 미션은 컨테이너가 한 번 실행되었다고 끝나는 것이 아닙니다.

1. **실행 가능:** 필수 명령과 기능이 동작한다.
2. **검증 가능:** 명령과 출력, 접속 화면, 데이터 유지 증거가 있다.
3. **재현 가능:** 다른 사람이 README만 보고 동일 결과를 확인할 수 있다.
4. **설명 가능:** 설정과 선택 이유를 본인의 말로 설명할 수 있다.
5. **복구 가능:** 오류 원인을 기록하고 해결 또는 대안을 제시할 수 있다.
6. **안전:** 저장소와 스크린샷에 민감정보가 없다.

> **환경을 설치하는 것보다 중요한 것은, 그 환경이 왜 동작하는지 설명하고 다른 사람이 재현할 수 있도록 증명하는 것입니다.**
