# E1-1. AI/SW 개발 워크스테이션 구축 — 초보자 무중단 수행 가이드

> 코디세이 입학연수 · 개발 입문 · 권장 학습시간 40시간  
> 주 실습환경: **macOS + OrbStack + Ubuntu 24.04 LTS + OrbStack Docker**  
> OrbStack Linux machine 이름: **`codyssey-training`**

이 문서는 초보자가 명령을 위에서부터 실행하면서 환경·Git·GitHub·VS Code·Docker 미션을 한 개의 작업 branch와 Pull Request로 완료하도록 구성합니다.

> **터미널 기초 → OrbStack Ubuntu → Docker → GitHub CLI → clone → 작업 branch → `code --remote` → commit·push → Draft PR → 미션 실습 → clean clone → 병합 → 최종 검증**

빠른 진행표: [`docs/beginner-checkpoints.md`](docs/beginner-checkpoints.md)

---

## 0. 문서 사용 규칙

### 0.1 실행 위치

| 표시 | 실행 위치 |
|---|---|
| **[macOS]** | Mac 터미널 |
| **[Ubuntu]** | OrbStack `codyssey-training` 셸 |
| **[VS Code Ubuntu]** | Remote-SSH로 연결된 VS Code 통합 터미널 |
| **[컨테이너]** | Docker 컨테이너 내부 |
| **[확인]** | 상태 확인 명령 |
| **[오류 시]** | 실제 실패했을 때만 실행 |
| **[선택]** | 필수 미션 이후 확장 |

### 0.2 실행 원칙

1. 명령 블록을 한 번에 하나씩 실행합니다.
2. 바로 아래 정상 기준을 확인합니다.
3. `[FAIL]` 또는 오류가 나오면 다음 단계로 넘어가지 않습니다.
4. 오류 메시지를 수정하지 말고 원문 그대로 보존합니다.
5. 현재 branch가 `main`이면 파일을 수정하지 않습니다.
6. `git push --force`, `docker system prune`을 사용하지 않습니다.

### 0.3 단계 중지 조건

- GitHub·Docker Hub 네트워크 연결 실패
- `docker version`, `docker info`, `hello-world` 실패
- GitHub CLI 인증 실패
- 저장소 권한이 `READ`
- 현재 branch가 `main`인데 파일 변경 발생
- VS Code 통합 터미널이 macOS에서 실행됨
- `git diff --cached`에 의도하지 않은 파일 존재
- clean clone 빌드 실패
- PR checks 실패

### 0.4 첫 수행의 Git 구조

```text
main
└── feat/e1-1-complete
    ├── 환경·VS Code 기준선
    ├── 터미널·권한
    ├── Docker 기본 운영
    ├── Dockerfile·포트
    ├── 바인드 마운트
    ├── 볼륨 영속성
    ├── 트러블슈팅·증거
    └── clean clone 검증
```

기존 branch나 PR이 있으면 새로 만들지 않고 재사용합니다.

---

# 목차

1. 완료 기준
2. 전체 수행 순서
3. Mac 터미널 기초
4. OrbStack 점검과 Ubuntu 생성
5. Ubuntu 기본환경과 네트워크
6. OrbStack Docker 연결과 경로 시험
7. GitHub CLI 설치와 인증
8. 저장소 clone과 작업 branch 생성
9. 초기 결과 문서와 점검 스크립트
10. VS Code Remote-SSH를 CLI로 실행
11. Git 반복 절차와 첫 push
12. Draft Pull Request 생성 또는 재사용
13. 터미널·권한 미션
14. Docker 기본 운영
15. Dockerfile 웹 서버
16. 포트 매핑
17. 바인드 마운트
18. Docker 볼륨 영속성
19. 트러블슈팅·증거·스크린샷·보안
20. 중단 후 작업 재개
21. clean clone 사전 검증
22. PR 최종 점검과 병합
23. 병합 후 최종 검증
24. 공용 장비 로그아웃과 안전한 정리
25. 오류 대응표
26. 확장 부록
27. 공식 참고문헌

---

# 1. 완료 기준

Default branch인 `main`에서 다음을 확인할 수 있어야 합니다.

