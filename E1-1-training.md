# E1-1. AI/SW 개발 워크스테이션 구축 — 초보자 무중단 수행 가이드

> 코디세이 입학연수 · 개발 입문 · 권장 학습시간 40시간  
> 주 실습환경: **macOS + OrbStack + Ubuntu 24.04 LTS + OrbStack Docker**  
> OrbStack Linux machine 이름: **`codyssey-training`**

이 문서는 초보자가 명령을 위에서부터 순서대로 실행하면서 다음 결과를 만들도록 구성한 기본 경로입니다.

> **터미널 기초 → OrbStack Ubuntu → Docker 연결 → GitHub CLI 인증 → 저장소 clone → 한 개의 작업 브랜치 → 의미 단위 commit → Draft PR → 미션 실습 → clean clone 검증 → PR 병합 → 최종 평가 준비**

---

## 0. 문서 사용 규칙

### 0.1 표시 기준

| 표시 | 의미 |
|---|---|
| **[macOS]** | Mac 터미널에서 실행 |
| **[Ubuntu]** | `codyssey-training` 안에서 실행 |
| **[컨테이너]** | Docker 컨테이너 셸에서 실행 |
| **[확인]** | 상태만 확인하는 명령 |
| **[오류 시]** | 정상 흐름에서 실패했을 때만 실행 |
| **[선택]** | 기본 경로에는 필요하지 않은 확장 항목 |

### 0.2 그대로 복사하면 안 되는 표기

이 문서의 기본 실행 명령에는 `<파일>`, `<PR번호>`, `<브랜치>` 같은 셸 자리표시자를 사용하지 않습니다. 이름이 필요한 경우 실제 변수에 값을 저장해서 사용합니다.

```bash
WORK_BRANCH="feat/e1-1-complete"
REPOSITORY="MetaStudy999/codyssey-training-e1-1"
```

### 0.3 한 개 브랜치·한 개 PR 원칙

첫 수행에서는 여러 브랜치로 나누지 않습니다.

```text
main
└── feat/e1-1-complete
    ├── 환경 commit
    ├── 터미널·권한 commit
    ├── Docker 기본 commit
    ├── Dockerfile commit
    ├── 포트 commit
    ├── 바인드 마운트 commit
    ├── 볼륨 commit
    ├── 트러블슈팅 commit
    └── 최종 문서 commit
```

`clean clone` 검증은 **PR 병합 전**에 수행합니다. 검증 결과를 같은 PR에 추가한 뒤 Ready 상태로 전환하고 병합합니다.

---

# 목차

1. 미션 완료 기준
2. 전체 수행 순서
3. 터미널 기초
4. macOS·OrbStack 점검
5. Ubuntu 24.04 machine 생성
6. Ubuntu 기본환경과 네트워크
7. OrbStack Docker 연결과 경로 시험
8. GitHub CLI 설치
9. GitHub CLI 인증
10. 저장소 권한 확인과 clone
11. 초기 폴더·문서 생성
12. VS Code 연결
13. 작업 브랜치 생성
14. Git 기본 반복 절차
15. 첫 commit과 push
16. Draft Pull Request 생성
17. 터미널·권한 미션
18. Docker 기본 운영
19. Dockerfile 웹 서버
20. 공통 포트 선택
21. 포트 매핑
22. 바인드 마운트
23. Docker 볼륨 영속성
24. 트러블슈팅과 증거 정리
25. clean clone 사전 검증
26. PR 최종 점검과 병합
27. 병합 후 최종 확인
28. 공용 장비 로그아웃
29. 오류 대응표
30. 확장 부록
31. 공식 참고문헌

---

# 1. 미션 완료 기준

GitHub 저장소의 Default branch인 `main`에서 다음 내용을 확인할 수 있어야 합니다.

- 터미널로 파일과 디렉터리를 생성·복사·이동·삭제했다.
- 파일과 디렉터리 권한을 확인하고 변경했다.
- OrbStack Ubuntu 24.04 `codyssey-training`을 사용했다.
- Ubuntu에서 OrbStack Docker Engine에 연결했다.
- Docker 이미지와 컨테이너를 실행·조회·중지·삭제했다.
- `Dockerfile`로 커스텀 웹 이미지를 빌드했다.
- 포트 매핑으로 Mac 브라우저에서 접속했다.
- 별도 `bind-test/` 디렉터리로 바인드 마운트를 검증했다.
- Docker 볼륨으로 컨테이너 삭제 후 데이터 유지 여부를 검증했다.
- GitHub CLI로 인증·clone·PR 상태 확인을 수행했다.
- `feat/e1-1-complete` 브랜치에서 의미 단위 commit을 작성했다.
- Draft PR에서 진행상황을 관리하고 clean clone 검증 후 병합했다.
- 트러블슈팅을 최소 2건 기록했다.
- 토큰·비밀번호·개인키를 저장소와 스크린샷에 노출하지 않았다.

---

# 2. 전체 수행 순서

