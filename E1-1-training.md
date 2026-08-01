# E1-1. AI/SW 개발 워크스테이션 구축 — 초보자 무중단 수행 가이드

> 코디세이 입학연수 · 개발 입문 · 권장 학습시간 40시간  
> 주 실습환경: **macOS + OrbStack + Ubuntu 24.04 LTS + OrbStack Docker**  
> OrbStack Linux machine 이름: **`codyssey-training`**

이 문서는 초보자가 명령을 위에서부터 실행하면서 환경·Git·GitHub·VS Code·Docker 미션을 한 개의 작업 브랜치와 Pull Request로 완료하도록 구성합니다.

> **터미널 기초 → OrbStack Ubuntu → Docker 연결 → GitHub CLI → clone → 작업 브랜치 → VS Code Remote-SSH → commit·push → Draft PR → Docker 실습 → clean clone → 병합**

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

### 0.2 단계 중지 원칙

다음 조건을 통과하지 못하면 다음 단계로 넘어가지 않습니다.

- GitHub·Docker Hub 네트워크 연결 실패
- `docker version`, `docker info`, `hello-world` 실패
- GitHub CLI 인증 실패
- 저장소 권한이 `READ`뿐임
- 현재 브랜치가 `main`인데 파일 변경이 발생함
- VS Code 통합 터미널이 macOS에서 실행됨
- `git diff --cached`에 의도하지 않은 파일이 있음
- clean clone 빌드 실패
- PR checks 실패

### 0.3 한 개 브랜치·한 개 PR

첫 수행에서는 다음 구조만 사용합니다.

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

모든 파일 수정은 `feat/e1-1-complete`에서 수행합니다.

---

# 목차

1. 완료 기준
2. 전체 수행 순서
3. Mac 터미널 기초
4. OrbStack 점검과 Ubuntu 생성
5. Ubuntu 기본환경과 네트워크
6. OrbStack Docker 연결과 경로 시험
7. GitHub CLI 설치와 인증
8. 저장소 clone과 작업 브랜치 생성
9. 초기 결과 문서 준비
10. VS Code Remote-SSH 연결
11. Git 반복 절차와 첫 push
12. Draft Pull Request 생성
13. 터미널·권한 미션
14. Docker 기본 운영
15. Dockerfile 웹 서버
16. 포트 매핑
17. 바인드 마운트
18. Docker 볼륨 영속성
19. 트러블슈팅·증거·보안
20. clean clone 사전 검증
21. PR 최종 점검과 병합
22. 병합 후 최종 검증
23. 공용 장비 로그아웃
24. 오류 대응표
25. 확장 부록
26. 공식 참고문헌

---

# 1. 완료 기준

Default branch인 `main`에서 다음을 확인할 수 있어야 합니다.

- OrbStack Ubuntu 24.04 `codyssey-training`을 사용했다.
- VS Code Remote-SSH로 `codyssey-training@orb`에 연결했다.
- VS Code 통합 터미널이 Ubuntu 셸과 저장소 루트에서 시작한다.
- 터미널로 파일·디렉터리를 생성·복사·이동·삭제했다.
- 파일과 디렉터리 권한을 확인하고 변경했다.
- Ubuntu에서 OrbStack Docker Engine을 사용했다.
- Docker 이미지와 컨테이너를 실행·조회·중지·삭제했다.
- `Dockerfile`로 NGINX 이미지를 빌드했다.
- 포트 매핑으로 Mac 브라우저에서 웹 페이지를 확인했다.
- 바인드 마운트와 Docker 볼륨 영속성을 검증했다.
- GitHub CLI로 인증·clone·PR 관리를 수행했다.
- `feat/e1-1-complete`에서 의미 단위 commit을 작성했다.
- clean clone을 PR 병합 전에 통과했다.
- 트러블슈팅을 최소 2건 기록했다.
- 토큰·비밀번호·개인키를 저장소와 스크린샷에 노출하지 않았다.

---

# 2. 전체 수행 순서