- OrbStack Ubuntu 24.04 `codyssey-training`을 사용했다.
- OrbStack Docker Client와 Server가 연결됐다.
- GitHub CLI 인증과 쓰기 권한을 확인했다.
- 저장소 clone 직후 작업 branch를 만들거나 기존 branch를 재사용했다.
- Mac에서 `code --remote`로 Ubuntu workspace를 열었다.
- VS Code 통합 터미널에서 Ubuntu·셸·경로·Git root·branch를 검증했다.
- 터미널과 권한 실습을 수행했다.
- Docker 이미지·컨테이너·Dockerfile·포트·바인드 마운트·볼륨을 검증했다.
- 의미 단위 commit을 Draft PR에 누적했다.
- clean clone을 통과했다.
- 트러블슈팅을 최소 2건 기록했다.
- token·인증 코드·개인키·학교 내부정보를 저장소와 스크린샷에 노출하지 않았다.
- 병합 후 `scripts/final-check.sh`가 성공했다.

---

# 2. 전체 수행 순서

```text
1. Mac 터미널 기본 명령 연습
2. OrbStack 실행 확인
3. Ubuntu 24.04 codyssey-training 생성 또는 확인
4. Ubuntu 네트워크와 기본 패키지 확인
5. OrbStack Docker 연결과 경로 시험
6. GitHub CLI 설치·인증
7. 저장소 쓰기 권한 확인
8. 저장소 clone
9. main 최신화
10. 기존 local·remote branch 확인 후 feat/e1-1-complete 선택
11. 초기 문서·스크린샷 폴더 확인
12. Ubuntu 사전 점검 스크립트 실행
13. Mac에서 SSH·VS Code CLI 사전 점검
14. code --remote로 Ubuntu workspace 열기
15. VS Code 원격 통합 터미널 검증
16. 첫 commit·push
17. 기존 Draft PR 확인 또는 새 Draft PR 생성
18. 터미널·권한·Docker 미션 수행
19. 트러블슈팅·증거·보안 정리
20. clean clone 검증
21. PR Ready·병합
22. main에서 final-check 실행
23. 공용 장비 로그아웃과 E1-1 전용 자원 정리
```

---

# 3. Mac 터미널 기초

```bash
# [macOS]
pwd
ls
ls -la
mkdir -p ~/codyssey-terminal-practice
cd ~/codyssey-terminal-practice

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

설명할 수 있어야 합니다.

- `pwd`: 현재 경로
- `ls`: 파일 목록
- `cd`: 경로 이동
- `.`: 현재 디렉터리
- `..`: 상위 디렉터리
- `/`로 시작: 절대 경로
- 현재 위치 기준: 상대 경로

---

# 4. OrbStack 점검과 Ubuntu 생성

## 4.1 OrbStack 상태

```bash
# [macOS]
orb version
orb status
orb list
```

정상 기준:

- 버전 출력
- OrbStack 실행 중
- machine 목록 표시

## 4.2 Ubuntu machine 확인 또는 생성

목록에 `codyssey-training`이 있을 때:

```bash
orb info codyssey-training
```

없을 때만 생성합니다.

```bash
orb create ubuntu:noble codyssey-training
```

자원 제한이 필요하면 위 명령 대신 다음 하나만 사용합니다.

```bash
orb create \
  --memory 4G \
  --cpus 2 \
  --disk 32G \
  ubuntu:noble \
  codyssey-training
```

## 4.3 Ubuntu 접속

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
- 사용자와 home 디렉터리 확인

---

# 5. Ubuntu 기본환경과 네트워크

## 5.1 네트워크

```bash
# [Ubuntu]
getent hosts github.com
curl -I https://github.com
```

하나라도 실패하면 다음 단계로 넘어가지 않습니다.

## 5.2 기본 패키지

```bash
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
  tar \
  unzip \
  zip
```

```bash
git --version
curl --version | head -n 1
tar --version | head -n 1
jq --version
```

## 5.3 작업 상위 폴더

```bash
mkdir -p ~/codyssey-training
cd ~/codyssey-training
pwd
```

---

# 6. OrbStack Docker 연결과 경로 시험

## 6.1 Docker 명령

```bash
# [Ubuntu]
command -v docker || true
type -a docker || true
mac which docker || true
```

`docker` 명령이 없을 때만:

```bash
mac link docker
hash -r
command -v docker
```

## 6.2 Engine 연결

```bash
docker version
docker info
docker run --rm hello-world
```

정상 기준:

- Client와 Server 모두 표시
- `docker info` 성공
- `Hello from Docker!` 출력

## 6.3 command link 복구

실제 오류가 있을 때만:

```bash
mac unlink docker
mac link docker
hash -r
exec "$SHELL" -l
```

새 셸에서:

```bash
command -v docker
docker version
docker info
```

## 6.4 Docker 경로 시험

```bash
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