```text
1. Mac 터미널 기본 명령 연습
2. OrbStack 실행 확인
3. codyssey-training 존재 여부 확인
4. 없으면 Ubuntu 24.04 machine 생성
5. Ubuntu 접속·네트워크 확인
6. 기본 패키지 설치
7. OrbStack Docker 연결
8. Docker build·bind mount 경로 사전 시험
9. GitHub CLI 설치
10. GitHub CLI 브라우저 인증
11. 저장소 쓰기 권한 확인
12. 저장소 clone
13. 기본 문서·폴더 생성
14. VS Code 연결
15. feat/e1-1-complete 브랜치 생성
16. 환경 기준선 작성·commit·push
17. Draft PR 생성
18. 터미널·권한 실습
19. Docker 기본 실습
20. Dockerfile·포트·마운트·볼륨 실습
21. 트러블슈팅·증거·추적표 작성
22. 현재 작업 브랜치를 새 폴더에 clean clone
23. clean clone 결과 commit·push
24. PR diff·checks·보안 점검
25. Ready 전환
26. PR 병합
27. main 최신화와 최종 smoke test
28. 공용 장비라면 마지막에 gh 로그아웃
```

---

# 3. 터미널 기초

Git과 Docker보다 먼저 경로와 파일 조작을 연습합니다.

```bash
# [macOS]
pwd
ls
ls -la
mkdir -p ~/codyssey-terminal-practice
cd ~/codyssey-terminal-practice
pwd

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
cd ~
```

설명할 수 있어야 하는 내용:

- `pwd`: 현재 위치
- `ls`: 현재 위치의 목록
- `cd`: 위치 이동
- `.`: 현재 디렉터리
- `..`: 상위 디렉터리
- 절대 경로: `/`에서 시작
- 상대 경로: 현재 위치를 기준으로 시작

---

# 4. macOS·OrbStack 점검

## 4.1 OrbStack 상태

```bash
# [macOS]
orb version
orb status
orb list
```

정상 기준:

- 버전이 출력된다.
- `orb status`가 오류 없이 실행된다.
- machine 목록을 볼 수 있다.

## 4.2 Mac의 OrbStack Docker

```bash
# [macOS]
docker version
docker context ls
docker context show
```

현재 context가 `orbstack`이 아니면 다음을 실행합니다.

```bash
# [macOS]
docker context use orbstack
docker context show
```

---

# 5. Ubuntu 24.04 machine 생성

## 5.1 기존 machine 확인

먼저 목록만 확인합니다.

```bash
# [macOS]
orb list
```

목록에 `codyssey-training`이 있을 때만 다음을 실행합니다.

```bash
# [macOS: 기존 machine이 있을 때만]
orb info codyssey-training
```

목록에 없으면 새로 생성합니다.

```bash
# [macOS: 기존 machine이 없을 때만]
orb create ubuntu:noble codyssey-training
```

자원 제한이 필요한 경우에는 위 기본 생성 명령 대신 다음 명령 하나만 사용합니다.

```bash
# [macOS: 선택]
orb create \
  --memory 4G \
  --cpus 2 \
  --disk 32G \
  ubuntu:noble \
  codyssey-training
```

## 5.2 접속

```bash
# [macOS]
orb -m codyssey-training
```

```bash
# [Ubuntu]
cat /etc/os-release
uname -a
uname -m
whoami
pwd
```

정상 기준:

- Ubuntu 24.04 또는 `VERSION_CODENAME=noble`
- 현재 사용자 확인
- 홈 디렉터리 확인

---

# 6. Ubuntu 기본환경과 네트워크

## 6.1 네트워크 확인

```bash
# [Ubuntu]
getent hosts github.com
curl -I https://github.com
```

두 명령 중 하나라도 실패하면 `apt`, `gh`, `git clone`, `docker pull`도 실패할 수 있습니다. 이때는 다음 단계로 넘어가지 않습니다.

## 6.2 패키지 설치

```bash
# [Ubuntu]
sudo apt update
sudo apt install -y \
  ca-certificates \
  curl \
  wget \
  git \
  gnupg \
  vim \
  nano \
  tree \
  jq \
  unzip \
  zip
```

```bash
# [확인]
git --version
curl --version | head -n 1
jq --version
```

## 6.3 작업 상위 폴더

```bash
# [Ubuntu]
mkdir -p ~/codyssey-training
cd ~/codyssey-training
pwd
```

---

# 7. OrbStack Docker 연결과 경로 시험

## 7.1 Docker 명령 확인

```bash
# [Ubuntu]
command -v docker || true
type -a docker || true
mac which docker || true
```

`docker` 명령이 없으면 연결합니다.

```bash
# [Ubuntu: docker 명령이 없을 때만]
mac link docker
hash -r
command -v docker
```

## 7.2 Engine 연결 확인

```bash
# [Ubuntu]
docker version
docker info
docker run --rm hello-world
```

정상 기준:

- Client와 Server 정보가 모두 출력된다.
- `docker info`가 Engine 정보를 반환한다.
- `Hello from Docker!`가 출력된다.

`docker context show`는 참고 확인만 합니다.