```text
1. Mac 터미널 기본 명령 연습
2. OrbStack 실행 확인
3. Ubuntu 24.04 codyssey-training 생성 또는 확인
4. Ubuntu 네트워크와 기본 패키지 점검
5. OrbStack Docker 연결과 경로 시험
6. GitHub CLI 설치·인증
7. 저장소 쓰기 권한 확인
8. 저장소 clone
9. main 최신화
10. feat/e1-1-complete 작업 브랜치 생성
11. 초기 문서·스크린샷 폴더 준비
12. Mac에서 OrbStack SSH 사전 확인
13. VS Code Remote-SSH로 codyssey-training@orb 연결
14. Ubuntu 저장소 폴더 열기
15. VS Code 통합 터미널 OS·셸·경로·브랜치 검증
16. 첫 commit·push
17. Draft PR 생성
18. 터미널·권한·Docker 미션 수행
19. 트러블슈팅·증거 정리
20. 현재 작업 브랜치를 clean clone으로 검증
21. PR Ready·병합
22. main에서 최종 빌드와 웹 응답 확인
23. 공용 장비에서만 마지막에 로그아웃
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
- `/`로 시작하는 경로: 절대 경로
- 현재 위치를 기준으로 하는 경로: 상대 경로

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

- 버전이 출력된다.
- OrbStack이 실행 중이다.
- machine 목록이 표시된다.

## 4.2 Ubuntu machine 확인

목록에 `codyssey-training`이 있을 때만 다음을 실행합니다.

```bash
# [macOS]
orb info codyssey-training
```

없으면 생성합니다.

```bash
# [macOS]
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

## 4.3 대화형 셸 접속

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
- 현재 사용자와 홈 디렉터리 확인

> 일반 대화형 실습에는 `orb -m codyssey-training`을 사용합니다. VS Code 연결에는 10장의 OrbStack 내장 SSH를 사용합니다.

---

# 5. Ubuntu 기본환경과 네트워크

## 5.1 네트워크 확인

```bash
# [Ubuntu]
getent hosts github.com
curl -I https://github.com
```

두 명령 중 하나라도 실패하면 다음 단계로 넘어가지 않습니다.

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
  unzip \
  zip
```

```bash
# [확인]
git --version
curl --version | head -n 1
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

## 6.1 Docker 명령 확인

```bash
# [Ubuntu]
command -v docker || true
type -a docker || true
mac which docker || true
```

`docker` 명령이 없을 때만 실행합니다.

```bash
# [오류 시]
mac link docker
hash -r
command -v docker
```

## 6.2 Engine 확인

```bash
docker version
docker info
docker run --rm hello-world
```

정상 기준:

- Client와 Server가 모두 표시된다.
- `docker info`가 Engine 정보를 반환한다.
- `Hello from Docker!`가 출력된다.

## 6.3 command link 복구

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

## 6.4 Docker 경로 사전 시험

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

두 실행에서 모두 다음이 출력되어야 합니다.

```text
OrbStack path test
```

---

# 7. GitHub CLI 설치와 인증

## 7.1 설치

```bash
# [Ubuntu]
command -v gh || true
gh --version || true
```

버전이 없을 때만 설치합니다.

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

`unknown flag: --clipboard`가 나오면 `--clipboard`를 제외하고 다시 실행합니다.

```bash
gh auth login \
  --hostname github.com \
  --git-protocol https \
  --web
```

브라우저가 자동으로 열리지 않으면 터미널에 표시된 URL을 Mac 브라우저에서 열고 일회용 코드를 입력합니다.

```bash
# [확인]
gh auth status --hostname github.com
gh auth setup-git --hostname github.com
gh config get git_protocol
```

`gh auth logout`은 지금 실행하지 않습니다.

---

# 8. 저장소 clone과 작업 브랜치 생성

## 8.1 쓰기 권한 확인

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

폴더가 없을 때 실행합니다.

```bash
gh repo clone MetaStudy999/codyssey-training-e1-1
cd codyssey-training-e1-1
```