docker run --rm \
  -v "$PWD:/data:ro" \
  alpine \
  cat /data/test.txt
```

두 실행 모두 다음을 출력해야 합니다.

```text
OrbStack path test
```

---

# 7. GitHub CLI 설치와 인증

## 7.1 설치 확인

```bash
command -v gh || true
gh --version || true
```

없을 때만 설치합니다.

```bash
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

## 7.2 브라우저 인증

```bash
gh auth login \
  --hostname github.com \
  --git-protocol https \
  --web \
  --clipboard
```

`unknown flag: --clipboard`일 때:

```bash
gh auth login \
  --hostname github.com \
  --git-protocol https \
  --web
```

```bash
gh auth status --hostname github.com
gh auth setup-git --hostname github.com
gh config get git_protocol
```

`gh auth logout`은 지금 실행하지 않습니다.

---

# 8. 저장소 clone과 작업 branch 생성

## 8.1 쓰기 권한

```bash
gh repo view MetaStudy999/codyssey-training-e1-1 \
  --json nameWithOwner,viewerPermission
```

`ADMIN`, `MAINTAIN`, `WRITE` 중 하나여야 합니다. `READ`이면 중단합니다.

## 8.2 clone

```bash
cd ~/codyssey-training
ls -ld codyssey-training-e1-1 2>/dev/null || true
```

폴더가 없을 때:

```bash
gh repo clone MetaStudy999/codyssey-training-e1-1
cd codyssey-training-e1-1
```

기존 폴더가 있으면 삭제하지 말고 그 안의 작업 상태를 확인합니다.

```bash
cd ~/codyssey-training/codyssey-training-e1-1
git status -sb
git remote -v
```

## 8.3 Git 사용자 정보

```bash
git config --global user.name || true
git config --global user.email || true
```

값이 없을 때:

```bash
read -r -p "Git commit 이름: " GIT_NAME
read -r -p "Git commit 이메일: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
```

## 8.4 기존 local·remote branch 확인 후 전환

```bash
WORK_BRANCH="feat/e1-1-complete"

git switch main
git pull --ff-only origin main
git fetch origin

if git show-ref --verify --quiet "refs/heads/$WORK_BRANCH"
then
  git switch "$WORK_BRANCH"
elif git ls-remote --exit-code --heads origin "$WORK_BRANCH" >/dev/null 2>&1
then
  git switch --track -c "$WORK_BRANCH" "origin/$WORK_BRANCH"
else
  git switch -c "$WORK_BRANCH"
fi
```

```bash
pwd
git status -sb
git branch --show-current
git branch -vv
git remote -v
```

현재 branch는 반드시 `feat/e1-1-complete`여야 합니다.

---

# 9. 초기 결과 문서와 점검 스크립트

## 9.1 폴더 확인

```bash
mkdir -p docs/screenshots/{environment,git,terminal,permissions,docker,port,mount,volume,github,vscode}

for directory in docs/screenshots/{environment,git,terminal,permissions,docker,port,mount,volume,github,vscode}
do
  touch "$directory/.gitkeep"
done

for file in \
  docs/environment.md \
  docs/git-workflow.md \
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

touch .gitignore
printf '\n.env.local\n' >> .gitignore
sort -u .gitignore -o .gitignore

git status -sb
```

## 9.2 Ubuntu 사전 점검

```bash
bash scripts/preflight-ubuntu.sh
```

`[FAIL]`이 하나라도 있으면 해결 후 다시 실행합니다.

## 9.3 점검 스크립트 역할

| 스크립트 | 실행 위치 | 목적 |
|---|---|---|
| `preflight-macos.sh` | Mac | OrbStack·SSH·VS Code CLI·원격 요구사항 |
| `preflight-ubuntu.sh` | Ubuntu | Ubuntu·GitHub CLI·Docker·branch |
| `verify-vscode-remote.sh` | VS Code Ubuntu | OS·셸·경로·Git root·branch |
| `resume-check.sh` | Ubuntu | 작업 재개 상태 |
| `final-check.sh` | main | 최종 build·HTTP·보안 |
| `cleanup-e1-1.sh` | Ubuntu | E1-1 Docker 자원만 정리 |