```bash
# [확인]
docker context show || true
```

## 7.3 command link 복구

다음 증상이 있을 때만 실행합니다.

- `command -v docker`는 출력되지만 실행되지 않음
- `/opt/orbstack-guest/.../cmdlinks/docker` 관련 오류

```bash
# [오류 시]
mac unlink docker
mac link docker
hash -r
exec "$SHELL" -l
```

새 셸에서 다시 확인합니다.

```bash
command -v docker
docker version
docker info
```

## 7.4 Docker 경로 사전 시험

Ubuntu 홈 디렉터리의 파일을 Docker build와 bind mount에서 사용할 수 있는지 먼저 확인합니다.

```bash
# [Ubuntu]
mkdir -p ~/docker-path-test
cd ~/docker-path-test

cat > Dockerfile <<'EOF'
FROM alpine
COPY test.txt /test.txt
CMD ["cat", "/test.txt"]
EOF

echo "OrbStack path test" > test.txt

docker build -t orb-path-test .
docker run --rm orb-path-test
```

예상 결과:

```text
OrbStack path test
```

바인드 마운트 시험:

```bash
# [Ubuntu]
docker run --rm \
  -v "$PWD:/data:ro" \
  alpine \
  cat /data/test.txt
```

두 시험이 모두 성공해야 다음 단계로 진행합니다.

---

# 8. GitHub CLI 설치

## 8.1 설치 여부 확인

```bash
# [Ubuntu]
command -v gh || true
gh --version || true
```

정상 버전이 표시되면 설치 단계를 건너뜁니다.

## 8.2 Ubuntu 공식 패키지 저장소 등록

```bash
# [Ubuntu]
sudo mkdir -p -m 755 /etc/apt/keyrings

wget -nv \
  -O /tmp/githubcli-archive-keyring.gpg \
  https://cli.github.com/packages/githubcli-archive-keyring.gpg

sudo cp /tmp/githubcli-archive-keyring.gpg \
  /etc/apt/keyrings/githubcli-archive-keyring.gpg

sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt update
sudo apt install -y gh
```

```bash
# [확인]
gh --version
gh help
```

---

# 9. GitHub CLI 인증

## 9.1 브라우저 인증

```bash
# [Ubuntu]
gh auth login \
  --hostname github.com \
  --git-protocol https \
  --web \
  --clipboard
```

브라우저가 자동으로 열리지 않으면 다음 순서로 처리합니다.

1. 터미널에 표시된 URL을 확인한다.
2. Mac 브라우저에서 URL을 연다.
3. 클립보드에 복사된 일회용 코드를 입력한다.
4. 인증 완료 후 Ubuntu 터미널로 돌아온다.

```bash
# [확인]
gh auth status --hostname github.com
gh auth setup-git --hostname github.com
gh config get git_protocol
```

정상 기준:

- 로그인 계정이 표시된다.
- Git protocol이 `https`이다.
- `gh auth setup-git`이 오류 없이 끝난다.

> `gh auth logout`은 지금 실행하지 않습니다. 공용 장비 로그아웃은 모든 작업이 끝난 뒤 28장에서 수행합니다.

---

# 10. 저장소 권한 확인과 clone

## 10.1 쓰기 권한 확인

```bash
# [Ubuntu]
gh repo view MetaStudy999/codyssey-training-e1-1 \
  --json nameWithOwner,viewerPermission
```

다음 권한이면 origin에 push할 수 있습니다.

```text
ADMIN
MAINTAIN
WRITE
```

`READ`만 표시되면 push 단계로 진행하지 말고 저장소 관리자에게 쓰기 권한을 요청합니다.

## 10.2 clone

```bash
# [Ubuntu]
cd ~/codyssey-training

gh repo clone MetaStudy999/codyssey-training-e1-1
cd codyssey-training-e1-1
```

```bash
# [확인]
pwd
git status -sb
git branch --show-current
git remote -v
```

정상 기준:

- 경로가 `~/codyssey-training/codyssey-training-e1-1`
- 현재 branch가 `main`
- remote가 대상 저장소를 가리킴

---

# 11. 초기 폴더·문서 생성

현재 존재하지 않는 결과 문서를 먼저 생성합니다.

```bash
# [Ubuntu: 저장소 루트]
mkdir -p docs/screenshots/{environment,git,terminal,permissions,docker,port,mount,volume,github}

for file in \
  docs/environment.md \
  docs/terminal-and-permissions.md \
  docs/docker-operations.md \
  docs/bind-mount.md \
  docs/volume-persistence.md \
  docs/troubleshooting.md \
  docs/test-results.md \
  docs/requirement-traceability.md
do
  test -e "$file" || printf '# %s\n\n' "$(basename "$file" .md)" > "$file"
done

printf '\n.env.local\n' >> .gitignore
sort -u .gitignore -o .gitignore

git status -sb
```

빈 디렉터리는 Git이 저장하지 않습니다. 각 스크린샷 폴더는 실제 이미지가 생길 때 GitHub에 나타납니다.

---

# 12. VS Code 연결