기존 폴더가 있으면 바로 삭제하지 말고 기존 작업 여부를 확인합니다.

## 8.3 Git 사용자 정보

```bash
git config --global user.name || true
git config --global user.email || true
```

값이 없으면 입력합니다.

```bash
read -r -p "Git commit 이름: " GIT_NAME
read -r -p "Git commit 이메일: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
```

## 8.4 파일 수정 전 브랜치 생성

```bash
WORK_BRANCH="feat/e1-1-complete"

git switch main
git pull --ff-only origin main
git switch -c "$WORK_BRANCH"
```

같은 로컬 브랜치가 이미 있으면:

```bash
# [오류 시]
git switch feat/e1-1-complete
```

```bash
# [확인]
pwd
git status -sb
git branch --show-current
git remote -v
```

현재 브랜치는 반드시 `feat/e1-1-complete`여야 합니다.

---

# 9. 초기 결과 문서 준비

```bash
# [Ubuntu: 작업 브랜치]
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

빈 스크린샷 폴더는 `.gitkeep`으로 추적합니다.

---

# 10. VS Code Remote-SSH 연결

> 이 단계는 필수입니다. Ubuntu 안에서 `code .`를 실행하는 것만으로는 VS Code 통합 터미널이 Ubuntu에서 실행된다는 사실을 보장하지 않습니다.

상세 절차: [`docs/vscode-orbstack-remote-ssh.md`](docs/vscode-orbstack-remote-ssh.md)

## 10.1 OrbStack SSH의 역할

OrbStack에는 모든 Linux machine에 접근하는 SSH 서버가 내장되어 있습니다.

- Mac의 SSH 설정에 `orb` 호스트가 자동 등록됩니다.
- 특정 machine은 `ssh machine@orb` 형식으로 선택합니다.
- 비밀번호 인증은 비활성화되어 있습니다.
- OrbStack 전용 키 인증을 사용합니다.
- Ubuntu에 `openssh-server`를 설치하거나 `sshd_config`를 수정하지 않습니다.
- 일반 대화형 셸은 `orb -m codyssey-training`, VS Code 같은 외부 도구는 SSH를 사용합니다.

## 10.2 Mac 터미널에서 SSH 사전 검증

Ubuntu 셸에서 나와 Mac 터미널로 돌아갑니다.

```bash
# [Ubuntu → macOS]
exit
```

```bash
# [macOS]
orb status
orb info codyssey-training
ssh codyssey-training@orb
```

SSH 접속 후:

```bash
# [Ubuntu via SSH]
hostname
cat /etc/os-release
whoami
printf 'SHELL=%s\n' "$SHELL"
pwd
exit
```

정상 기준:

- Ubuntu 24.04가 표시된다.
- 비밀번호용 SSH 서버를 별도로 설치하지 않고 접속된다.
- `exit` 후 Mac으로 돌아온다.

SSH가 실패하면 다음 단계로 넘어가지 않습니다.

```bash
# [macOS: 오류 시]
ssh -G codyssey-training@orb | head -n 30
orb ssh
```

## 10.3 Mac VS Code에 Remote - SSH 설치

VS Code Extensions에서 다음 확장을 설치합니다.

```text
Remote - SSH
확장 ID: ms-vscode-remote.remote-ssh
```

이 저장소의 `.vscode/extensions.json`에도 권장 확장으로 등록되어 있습니다.

## 10.4 VS Code에서 연결

1. `Shift + Command + P`
2. `Remote-SSH: Connect to Host...`
3. 다음 대상을 입력 또는 선택

```text
codyssey-training@orb
```

4. 플랫폼을 묻는 경우 `Linux` 선택
5. VS Code Server 설치 완료까지 대기
6. 왼쪽 아래 상태 표시줄에 SSH 원격 연결 표시 확인

연결 로그:

```text
View → Output → Remote - SSH
```

## 10.5 Ubuntu 저장소 폴더 열기

Remote-SSH 창에서:

```text
File → Open Folder...
```

다음 폴더를 엽니다.

```text
~/codyssey-training/codyssey-training-e1-1
```

## 10.6 새 통합 터미널 검증

Remote-SSH 창에서 새 터미널을 엽니다.

```text
Terminal → New Terminal
```

```bash
# [VS Code Ubuntu]
hostname
cat /etc/os-release | grep -E 'PRETTY_NAME|VERSION_CODENAME'
printf 'SHELL=%s\n' "$SHELL"
ps -p $$ -o comm=
pwd
git rev-parse --show-toplevel
git branch --show-current
git status -sb
```

정상 기준:

| 항목 | 정상 결과 |
|---|---|
| 운영체제 | Ubuntu 24.04 |
| 셸 | `bash` 또는 Ubuntu에 설정된 셸 |
| `pwd` | `~/codyssey-training/codyssey-training-e1-1` |
| Git 최상위 경로 | 같은 저장소 경로 |
| 현재 브랜치 | `feat/e1-1-complete` |
| VS Code 상태 표시줄 | SSH 원격 연결 표시 |

다음은 실패입니다.

- 경로가 `/Users/...`
- 셸이 Mac 로컬 `zsh`이고 원격 표시가 없음
- `git rev-parse`가 저장소가 아니라고 출력
- 현재 브랜치가 `main`

## 10.7 저장소 터미널 설정

`.vscode/settings.json`에는 다음이 설정되어 있습니다.

```json
{
  "terminal.integrated.cwd": "${workspaceFolder}",
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.splitCwd": "workspaceRoot"
}
```

따라서 Remote-SSH 창의 새 터미널은 Bash와 workspace 루트에서 시작해야 합니다.

> Remote-SSH 창에서도 `Terminal: Create New Integrated Terminal (Local)`을 실행하면 Mac 로컬 터미널이 열릴 수 있습니다. 이 미션에서는 사용하지 않습니다.

## 10.8 VS Code 증거 기록

다음을 `docs/environment.md`와 `docs/screenshots/vscode/`에 기록합니다.

- Remote-SSH 상태 표시줄
- Ubuntu 버전
- `$SHELL`과 실제 셸 프로세스
- `pwd`
- Git 최상위 경로
- 현재 브랜치

---

# 11. Git 반복 절차와 첫 push

모든 작업 단위에서 반복합니다.

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
  docs/environment.md \
  docs/git-workflow.md \
  docs/terminal-and-permissions.md \
  docs/docker-operations.md \
  docs/bind-mount.md \
  docs/volume-persistence.md \
  docs/troubleshooting.md \
  docs/test-results.md \
  docs/requirement-traceability.md \
  docs/screenshots

git diff --cached --stat
git diff --cached
git commit -m "Docs: initialize E1-1 environment and evidence structure"
```