실행 권한이 없어도 `bash scripts/파일명.sh` 형식으로 실행할 수 있습니다.

---

# 10. VS Code Remote-SSH를 CLI로 실행

상세 가이드: [`docs/vscode-orbstack-remote-ssh.md`](docs/vscode-orbstack-remote-ssh.md)

## 10.1 Mac으로 돌아가기

```bash
# [Ubuntu]
exit
```

## 10.2 SSH 확인

```bash
# [macOS]
orb status
orb info codyssey-training
ssh codyssey-training@orb
```

Ubuntu가 열리면 `exit`로 다시 Mac으로 돌아옵니다.

## 10.3 관리자 권한 없이 VS Code CLI 찾기

```bash
# [macOS]
CODE_BIN="$(command -v code 2>/dev/null || true)"

if [ -z "$CODE_BIN" ]; then
  for candidate in \
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
    "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
  do
    if [ -x "$candidate" ]; then
      CODE_BIN="$candidate"
      break
    fi
  done
fi

if [ -z "$CODE_BIN" ]; then
  echo "[FAIL] VS Code CLI를 찾지 못했습니다."
  exit 1
fi

"$CODE_BIN" --version
"$CODE_BIN" --help | grep -- '--remote'
```

`code`를 PATH에 설치할 권한이 없어도 앱 내부 CLI를 직접 사용할 수 있습니다.

## 10.4 Remote - SSH 확장

```bash
"$CODE_BIN" --list-extensions \
  | grep -Fx 'ms-vscode-remote.remote-ssh' || \
  "$CODE_BIN" --install-extension ms-vscode-remote.remote-ssh
```

## 10.5 Mac 사전 점검

```bash
# Mac에서 Ubuntu 저장소의 스크립트 경로를 직접 실행할 수 없으므로
# 저장소를 Mac에도 clone하지 않았다면 아래 수동 명령을 사용합니다.
command -v orb
command -v ssh
orb status
orb info codyssey-training

ssh codyssey-training@orb '
  command -v bash &&
  command -v tar &&
  { command -v curl || command -v wget; } &&
  test -w "$HOME" &&
  df -h "$HOME"
'
```

저장소를 Mac에도 별도로 clone한 경우에는 다음을 사용할 수 있습니다.

```bash
bash scripts/preflight-macos.sh
```

## 10.6 원격 경로 계산과 실행

```bash
ssh codyssey-training@orb \
  'test -d "$HOME/codyssey-training/codyssey-training-e1-1" && echo "REMOTE_DIR_OK"'

REMOTE_DIR="$(ssh codyssey-training@orb \
  'printf "%s/codyssey-training/codyssey-training-e1-1" "$HOME"')"

printf 'REMOTE_DIR=%s\n' "$REMOTE_DIR"

"$CODE_BIN" --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$REMOTE_DIR/"
```

정상 기준:

- 새 VS Code 창
- 왼쪽 아래 SSH Remote indicator
- Explorer 최상단 `codyssey-training-e1-1`

CLI가 실패할 때만 GUI를 사용합니다.

```text
Shift + Command + P
→ Remote-SSH: Connect to Host...
→ codyssey-training@orb
→ File → Open Folder...
→ ~/codyssey-training/codyssey-training-e1-1
```

## 10.7 원격 터미널 검증

```text
Terminal → New Terminal
```

```bash
# [VS Code Ubuntu]
bash scripts/verify-vscode-remote.sh
```

정상 기준:

```text
[PASS] Ubuntu 24.04 noble
[PASS] 현재 디렉터리
[PASS] Git 최상위 경로
[PASS] 현재 브랜치: feat/e1-1-complete
[PASS] VS Code Remote-SSH 터미널 검증 완료
```

`/Users/...` 또는 `main`이 나오면 실패입니다.

---

# 11. Git 반복 절차와 첫 push

모든 작업 단위에서 다음을 반복합니다.

```text
파일 수정
→ git status -sb
→ git diff
→ 필요한 파일만 git add
→ git diff --cached
→ git commit
→ git push
```

## 11.1 환경 기준선 기록