```bash
# [Ubuntu]
command -v code || true
code .
```

`code`가 없으면 다음을 실행합니다.

```bash
# [오류 시]
mac link code
hash -r
command -v code
code .
```

정상 기준:

- Mac의 VS Code가 실행된다.
- `codyssey-training-e1-1` 폴더가 열린다.
- Source Control에 현재 변경 파일이 표시된다.

---

# 13. 작업 브랜치 생성

```bash
# [Ubuntu: 저장소 루트]
WORK_BRANCH="feat/e1-1-complete"

git switch main
git pull --ff-only origin main
git switch -c "$WORK_BRANCH"
```

```bash
# [확인]
git status -sb
git branch -vv
```

이 미션을 완료할 때까지 같은 `feat/e1-1-complete` 브랜치를 사용합니다.

---

# 14. Git 기본 반복 절차

모든 작업 단위에서 다음 순서를 반복합니다.

```text
파일 수정
→ git status -sb
→ git diff
→ 필요한 파일만 git add
→ git diff --cached
→ git commit
→ git push
```

초보자 기본 방식은 파일명을 직접 지정하는 것입니다.

```bash
# 예시
git add docs/environment.md
git diff --cached
git commit -m "Docs: record OrbStack Ubuntu environment"
```

잘못 staging한 파일은 다음과 같이 staging에서만 제거합니다.

```bash
git restore --staged docs/screenshots/github/private-account.png
```

`chmod 644 → 600` 같은 전체 Unix 권한 차이는 Git diff에 표시되지 않을 수 있습니다. 권한 실습은 `ls -l` 출력과 문서·스크린샷으로 증명합니다.

---

# 15. 첫 commit과 push

## 15.1 환경 기준선 기록

```bash
# [Ubuntu]
{
  echo "# 실행 환경"
  echo
  echo "## Ubuntu"
  echo '```text'
  cat /etc/os-release
  uname -a
  uname -m
  git --version
  gh --version | head -n 1
  docker --version
  echo '```'
  echo
  echo "## Docker 연결"
  echo "- docker version: 성공"
  echo "- docker info: 성공"
  echo "- hello-world: 성공"
} > docs/environment.md
```

## 15.2 commit

```bash
git status -sb
git diff

git add \
  .gitignore \
  docs/environment.md \
  docs/terminal-and-permissions.md \
  docs/docker-operations.md \
  docs/bind-mount.md \
  docs/volume-persistence.md \
  docs/troubleshooting.md \
  docs/test-results.md \
  docs/requirement-traceability.md

git diff --cached
git commit -m "Docs: initialize E1-1 evidence structure"
```

## 15.3 첫 push

```bash
git push -u origin "$WORK_BRANCH"
```

```bash
# [확인]
git status -sb
git branch -vv
```

강제 push는 사용하지 않습니다.

---

# 16. Draft Pull Request 생성

PR 본문은 중첩 코드 블록 오류가 나지 않도록 명령을 들여쓰기 형태로 기록합니다.

```bash
cat > /tmp/e1-1-pr-body.md <<'EOF'
## 작업 목적

E1-1 워크스테이션 구축 미션을 OrbStack Ubuntu 24.04 환경에서 수행하고 검증합니다.

## 진행 현황

- [x] 환경 준비
- [x] GitHub CLI 인증
- [x] 초기 문서 구조
- [ ] 터미널·권한
- [ ] Docker 기본 운영
- [ ] Dockerfile·포트
- [ ] 바인드 마운트
- [ ] 볼륨 영속성
- [ ] clean clone
- [ ] 최종 보안 점검

## 핵심 검증 명령

    cat /etc/os-release
    docker version
    docker info
    docker run --rm hello-world

## 증거 위치

- docs/environment.md
- docs/test-results.md
- docs/troubleshooting.md
- docs/screenshots/
EOF
```

```bash
gh pr create \
  --draft \
  --base main \
  --head "$WORK_BRANCH" \
  --title "Feat: complete E1-1 workstation mission" \
  --body-file /tmp/e1-1-pr-body.md
```

PR 번호를 변수에 저장합니다.

```bash
PR_NUMBER="$(gh pr view --json number --jq '.number')"
echo "PR 번호: $PR_NUMBER"
```

---

# 17. 터미널·권한 미션

```bash
# [Ubuntu]
cd ~/codyssey-training/codyssey-training-e1-1
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

권한 실습:

```bash
touch permission-file.txt
ls -l permission-file.txt
chmod 644 permission-file.txt
ls -l permission-file.txt
chmod 600 permission-file.txt
ls -l permission-file.txt

mkdir -p permission-dir
ls -ld permission-dir
chmod 755 permission-dir
ls -ld permission-dir
chmod 700 permission-dir
ls -ld permission-dir
```

`docs/terminal-and-permissions.md`에 명령, 출력, 권한 계산, 파일과 디렉터리의 `x` 차이를 기록합니다.

```bash
cd ~/codyssey-training/codyssey-training-e1-1
git add docs/terminal-and-permissions.md
git diff --cached
git commit -m "Docs: record terminal and permission practice"
git push
```