## 11.3 첫 push

```bash
git push -u origin feat/e1-1-complete
```

```bash
# [확인]
git status -sb
git branch -vv
```

강제 push는 사용하지 않습니다.

---

# 12. Draft Pull Request 생성

```bash
cat > /tmp/e1-1-pr-body.md <<'EOF'
## 작업 목적

OrbStack Ubuntu 24.04와 VS Code Remote-SSH 환경에서 E1-1 미션을 수행하고 검증합니다.

## 진행 현황

- [x] OrbStack Ubuntu
- [x] Docker Engine 연결
- [x] GitHub CLI 인증
- [x] 작업 브랜치
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
# [VS Code Ubuntu]
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

`644 → 600`은 Git diff에 표시되지 않을 수 있으므로 `ls -l` 출력과 문서로 증명합니다.

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
# [VS Code Ubuntu]
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

```bash
# [컨테이너]
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

```bash
# [VS Code Ubuntu]
docker stop e1-1-ubuntu
docker start e1-1-ubuntu
docker rm -f e1-1-ubuntu
```

```bash
git add docs/docker-operations.md docs/screenshots/docker
git diff --cached
git commit -m "Docs: record Docker image and container operations"
git push
```

---

# 15. Dockerfile 웹 서버

```bash
# [VS Code Ubuntu: 저장소 루트]
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

## 16.1 사용 가능한 포트 선택

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
  echo "8080, 8081, 18080 포트를 사용할 수 없습니다."
  exit 1
fi

printf 'HOST_PORT=%s\n' "$HOST_PORT" > .env.local
source .env.local
echo "$HOST_PORT"
```