```bash
# [VS Code Ubuntu]
{
  echo "# 실행 환경"
  echo
  echo "## Ubuntu와 VS Code Remote-SSH"
  echo '```text'
  cat /etc/os-release
  uname -a
  printf 'SHELL=%s\n' "$SHELL"
  ps -p $$ -o comm=
  pwd
  git branch --show-current
  git --version
  gh --version | head -n 1
  docker --version
  echo '```'
  echo
  echo "- Remote-SSH host: codyssey-training@orb"
  echo "- Docker Engine 연결: 성공"
  echo "- hello-world: 성공"
} > docs/environment.md
```

## 11.2 첫 commit

```bash
git status -sb
git diff

git add \
  .gitignore \
  .vscode \
  README.md \
  E1-1-training.md \
  scripts \
  docs

git diff --cached --stat
git diff --cached
git commit -m "Docs: initialize E1-1 environment and evidence structure"
```

## 11.3 첫 push

```bash
git push -u origin feat/e1-1-complete
```

강제 push는 사용하지 않습니다.

---

# 12. Draft Pull Request 생성 또는 재사용

## 12.1 기존 PR 확인

```bash
WORK_BRANCH="feat/e1-1-complete"

gh pr list \
  --head "$WORK_BRANCH" \
  --base main \
  --state open
```

기존 PR이 표시되면 새 PR을 만들지 않습니다. 같은 branch에 계속 push합니다.

## 12.2 기존 PR이 없을 때만 생성

```bash
cat > /tmp/e1-1-pr-body.md <<'EOF'
## 작업 목적

OrbStack Ubuntu 24.04와 VS Code Remote-SSH 환경에서 E1-1 미션을 수행하고 검증합니다.

## 진행 현황

- [x] OrbStack Ubuntu
- [x] Docker Engine 연결
- [x] GitHub CLI 인증
- [x] 작업 branch
- [x] VS Code Remote-SSH
- [ ] 터미널·권한
- [ ] Docker 기본 운영
- [ ] Dockerfile·포트
- [ ] 바인드 마운트
- [ ] 볼륨 영속성
- [ ] clean clone
- [ ] 최종 보안 점검

## 증거 위치

- docs/environment.md
- docs/test-results.md
- docs/troubleshooting.md
- docs/screenshots/
EOF

gh pr create \
  --draft \
  --base main \
  --head feat/e1-1-complete \
  --title "Feat: complete E1-1 workstation mission" \
  --body-file /tmp/e1-1-pr-body.md
```

```bash
PR_NUMBER="$(gh pr view --json number --jq '.number')"
echo "PR 번호: $PR_NUMBER"
```

---

# 13. 터미널·권한 미션

```bash
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

권한:

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

```bash
cd ~/codyssey-training/codyssey-training-e1-1
git add docs/terminal-and-permissions.md practice
git diff --cached
git commit -m "Docs: record terminal and permission practice"
git push
```

---

# 14. Docker 기본 운영

```bash
docker --version
docker version
docker info
docker images
docker ps
docker ps -a
docker stats --no-stream
```

```bash
docker rm -f e1-1-hello 2>/dev/null || true
docker run --name e1-1-hello hello-world
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

컨테이너 내부:

```bash
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

Ubuntu로 돌아와:

```bash
docker stop e1-1-ubuntu
docker start e1-1-ubuntu
docker rm -f e1-1-ubuntu

git add docs/docker-operations.md docs/screenshots/docker
git diff --cached
git commit -m "Docs: record Docker image and container operations"
git push
```

---

# 15. Dockerfile 웹 서버

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
.vscode
docs
practice
bind-test
*.log
EOF

docker build -t codyssey-e1-1-web:1.0 .
docker image inspect codyssey-e1-1-web:1.0
```

```bash
git add Dockerfile .dockerignore site/index.html
git diff --cached
git commit -m "Feat: add NGINX Dockerfile and static page"
git push
```

---

# 16. 포트 매핑

## 16.1 포트 선택

```bash
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
  echo "사용 가능한 포트가 없습니다."
  exit 1
fi

printf 'HOST_PORT=%s\n' "$HOST_PORT" > .env.local
source .env.local
echo "사용 포트: $HOST_PORT"
```

새 터미널에서는 다시 실행합니다.

```bash
source .env.local
```

## 16.2 실행

```bash
docker rm -f e1-1-web 2>/dev/null || true