---

# 18. Docker 기본 운영

```bash
# [Ubuntu]
docker --version
docker version
docker info
docker images
docker ps
docker ps -a
docker stats --no-stream
```

`hello-world`:

```bash
docker rm -f e1-1-hello 2>/dev/null || true
docker run --name e1-1-hello hello-world
docker ps -a
docker logs e1-1-hello
```

Ubuntu 컨테이너:

```bash
docker rm -f e1-1-ubuntu 2>/dev/null || true

docker run -d \
  --name e1-1-ubuntu \
  ubuntu:24.04 \
  bash -lc 'echo "e1-1-ubuntu started"; sleep infinity'

docker logs e1-1-ubuntu
docker exec -it e1-1-ubuntu bash
```

컨테이너 안에서:

```bash
# [컨테이너]
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

Ubuntu machine에서:

```bash
# [Ubuntu]
docker stop e1-1-ubuntu
docker start e1-1-ubuntu
docker rm -f e1-1-ubuntu
```

`docs/docker-operations.md`에 결과를 기록한 뒤 commit합니다.

```bash
git add docs/docker-operations.md docs/screenshots/docker/
git diff --cached
git commit -m "Docs: record Docker image and container operations"
git push
```

---

# 19. Dockerfile 웹 서버

```bash
# [Ubuntu: 저장소 루트]
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

cat > Dockerfile <<'EOF'
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-e1-1-web"
LABEL org.opencontainers.image.description="Codyssey E1-1 custom web server"

COPY site/ /usr/share/nginx/html/

EXPOSE 80
EOF

cat > .dockerignore <<'EOF'
.git
.github
docs
practice
bind-test
*.log
EOF
```

빌드:

```bash
docker build -t codyssey-e1-1-web:1.0 .
docker images
docker image inspect codyssey-e1-1-web:1.0
```

```bash
git add Dockerfile .dockerignore site/index.html
git diff --cached
git commit -m "Feat: add NGINX Dockerfile and static page"
git push
```

---

# 20. 공통 포트 선택

8080이 다른 프로그램에서 사용 중일 수 있으므로 사용 가능한 포트를 한 번 선택해 `.env.local`에 저장합니다.

```bash
# [Ubuntu: 저장소 루트]
unset HOST_PORT

for candidate in 8080 8081 18080
do
  if ! mac lsof -nP -iTCP:"$candidate" -sTCP:LISTEN 2>/dev/null | grep -q LISTEN
  then
    HOST_PORT="$candidate"
    break
  fi
done

if test -z "${HOST_PORT:-}"
then
  echo "8080, 8081, 18080 포트를 모두 사용할 수 없습니다."
  exit 1
fi

printf 'HOST_PORT=%s\n' "$HOST_PORT" > .env.local
source .env.local
echo "사용 포트: $HOST_PORT"
```

새 터미널을 열었을 때는 저장소 루트에서 다시 실행합니다.

```bash
source .env.local
echo "$HOST_PORT"
```

`.env.local`은 `.gitignore`에 포함되어 GitHub에 올라가지 않습니다.

---

# 21. 포트 매핑

```bash
# [Ubuntu]
source .env.local

docker rm -f e1-1-web 2>/dev/null || true

docker run -d \
  --name e1-1-web \
  -p "${HOST_PORT}:80" \
  codyssey-e1-1-web:1.0
```

```bash
# [확인]
docker ps
docker logs e1-1-web
docker port e1-1-web
curl "http://localhost:${HOST_PORT}"
```

Mac 브라우저에서 다음 주소를 사용합니다.

```text
http://localhost:선택한포트
```

예를 들어 `HOST_PORT=8081`이면 `http://localhost:8081`입니다.

스크린샷에는 주소창, 포트, 웹 페이지를 함께 포함합니다.

```bash
git add docs/screenshots/port/ docs/test-results.md
git diff --cached
git commit -m "Test: verify Docker port mapping"
git push
```

---

# 22. 바인드 마운트

최종 웹 파일을 덮어쓰지 않도록 별도 `bind-test/`를 사용합니다.

```bash
# [Ubuntu]
source .env.local
mkdir -p bind-test

cat > bind-test/index.html <<'EOF'
<!doctype html>
<html lang="ko">
<head><meta charset="utf-8"><title>Bind Test</title></head>
<body><h1>바인드 마운트 최초 화면</h1></body>
</html>
EOF

docker rm -f e1-1-web e1-1-bind 2>/dev/null || true

docker run -d \
  --name e1-1-bind \
  -p "${HOST_PORT}:80" \
  -v "$PWD/bind-test:/usr/share/nginx/html:ro" \
  nginx:alpine

curl "http://localhost:${HOST_PORT}"
```

파일 변경:

```bash
cat > bind-test/index.html <<'EOF'
<!doctype html>
<html lang="ko">
<head><meta charset="utf-8"><title>Bind Test</title></head>
<body><h1>바인드 마운트 변경 반영 성공</h1></body>
</html>
EOF

curl "http://localhost:${HOST_PORT}"
```