## 16.2 실행과 검증

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

파일을 변경합니다.

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

마지막 출력은 `persistent data`여야 합니다.

```bash
git add docs/volume-persistence.md docs/screenshots/volume
git diff --cached
git commit -m "Test: verify Docker volume persistence"
git push
```

---

# 19. 트러블슈팅·증거·보안

## 19.1 최소 2건 기록

`docs/troubleshooting.md` 형식:

```markdown
## 문제 ID: TS-01

- 발생 환경:
- 실행 위치: macOS / Ubuntu / VS Code Ubuntu / 컨테이너
- 작업 브랜치:
- 실행 명령:
- 오류 메시지 원문:
- 재현 방법:
- 원인:
- 해결 또는 대안:
- 해결 검증:
- 재발 방지:
- 공식 참고문서:
```

VS Code 관련 오류도 기록 대상입니다.

- `ssh codyssey-training@orb` 실패
- Remote-SSH 연결 실패
- VS Code Server 설치 실패
- 통합 터미널이 `/Users/...`에서 열림
- 현재 branch가 `main`

## 19.2 보안 점검

```bash
git status -sb
git diff
git diff --cached

git grep -n -i -E 'token|password|secret|private.?key' || true
find . -maxdepth 5 -type f \
  \( -name '.env' -o -name '.env.local' -o -name '*.pem' -o -name 'id_rsa' -o -name 'id_ed25519' -o -name 'hosts.yml' \)
```

저장소와 스크린샷에 포함하지 않습니다.

- GitHub token·인증 코드
- `~/.config/gh/hosts.yml`
- `~/.orbstack/ssh/id_ed25519`
- `~/.ssh/config` 전체 내용
- `.env.local`
- 학교 내부 민감정보

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

# 20. clean clone 사전 검증

PR을 Ready로 바꾸기 전에 수행합니다.

```bash
# [VS Code Ubuntu: 원본 저장소]
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

# 21. PR 최종 점검과 병합

```bash
PR_NUMBER="$(gh pr view --json number --jq '.number')"

git status -sb
gh pr status --conflict-status
gh pr view "$PR_NUMBER"
gh pr diff "$PR_NUMBER" --name-only
gh pr diff "$PR_NUMBER"
```

확인 사항:

- VS Code Remote-SSH 증거가 있다.
- `.env.local`과 개인키가 없다.
- Dockerfile, `site/`, `bind-test/`, `docs/`가 있다.
- clean clone 결과가 있다.

```bash
gh pr checks "$PR_NUMBER"
```

| 상태 | 조치 |
|---|---|
| 검사 통과 | 계속 진행 |
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

# 22. 병합 후 최종 검증

```bash
git switch main
git pull --ff-only origin main
git fetch --prune

git status -sb
git log --oneline --graph --decorate --all -20
gh pr list --state merged --limit 10
```

```bash
docker build -t codyssey-e1-1-web:final .
docker rm -f e1-1-final 2>/dev/null || true
docker run -d \
  --name e1-1-final \
  -p 18082:80 \
  codyssey-e1-1-web:final