docker run -d \
  --name e1-1-web \
  -p "${HOST_PORT}:80" \
  codyssey-e1-1-web:1.0

docker ps
docker logs e1-1-web
docker port e1-1-web
curl "http://localhost:${HOST_PORT}"
```

Mac 브라우저에서 `http://localhost:선택한포트`를 엽니다.

```bash
git add docs/test-results.md docs/screenshots/port
git diff --cached
git commit -m "Test: verify Docker port mapping"
git push
```

---

# 17. 바인드 마운트

```bash
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

```bash
git add bind-test/index.html docs/bind-mount.md docs/screenshots/mount
git diff --cached
git commit -m "Test: verify bind mount file updates"
git push
```

---

# 18. Docker 볼륨 영속성

```bash
docker volume create e1-1-data

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

마지막 출력:

```text
persistent data
```

```bash
git add docs/volume-persistence.md docs/screenshots/volume
git diff --cached
git commit -m "Test: verify Docker volume persistence"
git push
```

---

# 19. 트러블슈팅·증거·스크린샷·보안

## 19.1 트러블슈팅 최소 2건

`docs/troubleshooting.md`:

```markdown
## 문제 ID: TS-01

- 발생 환경:
- 실행 위치: macOS / Ubuntu / VS Code Ubuntu / 컨테이너
- 작업 branch:
- 실행 명령:
- 오류 메시지 원문:
- 재현 방법:
- 원인:
- 해결 또는 대안:
- 해결 검증:
- 재발 방지:
- 공식 참고문서:
```

## 19.2 스크린샷 파일명

규칙: [`docs/screenshots/README.md`](docs/screenshots/README.md)

```text
vscode/01-remote-ssh-status.png
vscode/02-ubuntu-shell-path.png
vscode/03-git-branch.png
docker/01-docker-version.png
port/01-browser-response.png
mount/01-bind-before.png
mount/02-bind-after.png
volume/01-volume-persistence.png
```

촬영 전 token·인증 코드·개인키·학교 내부정보·개인정보를 제거합니다.

## 19.3 보안 점검

```bash
git status -sb
git diff
git diff --cached

git grep -n -i -E 'token|password|secret|private.?key' || true
find . -maxdepth 5 -type f \
  \( -name '.env' -o -name '.env.local' -o -name '*.pem' -o -name 'id_rsa' -o -name 'id_ed25519' -o -name 'hosts.yml' \)
```

저장소에 포함하지 않습니다.

- GitHub token·인증 코드
- `~/.config/gh/hosts.yml`
- `~/.orbstack/ssh/id_ed25519`
- `~/.ssh/config` 전체
- `.env.local`
- 학교 내부 민감정보

```bash
git add README.md docs scripts
git diff --cached
git commit -m "Docs: add troubleshooting and evidence traceability"
git push
```

---

# 20. 중단 후 작업 재개

Mac:

```bash
orb status
ssh codyssey-training@orb
```

Ubuntu 또는 VS Code 원격 터미널:

```bash
cd ~/codyssey-training/codyssey-training-e1-1
bash scripts/resume-check.sh
```

터미널을 닫으면 다음 셸 변수는 사라집니다.

```text
CODE_BIN
REMOTE_DIR
WORK_BRANCH
HOST_PORT
PR_NUMBER
SOURCE_DIR
CURRENT_BRANCH
RETEST_DIR
```

필요할 때 다시 계산합니다. `.env.local`이 있으면:

```bash
source .env.local
```

스크립트에서 설정한 변수는 부모 셸에 자동으로 남지 않습니다.

---

# 21. clean clone 사전 검증

PR을 Ready로 바꾸기 전에 수행합니다.

```bash
git status -sb
git push

SOURCE_DIR="$PWD"
CURRENT_BRANCH="$(git branch --show-current)"
RETEST_DIR="$HOME/codyssey-reproduction/e1-1-$(date +%Y%m%d-%H%M%S)"

printf 'SOURCE_DIR=%s\n' "$SOURCE_DIR"
printf 'CURRENT_BRANCH=%s\n' "$CURRENT_BRANCH"
printf 'RETEST_DIR=%s\n' "$RETEST_DIR"
```

`CURRENT_BRANCH`는 반드시 `feat/e1-1-complete`여야 합니다.

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