`docs/bind-mount.md`에 변경 전후, `:ro`, 재빌드 없이 반영된 이유를 기록합니다.

```bash
git add bind-test/index.html docs/bind-mount.md docs/screenshots/mount/
git diff --cached
git commit -m "Test: verify bind mount file updates"
git push
```

---

# 23. Docker 볼륨 영속성

```bash
# [Ubuntu]
docker volume create e1-1-data
docker volume ls

docker rm -f e1-1-volume-1 2>/dev/null || true

docker run -d \
  --name e1-1-volume-1 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity

docker exec e1-1-volume-1 \
  bash -lc 'echo "persistent data" > /data/result.txt && cat /data/result.txt'

docker rm -f e1-1-volume-1

docker rm -f e1-1-volume-2 2>/dev/null || true

docker run -d \
  --name e1-1-volume-2 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity

docker exec e1-1-volume-2 cat /data/result.txt
```

마지막 명령에서 다음이 출력되어야 합니다.

```text
persistent data
```

```bash
git add docs/volume-persistence.md docs/screenshots/volume/
git diff --cached
git commit -m "Test: verify Docker volume persistence"
git push
```

---

# 24. 트러블슈팅과 증거 정리

`docs/troubleshooting.md`에 최소 2건을 작성합니다.

```markdown
## 문제 ID: TS-01

- 발생 환경:
- 작업 브랜치: feat/e1-1-complete
- 관련 commit 또는 PR:
- 실행 명령:
- 오류 메시지 원문:
- 재현 방법:
- 초기 가설:
- 확인한 명령:
- 실제 원인:
- 해결 또는 대안:
- 해결 검증:
- 재발 방지:
- 참고 공식 문서:
```

`docs/requirement-traceability.md`에는 요구사항과 증거를 연결합니다.

| ID | 요구사항 | 검증 | 증거 | commit·PR | 상태 |
|---|---|---|---|---|---|
| ENV-01 | Ubuntu 24.04 | `cat /etc/os-release` | environment | SHA / PR | ⬜ |
| ENV-02 | OrbStack Docker | `docker version` | docker | SHA / PR | ⬜ |
| GH-01 | gh 인증 | `gh auth status` | git 기록 | SHA / PR | ⬜ |
| CLI-01 | 터미널 조작 | `pwd`, `ls` | terminal | SHA / PR | ⬜ |
| PERM-01 | 권한 | `ls -l`, `ls -ld` | permissions | SHA / PR | ⬜ |
| IMG-01 | Dockerfile | `docker build` | build 결과 | SHA / PR | ⬜ |
| PORT-01 | 포트 | `curl` | 브라우저 | SHA / PR | ⬜ |
| MOUNT-01 | bind | 변경 전후 | mount | SHA / PR | ⬜ |
| VOL-01 | volume | 삭제 전후 `cat` | volume | SHA / PR | ⬜ |
| TS-01 | 오류 2건 | 재현·복구 | troubleshooting | SHA / PR | ⬜ |

```bash
git add \
  README.md \
  docs/troubleshooting.md \
  docs/requirement-traceability.md \
  docs/test-results.md

git diff --cached
git commit -m "Docs: add troubleshooting and evidence traceability"
git push
```

---

# 25. clean clone 사전 검증

이 단계는 **PR을 Ready로 바꾸거나 병합하기 전에** 수행합니다.

## 25.1 현재 작업 저장

```bash
# [Ubuntu: 원본 저장소]
git status -sb
git push

SOURCE_DIR="$PWD"
CURRENT_BRANCH="$(git branch --show-current)"
RETEST_DIR="$HOME/codyssey-reproduction/e1-1-$(date +%Y%m%d-%H%M%S)"

echo "원본: $SOURCE_DIR"
echo "검증 브랜치: $CURRENT_BRANCH"
echo "검증 폴더: $RETEST_DIR"
```

## 25.2 현재 작업 브랜치 clone

```bash
mkdir -p "$(dirname "$RETEST_DIR")"

gh repo clone MetaStudy999/codyssey-training-e1-1 \
  "$RETEST_DIR" \
  -- \
  --branch "$CURRENT_BRANCH" \
  --single-branch

cd "$RETEST_DIR"
git status -sb
```

## 25.3 별도 포트로 검증

```bash
RETEST_PORT=18080

if mac lsof -nP -iTCP:"$RETEST_PORT" -sTCP:LISTEN 2>/dev/null | grep -q LISTEN
then
  RETEST_PORT=18081
fi

docker build -t codyssey-e1-1-web:retest .
docker rm -f e1-1-retest 2>/dev/null || true

docker run -d \
  --name e1-1-retest \
  -p "${RETEST_PORT}:80" \
  codyssey-e1-1-web:retest

curl "http://localhost:${RETEST_PORT}"
```

정상 기준:

- 현재 PR 브랜치가 새 폴더에 clone된다.
- 문서 외의 숨은 로컬 파일 없이 이미지가 빌드된다.
- 별도 포트에서 웹 응답이 나온다.