curl http://localhost:18082
```

Default branch에서 웹 응답이 나오면 완료입니다.

---

# 23. 공용 장비 로그아웃

모든 작업이 끝난 뒤 학교 공용 장비에서만 실행합니다.

```bash
gh auth status --hostname github.com
gh auth logout --hostname github.com
gh auth status --hostname github.com || true
```

OrbStack SSH 개인키를 삭제하거나 저장소에 복사하지 않습니다. 학교 운영 정책에 따라 OrbStack과 VS Code의 로그인 세션도 종료합니다.

---

# 24. 오류 대응표

| 증상 | 확인 | 조치 |
|---|---|---|
| `orb info`에서 machine 없음 | `orb list` | machine 생성 |
| GitHub 접속 실패 | `getent hosts`, `curl -I` | 네트워크 해결 후 재시도 |
| `docker: command not found` | `mac which docker` | `mac link docker` |
| Docker Server 정보 없음 | `docker info` | OrbStack 실행·link 확인 |
| SSH 연결 실패 | `ssh codyssey-training@orb` | `orb status`, `orb info`, `ssh -G` 확인 |
| SSH 비밀번호 요구 | 연결 대상 확인 | OrbStack 내장 SSH는 키 인증이며 별도 sshd 설치 금지 |
| Remote-SSH 호스트가 안 보임 | Mac VS Code 확장 | `ms-vscode-remote.remote-ssh` 설치 |
| VS Code Server 설치 실패 | Remote - SSH Output | 네트워크·디스크·권한 확인 |
| 통합 터미널 경로가 `/Users/...` | `pwd`, 상태 표시줄 | Remote-SSH 창에서 폴더 다시 열기 |
| 통합 터미널이 홈에서 시작 | `pwd` | 저장소 폴더를 Open Folder로 열고 새 터미널 생성 |
| 셸이 예상과 다름 | `$SHELL`, `ps -p $$` | `.vscode/settings.json`과 Remote Settings 확인 |
| 현재 branch가 `main` | `git branch --show-current` | `git switch feat/e1-1-complete` |
| `unknown flag: --clipboard` | `gh --version` | 해당 옵션 제외 |
| push 권한 없음 | `viewerPermission` | WRITE 이상 권한 요청 |
| clone 폴더 중복 | 기존 폴더 확인 | 기존 작업 보존, 다른 경로 사용 |
| 포트 충돌 | `mac lsof`, `docker ps` | 다른 포트 선택 |
| chmod가 Git에 안 보임 | `ls -l` | 문서·스크린샷으로 증명 |
| PR checks 없음 | `gh pr checks` | CI 없음과 수동 검증 기록 |
| push 거절 | `git fetch`, `git branch -vv` | force push 금지 |

---

# 25. 확장 부록

## 25.1 `code .`의 위치

OrbStack Linux machine에서 `code`는 Mac의 VS Code 명령으로 연결될 수 있습니다. 다음 명령은 Mac VS Code를 여는 보조 수단입니다.

```bash
command -v code || true
code .
```

그러나 다음을 보장하지 않습니다.

- 현재 창이 Remote-SSH 창임
- 통합 터미널이 Ubuntu에서 실행됨
- workspace가 Ubuntu 저장소 경로임

따라서 필수 경로는 10장의 Remote-SSH 절차입니다.

## 25.2 다른 `git add` 방식

```bash
git add -p E1-1-training.md
git add -u
git add -A
```

## 25.3 다른 병합 방식

```bash
gh pr merge "$PR_NUMBER" --squash --delete-branch
gh pr merge "$PR_NUMBER" --rebase --delete-branch
```

---

# 26. 공식 참고문헌

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
- [R10] Terminal basics — <https://code.visualstudio.com/docs/terminal/basics>
- [R11] Terminal profiles — <https://code.visualstudio.com/docs/terminal/profiles>
- [R12] User and workspace settings — <https://code.visualstudio.com/docs/configure/settings>

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

> 저장소를 clone한 직후 작업 브랜치를 생성했다.  
> VS Code는 OrbStack 내장 SSH와 Remote-SSH로 `codyssey-training@orb`에 연결했다.  
> 새 통합 터미널에서 Ubuntu 24.04, 셸, 저장소 경로, 작업 브랜치를 검증했다.  
> GitHub CLI와 Docker 실습을 Ubuntu에서 수행했다.  
> clean clone을 통과한 뒤 PR을 병합했다.  
> Default branch에서 최종 빌드와 웹 응답을 확인했다.