원본으로 돌아와 기록합니다.

```bash
cd "$SOURCE_DIR"

cat >> docs/test-results.md <<EOF

## Clean clone 검증

- 브랜치: $CURRENT_BRANCH
- 폴더: $RETEST_DIR
- 포트: $RETEST_PORT
- Docker build: 성공
- HTTP 응답: 성공
EOF

git add docs/test-results.md
git diff --cached
git commit -m "Test: record clean clone verification"
git push
```

---

# 22. PR 최종 점검과 병합

```bash
PR_NUMBER="$(gh pr view --json number --jq '.number')"

git status -sb
gh pr status --conflict-status
gh pr view "$PR_NUMBER"
gh pr diff "$PR_NUMBER" --name-only
gh pr diff "$PR_NUMBER"
```

확인:

- Remote-SSH 증거 존재
- `.env.local`, token, 개인키 없음
- Dockerfile, `site/`, `bind-test/`, `docs/`, `scripts/` 존재
- clean clone 결과 존재

```bash
gh pr checks "$PR_NUMBER"
```

| 상태 | 조치 |
|---|---|
| 검사 통과 | 계속 |
| 검사 없음 | `CI 없음, 수동 clean clone 완료` 기록 |
| 검사 실패 | 병합 금지 |
| 검사 대기 | 완료까지 대기 |

```bash
gh pr ready "$PR_NUMBER"
gh pr view "$PR_NUMBER"
gh pr merge "$PR_NUMBER" --merge --delete-branch
```

`--admin`으로 정책을 우회하지 않습니다.

---

# 23. 병합 후 최종 검증

```bash
git switch main
git pull --ff-only origin main
git fetch --prune

git status -sb
git log --oneline --graph --decorate --all -20
gh pr list --state merged --limit 10
```

최종 자동 검증:

```bash
bash scripts/final-check.sh
```

모든 항목이 `[PASS]`여야 완료입니다. 결과를 `docs/test-results.md`에 기록합니다.

---

# 24. 공용 장비 로그아웃과 안전한 정리

## 24.1 로그아웃

모든 작업과 제출 확인 후 학교 공용 장비에서만:

```bash
gh auth status --hostname github.com
gh auth logout --hostname github.com
gh auth status --hostname github.com || true
```

## 24.2 E1-1 자원만 정리

증거와 평가 확인이 끝난 뒤:

```bash
bash scripts/cleanup-e1-1.sh
```

이미지까지 제거하려면:

```bash
bash scripts/cleanup-e1-1.sh --images
```

다음은 사용하지 않습니다.

```bash
docker system prune
docker system prune -a
```

---

# 25. 오류 대응표

| 증상 | 확인 | 조치 |
|---|---|---|
| machine 없음 | `orb list` | `orb create ubuntu:noble codyssey-training` |
| GitHub 접속 실패 | `getent hosts`, `curl -I` | 네트워크 해결 |
| Docker 명령 없음 | `mac which docker` | `mac link docker` |
| Docker Server 없음 | `docker info` | OrbStack·command link 확인 |
| `code: command not found` | 앱 설치 위치 | `CODE_BIN`으로 앱 내부 CLI 사용 |
| `--remote` 없음 | `code --version`, `type -a code` | 올바른 VS Code CLI 선택 |
| SSH 실패 | `ssh codyssey-training@orb` | `orb status`, `orb info`, `ssh -G` |
| SSH 비밀번호 요구 | host 확인 | 내장 SSH 사용, 별도 sshd 설치 금지 |
| Remote-SSH 확장 없음 | `--list-extensions` | extension 설치 |
| VS Code Server 실패 | Remote - SSH Output | `tar`, `curl/wget`, HOME 쓰기, 디스크 확인 |
| `/Users/...` 열림 | `pwd` | `--remote`와 Ubuntu 절대 경로 사용 |
| 터미널이 home에서 시작 | `pwd` | 저장소 folder를 다시 열고 새 터미널 |
| branch가 `main` | `git branch --show-current` | 작업 branch 전환 후 수정 |
| local branch 중복 | `show-ref` | 기존 local branch 재사용 |
| remote branch만 존재 | `ls-remote` | tracking branch 생성 |
| PR 중복 | `gh pr list --head` | 기존 PR 재사용 |
| `unknown flag: --clipboard` | `gh --version` | 옵션 제외 |
| push 권한 없음 | `viewerPermission` | WRITE 이상 요청 |
| clone 폴더 중복 | 기존 폴더 `git status` | 작업 보존, 삭제 금지 |
| 포트 충돌 | `mac lsof`, `docker ps` | 다른 포트 선택 |
| 셸 변수 사라짐 | 새 터미널 여부 | 변수 재계산, `.env.local` source |
| chmod가 Git에 안 보임 | `ls -l` | 문서·스크린샷으로 증명 |
| PR checks 없음 | `gh pr checks` | CI 없음·수동 검증 기록 |
| push 거절 | `git fetch`, `branch -vv` | force push 금지 |