## 25.4 원본으로 돌아가 검증 결과 반영

```bash
cd "$SOURCE_DIR"

cat >> docs/test-results.md <<EOF

## Clean clone 검증

- 검증 브랜치: $CURRENT_BRANCH
- 검증 폴더: $RETEST_DIR
- 검증 포트: $RETEST_PORT
- Docker build: 성공
- HTTP 응답: 성공
EOF

git add docs/test-results.md
git diff --cached
git commit -m "Test: record clean clone verification"
git push
```

---

# 26. PR 최종 점검과 병합

## 26.1 상태와 diff

```bash
PR_NUMBER="$(gh pr view --json number --jq '.number')"

git status -sb
gh pr status --conflict-status
gh pr view "$PR_NUMBER"
gh pr diff "$PR_NUMBER" --name-only
gh pr diff "$PR_NUMBER"
```

확인 항목:

- 의도하지 않은 파일 없음
- `.env.local` 없음
- 토큰·비밀번호·개인키 없음
- 스크린샷에 계정 정보·인증 코드 없음
- Dockerfile·site·bind-test·docs가 모두 있음
- clean clone 결과가 있음

## 26.2 checks 판정

```bash
gh pr checks "$PR_NUMBER"
```

판정 기준:

| 출력 상태 | 조치 |
|---|---|
| 검사가 있고 모두 통과 | 계속 진행 |
| 검사 자체가 없음 | `docs/test-results.md`에 `CI 없음, 수동 검증 완료` 기록 후 진행 가능 |
| 검사 실패 | 병합 금지, 원인 수정 |
| 검사 대기 | 완료까지 대기 |

## 26.3 Draft를 Ready로 변경

```bash
gh pr ready "$PR_NUMBER"
gh pr view "$PR_NUMBER"
```

## 26.4 병합

이 교육과정은 의미 있는 개별 commit을 보존하기 위해 merge commit을 기본으로 사용합니다.

```bash
gh pr merge "$PR_NUMBER" --merge --delete-branch
```

저장소의 branch protection, review, merge queue 정책이 있으면 해당 정책을 우선합니다. 요구사항을 우회하기 위해 `--admin`을 사용하지 않습니다.

---

# 27. 병합 후 최종 확인

```bash
# [Ubuntu]
git switch main
git pull --ff-only origin main
git fetch --prune

git status -sb
git log --oneline --graph --decorate --all -20
gh pr list --state merged --limit 10
```

최종 smoke test:

```bash
docker build -t codyssey-e1-1-web:final .
docker rm -f e1-1-final 2>/dev/null || true

docker run -d \
  --name e1-1-final \
  -p 18082:80 \
  codyssey-e1-1-web:final

curl http://localhost:18082
```

Default branch에서 웹 응답이 나오면 최종 반영이 완료된 것입니다.

---

# 28. 공용 장비 로그아웃

개인 장비에서는 로그인 상태를 유지할 수 있습니다. 학교 공용 장비에서는 모든 작업과 제출 확인이 끝난 뒤에만 실행합니다.

```bash
# [공용 장비에서 마지막에만]
gh auth status --hostname github.com
gh auth logout --hostname github.com
```

로그아웃 후 다음을 확인합니다.

```bash
gh auth status --hostname github.com || true
```

`~/.config/gh/` 안의 파일을 저장소에 복사하거나 commit하지 않습니다.

---

# 29. 오류 대응표

| 증상 | 확인 | 조치 |
|---|---|---|
| `orb info`에서 machine 없음 | `orb list` | 없으면 `orb create ubuntu:noble codyssey-training` |
| GitHub 접속 실패 | `getent hosts`, `curl -I` | 네트워크 해결 후 재시도 |
| `docker: command not found` | `mac which docker` | `mac link docker`, `hash -r` |
| Docker Client만 표시 | `docker info` | OrbStack 실행·context·link 확인 |
| Docker build 경로 오류 | 7.4 path test | path test가 성공하기 전 본 실습 중단 |
| 브라우저 인증 창 안 열림 | `gh auth login --web --clipboard` | URL을 Mac 브라우저에서 직접 열기 |
| push 권한 없음 | `viewerPermission` | WRITE 이상 권한 요청 |
| `destination path already exists` | clone 폴더 확인 | 기존 폴더를 삭제하지 말고 timestamp 폴더 사용 |
| `port is already allocated` | `mac lsof`, `docker ps` | 20장의 포트 선택 절차 재실행 |
| `container name is already in use` | `docker ps -a` | 해당 실습 컨테이너만 `docker rm -f` |
| `docker logs`가 비어 있음 | 컨테이너 시작 명령 | 시작 메시지가 포함된 18장 명령 사용 |
| `git status`에 chmod가 안 보임 | `ls -l` | 권한 차이를 문서·스크린샷으로 증명 |
| PR checks 없음 | `gh pr checks` | CI 없음 기록, 수동 clean clone 결과 확인 |
| push 거절 | `git fetch`, `git branch -vv` | force push 금지, 원격 상태 확인 |

---

# 30. 확장 부록