---

# 26. 확장 부록

## 26.1 `code .`의 위치

```bash
command -v code || true
code .
```

이 명령은 Mac VS Code를 여는 보조 수단일 수 있지만 다음을 보장하지 않습니다.

- Remote-SSH 창
- Ubuntu 통합 터미널
- Ubuntu workspace 경로

필수 경로는 10장의 `code --remote`입니다.

## 26.2 다른 `git add`

```bash
git add -p E1-1-training.md
git add -u
git add -A
```

## 26.3 다른 병합 방식

```bash
gh pr merge "$PR_NUMBER" --squash --delete-branch
gh pr merge "$PR_NUMBER" --rebase --delete-branch
```

---

# 27. 공식 참고문헌

> 확인일: **2026-08-02**

## OrbStack

- [R1] OrbStack — <https://docs.orbstack.dev/>
- [R2] Linux machines — <https://docs.orbstack.dev/machines/>
- [R3] Commands — <https://docs.orbstack.dev/machines/commands>
- [R4] SSH access — <https://docs.orbstack.dev/machines/ssh>
- [R5] Linux distributions — <https://docs.orbstack.dev/machines/distros>
- [R6] File sharing — <https://docs.orbstack.dev/machines/file-sharing>
- [R7] Docker containers — <https://docs.orbstack.dev/docker/>

## VS Code

- [R8] Remote Development using SSH — <https://code.visualstudio.com/docs/remote/ssh>
- [R9] Remote-SSH tutorial — <https://code.visualstudio.com/docs/remote/ssh-tutorial>
- [R10] Command line — <https://code.visualstudio.com/docs/configure/command-line>
- [R11] macOS setup — <https://code.visualstudio.com/docs/setup/mac>
- [R12] Terminal basics — <https://code.visualstudio.com/docs/terminal/basics>

## Docker

- [R13] Docker reference — <https://docs.docker.com/reference/>
- [R14] Dockerfile reference — <https://docs.docker.com/reference/dockerfile>
- [R15] Port publishing — <https://docs.docker.com/engine/network/port-publishing/>
- [R16] Bind mounts — <https://docs.docker.com/engine/storage/bind-mounts/>
- [R17] Volumes — <https://docs.docker.com/engine/storage/volumes/>

## Git·GitHub CLI

- [R18] Git reference — <https://git-scm.com/docs>
- [R19] GitHub CLI Linux installation — <https://github.com/cli/cli/blob/trunk/docs/install_linux.md>
- [R20] `gh auth login` — <https://cli.github.com/manual/gh_auth_login>
- [R21] `gh repo clone` — <https://cli.github.com/manual/gh_repo_clone>
- [R22] `gh pr create` — <https://cli.github.com/manual/gh_pr_create>
- [R23] `gh pr checks` — <https://cli.github.com/manual/gh_pr_checks>
- [R24] `gh pr merge` — <https://cli.github.com/manual/gh_pr_merge>

---

## 최종 완료 정의

> 저장소를 clone한 직후 기존 local·remote branch를 확인하고 작업 branch를 선택했다.  
> Mac에서 `code --remote`와 Ubuntu 절대 경로로 Remote-SSH workspace를 열었다.  
> 원격 통합 터미널에서 Ubuntu 24.04, 셸, 저장소 경로, 작업 branch를 검증했다.  
> GitHub CLI와 Docker 미션을 수행하고 증거를 기록했다.  
> 중단 후 재개와 clean clone을 검증했다.  
> PR을 병합한 뒤 `scripts/final-check.sh`를 통과했다.  
> 평가자는 README와 docs만 보고 동일한 절차를 재현할 수 있다.