다음 내용은 기본 미션을 완료한 뒤 학습합니다.

## 30.1 다른 `git add` 방식

```bash
# 변경 일부만 선택
git add -p E1-1-training.md

# 추적 중인 파일의 수정·삭제만
git add -u

# 저장소 전체 변경
git add -A
```

첫 수행에서는 파일명을 직접 지정하는 방식을 우선합니다.

## 30.2 다른 병합 방식

```bash
# PR 전체를 commit 하나로 압축
gh pr merge "$PR_NUMBER" --squash --delete-branch

# 개별 commit을 선형으로 적용
gh pr merge "$PR_NUMBER" --rebase --delete-branch
```

## 30.3 Issue 연결

```bash
gh issue create \
  --title "E1-1 볼륨 영속성 검증" \
  --body "검증 명령과 증거를 기록한다."
```

PR 본문에 `Closes #번호`를 쓰면 병합 시 Issue를 닫을 수 있습니다.

## 30.4 임시 보관

```bash
git stash push -u -m "WIP before update"
git stash list
git stash pop
```

stash는 장기 보관소로 사용하지 않습니다.

---

# 31. 공식 참고문헌

> 확인일: **2026-08-02**

## OrbStack

- [R1] OrbStack — <https://docs.orbstack.dev/>
- [R2] Linux machines — <https://docs.orbstack.dev/machines/>
- [R3] Machine commands and `mac link` — <https://docs.orbstack.dev/machines/commands>
- [R4] Linux distributions — <https://docs.orbstack.dev/machines/distros>
- [R5] File sharing — <https://docs.orbstack.dev/machines/file-sharing>
- [R6] Docker containers — <https://docs.orbstack.dev/docker/>

## Docker

- [R7] Docker reference — <https://docs.docker.com/reference/>
- [R8] Dockerfile reference — <https://docs.docker.com/reference/dockerfile>
- [R9] Build context and `.dockerignore` — <https://docs.docker.com/build/concepts/context/>
- [R10] Port publishing — <https://docs.docker.com/engine/network/port-publishing/>
- [R11] Bind mounts — <https://docs.docker.com/engine/storage/bind-mounts/>
- [R12] Storage — <https://docs.docker.com/engine/storage/>
- [R13] Volumes — <https://docs.docker.com/engine/storage/volumes/>

## Git

- [R14] Git reference — <https://git-scm.com/docs>
- [R15] `git add` — <https://git-scm.com/docs/git-add>
- [R16] `git pull` — <https://git-scm.com/docs/git-pull>
- [R17] GNU Coreutils — <https://www.gnu.org/software/coreutils/manual/coreutils.html>
- [R18] `chmod` — <https://www.gnu.org/software/coreutils/manual/html_node/chmod-invocation.html>

## GitHub CLI·GitHub·VS Code

- [R19] GitHub CLI Linux installation — <https://github.com/cli/cli/blob/trunk/docs/install_linux.md>
- [R20] `gh auth login` — <https://cli.github.com/manual/gh_auth_login>
- [R21] `gh auth setup-git` — <https://cli.github.com/manual/gh_auth_setup-git>
- [R22] `gh repo view` — <https://cli.github.com/manual/gh_repo_view>
- [R23] `gh repo clone` — <https://cli.github.com/manual/gh_repo_clone>
- [R24] `gh pr create` — <https://cli.github.com/manual/gh_pr_create>
- [R25] `gh pr status` — <https://cli.github.com/manual/gh_pr_status>
- [R26] `gh pr diff` — <https://cli.github.com/manual/gh_pr_diff>
- [R27] `gh pr checks` — <https://cli.github.com/manual/gh_pr_checks>
- [R28] `gh pr ready` — <https://cli.github.com/manual/gh_pr_ready>
- [R29] `gh pr merge` — <https://cli.github.com/manual/gh_pr_merge>
- [R30] Secret remediation — <https://docs.github.com/en/code-security/tutorials/remediate-leaked-secrets/remediating-a-leaked-secret>
- [R31] Removing sensitive data — <https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository>
- [R32] VS Code source control — <https://code.visualstudio.com/docs/sourcecontrol/overview/>
- [R33] GitHub in VS Code — <https://code.visualstudio.com/docs/sourcecontrol/github>

---

## 최종 완료 정의

> 터미널 기초를 먼저 연습했다.  
> `codyssey-training` Ubuntu 24.04에서 작업했다.  
> Ubuntu의 Docker 명령이 OrbStack Docker Engine에 연결됐다.  
> GitHub CLI로 인증·권한 확인·clone·PR 관리를 수행했다.  
> `feat/e1-1-complete` 한 개 브랜치에서 의미 단위 commit을 작성했다.  
> Draft PR을 만든 뒤 현재 작업 브랜치를 clean clone으로 검증했다.  
> 검증 결과를 같은 PR에 반영하고 Ready 전환 후 병합했다.  
> Default branch에서 최종 빌드와 웹 응답을 확인했다.  
> 평가자는 README와 docs만 보고 같은 절차를 재현할 수 있다.
