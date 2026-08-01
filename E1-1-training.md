# E1-1. AI/SW 개발 워크스테이션 구축 — 입문자 수행 가이드

> 코디세이 입학연수 · 개발 입문 · 학습시간 40시간  
> 주 실습환경: **macOS + OrbStack + Ubuntu 24.04 LTS + OrbStack Docker**  
> OrbStack Linux machine 이름: **`codyssey-training`**

이 문서는 입문자가 E1-1 미션을 다음 순서로 수행하도록 구성한 실습 지침서입니다.

> **환경 준비 → Docker 연결 확인 → GitHub CLI 인증 → 브랜치 작업 → add·commit·push → Pull Request → Docker 실습 → 증거 정리 → PR 병합 → 동료평가 준비**

아래 명령은 본인의 환경에서 직접 실행합니다. 예시 출력이나 다른 사람의 화면을 제출하지 않습니다.

---

## 문서 표시 기준

| 표시 | 의미 |
|---|---|
| **[필수]** | 미션 문서에서 요구하는 항목 |
| **[권장]** | 입문자의 안정적인 수행과 평가 준비를 위한 항목 |
| **[선택]** | 환경이나 운영 방식에 따라 선택하는 항목 |
| **[보너스]** | 필수 요구사항을 완료한 뒤 수행하는 확장 과제 |
| **[macOS]** | Mac 터미널에서 실행 |
| **[Ubuntu]** | `codyssey-training` Linux machine에서 실행 |

문서의 `[R1]` 같은 번호는 마지막 **공식 참고문헌**과 연결됩니다.

---

# 목차

1. 미션 완료 기준
2. 입문자 전체 수행 흐름
3. 구조와 핵심 용어
4. 저장소 구조
5. macOS·OrbStack 사전 점검
6. Ubuntu 24.04 machine 생성
7. Ubuntu 기본환경과 네트워크 점검
8. OrbStack Docker 연동 및 경로 사전 시험
9. GitHub CLI 설치
10. GitHub CLI 인증
11. 저장소 clone과 상태 확인
12. Git 상태 모델 이해
13. 브랜치 운영 원칙
14. `git add` 방법과 안전한 staging
15. commit 작성과 기록 원칙
16. push 방법과 원격 상태 확인
17. GitHub CLI로 Pull Request 생성
18. PR 진행상태·diff·검사·리뷰 관리
19. PR 병합 방식과 작업 정리
20. 실수 복구와 충돌 예방
21. 터미널 기본 조작
22. 파일·디렉터리 권한
23. Docker 이미지·컨테이너 운영
24. Dockerfile 기반 웹 서버
25. 포트 매핑
26. 바인드 마운트
27. Docker 볼륨 영속성
28. Git·PR 현황 기록 문서
29. 요구사항·테스트·증거 추적
30. clean clone 재현 시험
31. 보안과 민감정보
32. 트러블슈팅
33. 40시간 권장 학습계획
34. 품질 게이트
35. 시험·동료평가 대비
36. 보너스 과제
37. 최종 제출 체크리스트
38. 공식 참고문헌

---

# 1. 미션 완료 기준

GitHub 저장소의 **Default branch**에서 다음 내용을 확인할 수 있어야 합니다.

- 터미널로 파일과 디렉터리를 생성·복사·이동·삭제한다.
- 파일과 디렉터리 권한을 확인하고 변경한다.
- Docker 버전과 Engine 상태를 확인한다.
- 이미지와 컨테이너를 실행·조회·중지·삭제한다.
- `Dockerfile`을 직접 작성해 커스텀 이미지를 빌드한다.
- 포트 매핑으로 웹 서버에 접속한다.
- 바인드 마운트로 파일 변경이 반영되는지 확인한다.
- Docker 볼륨으로 컨테이너 삭제 후에도 데이터가 유지되는지 확인한다.
- Git 설정, GitHub 인증, VS Code 연동 상태를 기록한다.
- 브랜치에서 작업하고 Pull Request로 검토·병합한다.
- 트러블슈팅을 최소 2건 이상 기록한다.
- 문서만 보고 평가자가 같은 절차를 재현할 수 있게 한다.
- 토큰·비밀번호·개인키를 저장소와 스크린샷에 노출하지 않는다.

---

# 2. 입문자 전체 수행 흐름

다음 순서를 바꾸지 않습니다.

```text
1. OrbStack 실행 확인
2. Ubuntu 24.04 codyssey-training 생성
3. Ubuntu 기본 패키지와 네트워크 확인
4. OrbStack Docker 연결
5. Docker 빌드·바인드 마운트 경로 사전 시험
6. GitHub CLI 설치
7. GitHub CLI 로그인과 Git credential 설정
8. gh repo clone으로 저장소 복제
9. main 최신화
10. 작업 브랜치 생성
11. 작은 단위로 파일 작성
12. status → diff → add → cached diff → commit
13. 첫 push와 upstream 설정
14. Draft PR 생성
15. Docker·권한·문서 실습을 commit 단위로 추가
16. PR diff와 checks 확인
17. Ready for review 전환
18. 검토 후 PR 병합
19. main 최신화와 브랜치 정리
20. clean clone 재현
21. 최종 문서·증거·보안 점검
22. 동료평가
```

## 단계 중지 원칙

각 단계의 정상 기준을 통과하지 못하면 다음 단계로 넘어가지 않습니다.

- Docker 연결 실패 상태에서 Dockerfile 실습으로 넘어가지 않는다.
- GitHub 인증 실패 상태에서 clone·push를 반복하지 않는다.
- `git diff --cached`를 확인하지 않고 commit하지 않는다.
- PR diff를 확인하지 않고 merge하지 않는다.

---

# 3. 구조와 핵심 용어

```text
Mac
├── macOS
├── OrbStack
│   ├── Linux machine: codyssey-training
│   │   └── Ubuntu 24.04 LTS
│   │       └── Git 작업 디렉터리
│   └── OrbStack Docker Engine
│       ├── images
│       ├── containers
│       └── volumes
├── GitHub CLI(gh)
├── VS Code
└── 브라우저
```

| 용어 | 설명 |
|---|---|
| Working tree | 현재 파일을 수정하는 작업 공간 |
| Staging area | 다음 commit에 넣을 변경을 선택하는 영역 |
| Commit | 선택한 변경의 스냅샷과 설명 |
| Branch | 독립적으로 작업하기 위한 commit 흐름 |
| Remote | GitHub와 같은 원격 저장소 연결 |
| Push | 로컬 commit을 원격 브랜치로 전송 |
| Pull Request | 브랜치 변경을 base branch에 병합하도록 제안·검토하는 단위 |
| Draft PR | 아직 완성되지 않았지만 진행상황을 공유하는 PR |
| Base branch | 변경을 받아들일 대상 브랜치, 이 문서에서는 `main` |
| Head branch | 작업 commit이 있는 브랜치 |
| Merge | PR의 변경을 base branch에 반영 |
| `gh` | GitHub 인증·저장소·Issue·PR 등을 터미널에서 다루는 공식 CLI |

OrbStack Linux machine과 Docker 컨테이너는 서로 다릅니다. Linux machine은 Ubuntu 실습환경이고, Docker 컨테이너는 이미지에서 실행되는 격리된 프로세스 환경입니다. [R1][R2]

---

# 4. 저장소 구조

```text
codyssey-training-e1-1/
├── README.md
├── E1-1-training.md
├── Dockerfile
├── .dockerignore
├── .gitignore
├── .github/
│   └── pull_request_template.md
├── site/
│   └── index.html
├── bind-test/
│   └── index.html
├── docs/
│   ├── environment.md
│   ├── git-workflow.md
│   ├── terminal-and-permissions.md
│   ├── docker-operations.md
│   ├── bind-mount.md
│   ├── volume-persistence.md
│   ├── troubleshooting.md
│   ├── test-results.md
│   ├── requirement-traceability.md
│   └── screenshots/
│       ├── environment/
│       ├── git/
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

- `E1-1-training.md`: 수행 방법
- `README.md`: 평가자가 가장 먼저 보는 결과 요약
- `docs/`: 실제 명령, 출력, 오류, 증거
- `.github/pull_request_template.md`: PR 작성 시 빠뜨리기 쉬운 항목 점검

---

# 5. macOS·OrbStack 사전 점검

## 5.1 [macOS] OrbStack 실행

```bash
# [macOS]
orb version
orb status
orb list
```

정상 기준:

- 버전이 출력된다.
- `orb status`가 오류 없이 실행된다.
- machine 목록을 확인할 수 있다.

## 5.2 [macOS] OrbStack Docker 확인

```bash
# [macOS]
docker version
docker context ls
docker context show
```

Mac의 현재 context가 `orbstack`이 아니면 다음을 실행합니다.

```bash
# [macOS]
docker context use orbstack
docker context show
```

> Ubuntu machine 안의 `docker context show` 문자열만으로 성공·실패를 판정하지 않습니다. Ubuntu에서는 `docker version`, `docker info`, `hello-world` 실행 성공을 기준으로 판단합니다.

---

# 6. Ubuntu 24.04 machine 생성

Ubuntu 24.04 LTS의 코드명은 `noble`입니다. [R2][R4]

## 6.1 기존 machine 확인

```bash
# [macOS]
orb list
orb info codyssey-training
```

`codyssey-training`이 이미 있으면 다시 만들지 않습니다. 기존 machine을 삭제하면 내부 데이터가 손실될 수 있습니다.

## 6.2 새 machine 생성

다음 두 방식 중 하나만 실행합니다.

```bash
# [macOS] 기본
orb create ubuntu:noble codyssey-training
```

```bash
# [macOS] 자원 제한 예시
orb create \
  --memory 4G \
  --cpus 2 \
  --disk 32G \
  ubuntu:noble \
  codyssey-training
```

## 6.3 접속과 확인

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

## 6.4 종료·시작

```bash
# [Ubuntu → macOS]
exit
```

```bash
# [macOS]
orb stop codyssey-training
orb start codyssey-training
orb -m codyssey-training
```

설치된 OrbStack 버전의 정확한 옵션은 `orb <command> --help`로 확인합니다. [R3]

---

# 7. Ubuntu 기본환경과 네트워크 점검

## 7.1 네트워크 확인

```bash
# [Ubuntu]
getent hosts github.com
curl -I https://github.com
```

DNS 또는 HTTPS 연결이 실패하면 `apt`, `gh`, `git clone`, `docker pull`도 실패할 수 있습니다. 학교 네트워크 문제와 도구 설정 문제를 먼저 구분합니다.

## 7.2 기본 패키지 설치

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
# [Ubuntu]
git --version
curl --version | head -n 1
jq --version
```

## 7.3 작업 디렉터리

```bash
# [Ubuntu]
mkdir -p ~/codyssey-training
cd ~/codyssey-training
pwd
```

OrbStack의 Mac·Linux 파일 공유 방식은 공식 문서를 참고합니다. [R5]

---

# 8. OrbStack Docker 연동 및 경로 사전 시험

## 8.1 Ubuntu에서 Docker 확인

```bash
# [Ubuntu]
command -v docker || true
type -a docker || true
mac which docker || true
```

Docker 명령이 없으면 OrbStack command link를 연결합니다.

```bash
# [Ubuntu]
mac link docker
hash -r
command -v docker
```

연결 검증:

```bash
# [Ubuntu]
docker version
docker info
docker run --rm hello-world
```

정상 기준:

- Client와 Server 정보가 표시된다.
- `docker info`가 Engine 정보를 반환한다.
- `Hello from Docker!`가 출력된다.

`docker context show`는 참고용으로 확인합니다.

```bash
# [Ubuntu]
docker context show || true
```

## 8.2 command link 복구

링크 오류가 있을 때만 실행합니다.

```bash
# [Ubuntu]
mac unlink docker
mac link docker
hash -r
exec "$SHELL" -l
```

다시 확인합니다.

```bash
# [Ubuntu]
command -v docker
docker version
docker info
```

## 8.3 Docker 경로 사전 시험 — 반드시 먼저 수행

Ubuntu 홈 디렉터리의 파일을 Docker build와 bind mount에서 정상 처리하는지 확인합니다.

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

두 시험이 성공해야 본 미션의 Dockerfile과 바인드 마운트 단계로 이동합니다.

## 8.4 Mac과 Ubuntu가 같은 Engine을 보는지 확인

```bash
# [Ubuntu]
docker images
```

```bash
# [macOS, 별도 터미널]
docker images
```

`orb-path-test` 이미지가 양쪽에서 확인되면 같은 OrbStack Docker Engine을 사용하고 있는 것입니다.

---

# 9. GitHub CLI 설치

GitHub CLI maintainers는 Ubuntu에서 공식 Debian 패키지 저장소 사용을 권장합니다. [R24]

## 9.1 이미 설치됐는지 확인

```bash
# [Ubuntu]
command -v gh || true
gh --version || true
```

정상 버전이 표시되면 9.2를 건너뜁니다.

## 9.2 공식 저장소로 설치

```bash
# [Ubuntu]
sudo mkdir -p -m 755 /etc/apt/keyrings

wget -nv \
  -O /tmp/githubcli-archive-keyring.gpg \
  https://cli.github.com/packages/githubcli-archive-keyring.gpg

sudo cp /tmp/githubcli-archive-keyring.gpg \
  /etc/apt/keyrings/githubcli-archive-keyring.gpg

sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

sudo mkdir -p -m 755 /etc/apt/sources.list.d

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt update
sudo apt install -y gh
```

설치 확인:

```bash
# [Ubuntu]
gh --version
gh help
```

---

# 10. GitHub CLI 인증

## 10.1 권장 방식: HTTPS + web login

입문자는 HTTPS와 GitHub CLI credential helper를 사용합니다.

```bash
# [Ubuntu]
gh auth login \
  --hostname github.com \
  --git-protocol https \
  --web
```

화면에 표시되는 일회용 코드를 브라우저 인증 화면에 입력합니다. 토큰 문자열을 문서나 스크린샷에 노출하지 않습니다. [R25]

인증 확인과 Git 연결:

```bash
# [Ubuntu]
gh auth status --hostname github.com
gh auth setup-git --hostname github.com
gh config get git_protocol
```

정상 기준:

- 로그인한 GitHub 계정이 표시된다.
- Git protocol이 `https`이다.
- `gh auth setup-git`이 오류 없이 끝난다. [R26]

## 10.2 자격증명 저장 위치 확인

일부 Linux 환경에는 시스템 credential store가 없어 GitHub CLI가 토큰을 파일에 저장할 수 있습니다. `gh auth status`로 저장 상태를 확인합니다. [R25]

다음 경로는 절대 저장소에 복사하거나 commit하지 않습니다.

```text
~/.config/gh/
```

학교 또는 공동 사용 장비에서는 작업 종료 후 로그아웃을 검토합니다.

```bash
# [Ubuntu]
gh auth logout --hostname github.com
```

로그아웃 후에는 다음 작업 전에 다시 인증해야 합니다.

## 10.3 [선택] SSH 방식

이미 Mac 계정에 GitHub SSH 키와 SSH agent가 안전하게 구성된 경우에만 사용합니다.

```bash
# [Ubuntu]
echo "$SSH_AUTH_SOCK"
ssh -T git@github.com
```

GitHub CLI protocol을 SSH로 바꾸려면:

```bash
# [Ubuntu]
gh auth login \
  --hostname github.com \
  --git-protocol ssh \
  --web
```

한 저장소에서는 HTTPS와 SSH 사용법을 중간에 반복적으로 혼합하지 않습니다. [R23][R25]

---

# 11. 저장소 clone과 상태 확인

## 11.1 `gh repo clone` 사용

```bash
# [Ubuntu]
cd ~/codyssey-training

gh repo clone MetaStudy999/codyssey-training-e1-1
cd codyssey-training-e1-1
```

`gh repo clone OWNER/REPO`는 인증 설정의 Git protocol을 사용합니다. [R27]

## 11.2 Git 사용자 정보

```bash
# [Ubuntu]
git config --global user.name
git config --global user.email
git config --global init.defaultBranch
```

값이 없다면 설정합니다.

```bash
# [Ubuntu]
git config --global user.name "YOUR_NAME"
git config --global user.email "YOUR_EMAIL"
git config --global init.defaultBranch main
```

공개 스크린샷에서 이메일 노출 여부를 확인합니다.

## 11.3 저장소 확인

```bash
# [Ubuntu]
pwd
git status -sb
git branch --show-current
git remote -v
gh repo view --web
```

정상 기준:

- 경로: `~/codyssey-training/codyssey-training-e1-1`
- branch: `main`
- remote: `MetaStudy999/codyssey-training-e1-1`

---

# 12. Git 상태 모델 이해

```text
파일 수정
  ↓ git diff
Working tree
  ↓ git add
Staging area
  ↓ git commit
Local repository
  ↓ git push
Remote branch
  ↓ Pull Request 검토·merge
Default branch(main)
```

## 12.1 항상 반복할 상태 확인 루프

```bash
# [Ubuntu: 저장소 루트]
git status -sb
git diff --stat
git diff
```

staging 후:

```bash
git status -sb
git diff --cached --stat
git diff --cached
```

commit 후:

```bash
git log -1 --stat
git log --oneline --graph --decorate --all -10
```

원격 상태:

```bash
git branch -vv
git remote -v
gh pr status --conflict-status
```

> `git status`는 단순 확인 명령이 아니라, add·commit·push 전후에 작업 범위를 검증하는 핵심 명령입니다. [R14][R28]

---

# 13. 브랜치 운영 원칙

## 13.1 `main`의 역할

- 평가 가능한 상태를 유지한다.
- 실행되지 않는 중간 작업을 직접 push하지 않는다.
- 작업은 별도 브랜치에서 수행한다.
- PR 검토 후 `main`에 병합한다.

## 13.2 브랜치 이름 예시

```text
docs/environment-baseline
feat/docker-web
feat/volume-persistence
fix/docker-link
fix/port-conflict
docs/final-evidence
```

## 13.3 새 작업 시작

```bash
# [Ubuntu]
git switch main
git pull --ff-only origin main
git switch -c docs/environment-baseline
```

확인:

```bash
git status -sb
git branch -vv
```

`--ff-only`는 의도하지 않은 merge commit 생성을 방지합니다.

## 13.4 한 브랜치의 범위

좋은 범위:

- 환경 기준선 문서화
- Docker 웹 서버 구현
- 볼륨 실습과 증거
- 최종 문서 정리

나쁜 범위:

- 환경, Dockerfile, 보너스 Compose, unrelated 파일을 한 PR에 모두 섞음
- 오류 수정과 대규모 문서 개편을 이유 없이 함께 처리

---

# 14. `git add` 방법과 안전한 staging

`git add`는 파일을 GitHub에 보내는 명령이 아닙니다. 다음 commit에 포함할 내용을 staging area에 선택합니다. [R28]

## 14.1 방법 A — 파일을 정확히 지정: 입문자 권장

```bash
git add README.md docs/environment.md
```

장점:

- 실수로 다른 파일이 포함될 가능성이 낮다.
- commit 목적이 명확해진다.

## 14.2 방법 B — 디렉터리 단위

```bash
git add docs/screenshots/environment/
```

## 14.3 방법 C — 변경 일부만 선택

하나의 파일에 서로 다른 목적의 수정이 섞였을 때 사용합니다.

```bash
git add -p E1-1-training.md
```

주요 선택:

- `y`: 현재 hunk 추가
- `n`: 제외
- `s`: 더 작은 hunk로 분할
- `q`: 종료

## 14.4 방법 D — 추적 중인 파일의 수정·삭제만

```bash
git add -u
```

새 파일은 포함하지 않습니다.

## 14.5 방법 E — 저장소의 모든 변경

```bash
git add -A
```

반드시 저장소 루트에서 `git status -sb`와 `git diff`를 먼저 확인합니다.

> `git add .`은 현재 디렉터리를 기준으로 동작하므로, 초보자는 저장소 루트에서 `git add -A`를 사용하거나 파일명을 명시하는 편이 안전합니다.

## 14.6 staging 확인

```bash
git status -sb
git diff --cached --stat
git diff --cached
```

## 14.7 잘못 올린 파일 staging 취소

```bash
git restore --staged <파일경로>
```

예:

```bash
git restore --staged docs/screenshots/private-account.png
```

파일의 실제 수정 내용은 유지되고 staging에서만 제거됩니다.

## 14.8 권장하지 않는 방식

```bash
git commit -am "message"
```

이 명령은 새로 만든 untracked 파일을 포함하지 않으므로, 입문자가 증거 파일을 빠뜨리기 쉽습니다.

---

# 15. commit 작성과 기록 원칙

## 15.1 commit 전 5단계

```bash
git status -sb
git diff
git add <파일 또는 경로>
git diff --cached
git commit -m "Docs: record OrbStack Ubuntu environment"
```

## 15.2 commit 메시지 접두어

| 접두어 | 사용 예 |
|---|---|
| `Feat:` | Docker 웹 기능 또는 구성 추가 |
| `Fix:` | 포트·링크·경로 오류 수정 |
| `Docs:` | README, 로그, 트러블슈팅 문서 |
| `Test:` | 검증 스크립트·테스트 결과 |
| `Refactor:` | 동작은 유지하고 구조 정리 |
| `Chore:` | 설정·정리 작업 |

좋은 예:

```text
Docs: record OrbStack Ubuntu environment baseline
Feat: add NGINX Dockerfile and static page
Test: verify bind mount file updates
Fix: avoid port collision during reproduction test
```

피해야 할 예:

```text
수정
완료
최종
다시수정
```

## 15.3 한 commit에는 한 가지 목적

권장 흐름:

```text
Commit 1: 환경 정보
Commit 2: 터미널·권한 실습
Commit 3: Docker 기본 운영
Commit 4: Dockerfile과 웹 파일
Commit 5: 포트 매핑 증거
Commit 6: 바인드 마운트 증거
Commit 7: 볼륨 영속성 증거
Commit 8: 트러블슈팅
Commit 9: 테스트·증거 인덱스
Commit 10: 최종 README
```

## 15.4 방금 한 commit 수정

아직 push하지 않았고 메시지만 잘못 작성했다면:

```bash
git commit --amend
```

이미 다른 사람과 공유한 commit은 입문자가 임의로 amend하거나 history를 재작성하지 않습니다.

---

# 16. push 방법과 원격 상태 확인

## 16.1 첫 push

```bash
git push -u origin docs/environment-baseline
```

`-u`는 로컬 브랜치와 원격 브랜치의 upstream을 연결합니다.

## 16.2 이후 push

```bash
git push
```

## 16.3 push 전후 확인

```bash
git status -sb
git log --oneline --decorate -5
git push
git status -sb
git branch -vv
```

## 16.4 강제 push 금지

입문자는 다음 명령을 사용하지 않습니다.

```text
git push --force
git push -f
```

공유 브랜치 history를 덮어쓸 수 있습니다.

## 16.5 현재 GitHub 현황

```bash
gh status
gh pr status --conflict-status
gh pr list --state open
```

---

# 17. GitHub CLI로 Pull Request 생성

## 17.1 Draft PR을 일찍 만드는 이유

- 작업 목적을 먼저 기록할 수 있다.
- 진행상황과 commit이 PR에 누적된다.
- 변경 파일과 diff를 지속적으로 확인할 수 있다.
- 완성 전에는 Ready for review로 오인되지 않는다.

## 17.2 PR 본문 파일 작성

```bash
cat > /tmp/e1-1-pr-body.md <<'EOF'
## 작업 목적

OrbStack Ubuntu 24.04 환경 기준선과 검증 결과를 기록합니다.

## 변경 내용

- [x] 환경 정보 작성
- [x] Docker 연결 확인
- [ ] 스크린샷 정리
- [ ] clean clone 재현

## 검증 방법

```bash
cat /etc/os-release
docker version
docker info
docker run --rm hello-world
```

## 증거 위치

- docs/environment.md
- docs/screenshots/environment/

## 관련 요구사항

- ENV-01
- ENV-02
EOF
```

## 17.3 Draft PR 생성 — 권장

```bash
gh pr create \
  --draft \
  --base main \
  --head docs/environment-baseline \
  --title "Docs: record OrbStack Ubuntu environment" \
  --body-file /tmp/e1-1-pr-body.md
```

PR URL이 출력됩니다. `gh pr create`는 현재 branch가 push되지 않은 경우 push 또는 fork 관련 안내를 표시할 수 있으므로, 이 문서에서는 먼저 `git push -u`를 수행합니다. [R29]

## 17.4 간단한 대안

commit 내용을 바탕으로 제목과 본문을 채우려면:

```bash
gh pr create --draft --base main --fill
```

초보자에게는 명시적인 `--title`과 `--body-file` 방식이 더 안전합니다.

## 17.5 Issue와 연결 — 선택

먼저 작업 Issue를 만들 수 있습니다.

```bash
gh issue create \
  --title "E1-1 Docker 환경 및 증거 정리" \
  --body "환경, Docker, 문서 증거를 단계별로 완료한다."
```

PR 본문에 다음을 작성하면 merge 시 Issue를 자동으로 닫을 수 있습니다.

```text
Closes #12
```

---

# 18. PR 진행상태·diff·검사·리뷰 관리

## 18.1 PR 상태 확인

```bash
gh pr status --conflict-status
gh pr view
gh pr view --comments
gh pr view --web
```

`gh pr status`는 관련 PR, CI 검사, 리뷰 상태 등을 요약합니다. [R30]

## 18.2 변경 파일과 diff 확인

```bash
gh pr diff --name-only
gh pr diff
gh pr diff --web
```

확인 항목:

- 의도하지 않은 파일이 포함됐는가
- 토큰·이메일·내부 주소가 노출됐는가
- 스크린샷에 민감정보가 있는가
- 임시 파일과 대용량 로그가 포함됐는가
- 문서의 명령과 실제 파일 구성이 일치하는가

## 18.3 PR 생성 후 추가 수정

PR을 닫고 다시 만들 필요가 없습니다.

```bash
# 파일 수정 후
git status -sb
git diff
git add <파일>
git diff --cached
git commit -m "Docs: add environment verification evidence"
git push
```

같은 branch에 push하면 기존 PR이 자동으로 갱신됩니다.

## 18.4 PR 본문 갱신

```bash
gh pr edit --body-file /tmp/e1-1-pr-body.md
```

제목 변경:

```bash
gh pr edit --title "Docs: complete OrbStack environment evidence"
```

## 18.5 검사 상태 확인

GitHub Actions 또는 필수 검사가 있는 경우:

```bash
gh pr checks
gh pr checks --watch
```

검사가 없는 저장소에서는 표시할 항목이 없을 수 있습니다. `gh pr checks --watch`는 완료될 때까지 상태를 갱신합니다. [R31]

## 18.6 Draft를 Ready로 전환

다음 조건을 만족한 뒤 실행합니다.

- PR 본문 체크리스트 완료
- `git status -sb`가 clean
- `gh pr diff` 검토 완료
- 필수 테스트 완료
- 민감정보 점검 완료

```bash
gh pr ready
```

다시 Draft로 돌리려면:

```bash
gh pr ready --undo
```

## 18.7 base branch 변경 반영

다른 PR이 먼저 merge되어 `main`이 변경되었다면 현재 PR branch를 갱신합니다.

### GitHub CLI 방식

```bash
gh pr update-branch
```

### 로컬 merge 방식 — 기록 보존에 유리

```bash
git fetch origin
git merge origin/main
git push
```

입문자는 공유한 PR branch에서 무분별한 rebase와 force push를 피합니다.

## 18.8 동료의 PR 확인

```bash
gh pr checkout <PR번호>
gh pr view <PR번호>
gh pr diff <PR번호>
```

리뷰 의견:

```bash
gh pr review <PR번호> \
  --comment \
  --body "확인한 기능과 재현 결과를 구체적으로 작성합니다."
```

자신의 PR을 자신이 승인하는 방식으로 검토를 대체하지 않습니다.

---

# 19. PR 병합 방식과 작업 정리

## 19.1 병합 전 최종 확인

```bash
git status -sb
gh pr view
gh pr diff --name-only
gh pr checks
gh pr status --conflict-status
```

## 19.2 세 가지 병합 방식

| 방식 | 명령 | 특징 |
|---|---|---|
| Merge commit | `--merge` | branch의 개별 commit과 병합 지점을 보존 |
| Squash | `--squash` | PR 전체를 main의 commit 하나로 압축 |
| Rebase | `--rebase` | 개별 commit을 main 위에 선형으로 반영 |

### 이 교육과정의 권장 방식

의미 있는 commit 이력을 학습하고 확인하려면 다음을 사용합니다.

```bash
gh pr merge --merge --delete-branch
```

작은 수정 commit이 지나치게 많고 PR 단위만 남기려면 선택적으로 사용합니다.

```bash
gh pr merge --squash --delete-branch
```

병합 정책은 저장소 설정과 리뷰 규칙을 우선합니다. 필요한 검사를 우회하기 위해 `--admin`을 사용하지 않습니다. [R32]

## 19.3 병합 후 로컬 정리

```bash
git switch main
git pull --ff-only origin main
git fetch --prune
git branch -vv
```

`gh pr merge --delete-branch`가 로컬 branch를 삭제하지 못한 경우:

```bash
git branch -d <작업브랜치>
```

## 19.4 기록 확인

```bash
git log --oneline --graph --decorate --all -20
gh pr list --state merged --limit 10
```

평가 대상인 Default branch에 변경이 실제로 반영됐는지 확인합니다.

---

# 20. 실수 복구와 충돌 예방

## 20.1 staging만 취소

```bash
git restore --staged <파일>
```

## 20.2 수정 전 상태로 되돌리기 — 주의

```bash
git restore <파일>
```

commit되지 않은 수정이 사라질 수 있으므로 `git diff`를 먼저 확인합니다.

## 20.3 잘못된 branch에서 작업했을 때

commit 전이라면 새 branch를 만들 수 있습니다.

```bash
git switch -c fix/move-uncommitted-work
```

수정 내용은 새 branch에 그대로 유지됩니다.

## 20.4 push가 거절될 때

먼저 원격 상태를 확인합니다.

```bash
git fetch origin
git status -sb
git branch -vv
git log --oneline --graph --decorate --all -15
```

`main`에서 작업 중이라면:

```bash
git switch main
git pull --ff-only origin main
```

작업 branch의 PR base가 바뀌었다면 18.7의 branch update 절차를 사용합니다. 오류를 무시하고 force push하지 않습니다.

## 20.5 commit하지 않은 파일 임시 보관 — 선택

```bash
git stash push -u -m "WIP before branch update"
git stash list
```

복원:

```bash
git stash pop
```

stash도 충돌이 발생할 수 있으므로 장기 보관소로 사용하지 않습니다.

---

# 21. 터미널 기본 조작

```bash
# [Ubuntu]
cd ~/codyssey-training/codyssey-training-e1-1
mkdir -p practice/source
cd practice

pwd
ls
ls -la

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

기록할 내용:

- 명령과 출력
- 작업 전후 `ls -la`
- 절대 경로와 상대 경로
- 오류 원문

GNU Coreutils 문서를 기준으로 기본 명령을 확인합니다. [R16]

---

# 22. 파일·디렉터리 권한

```text
r = read    = 4
w = write   = 2
x = execute = 1
```

| 권한 | 소유자 | 그룹 | 기타 사용자 |
|---|---|---|---|
| `755` | `rwx` | `r-x` | `r-x` |
| `644` | `rw-` | `r--` | `r--` |

## 22.1 파일

```bash
# [Ubuntu]
cd ~/codyssey-training/codyssey-training-e1-1/practice

touch permission-file.txt
ls -l permission-file.txt
chmod 644 permission-file.txt
ls -l permission-file.txt
chmod 600 permission-file.txt
ls -l permission-file.txt
```

## 22.2 디렉터리

```bash
mkdir -p permission-dir
ls -ld permission-dir
chmod 755 permission-dir
ls -ld permission-dir
chmod 700 permission-dir
ls -ld permission-dir
```

변경 전후와 권한 선택 이유를 `docs/terminal-and-permissions.md`에 기록합니다. [R15][R16]

---

# 23. Docker 이미지·컨테이너 운영

## 23.1 기본 상태

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

## 23.2 hello-world

```bash
docker rm -f e1-1-hello 2>/dev/null || true
docker run --name e1-1-hello hello-world
docker ps -a
docker logs e1-1-hello
```

## 23.3 Ubuntu 컨테이너 — 안정적인 방식

주 프로세스가 계속 실행되도록 `sleep infinity`를 사용합니다.

```bash
docker rm -f e1-1-ubuntu 2>/dev/null || true

docker run -d \
  --name e1-1-ubuntu \
  ubuntu:24.04 \
  sleep infinity
```

내부 진입:

```bash
docker exec -it e1-1-ubuntu bash
```

컨테이너 내부:

```bash
pwd
ls -la
echo "Hello from Ubuntu container"
exit
```

호스트 Ubuntu:

```bash
docker ps
docker logs e1-1-ubuntu
docker stop e1-1-ubuntu
docker start e1-1-ubuntu
docker rm -f e1-1-ubuntu
```

---

# 24. Dockerfile 기반 웹 서버

## 24.1 웹 파일

```bash
# [Ubuntu]
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

## 24.2 Dockerfile

```bash
cat > Dockerfile <<'EOF'
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-e1-1-web"
LABEL org.opencontainers.image.description="Codyssey E1-1 custom web server"

COPY site/ /usr/share/nginx/html/

EXPOSE 80
EOF
```

## 24.3 ignore 파일

```bash
cat > .dockerignore <<'EOF'
.git
.github
docs
practice
bind-test
*.log
EOF

cat > .gitignore <<'EOF'
.DS_Store
*.log
.env
.env.*
!.env.example
EOF
```

## 24.4 빌드

```bash
docker build -t codyssey-e1-1-web:1.0 .
docker images
docker image inspect codyssey-e1-1-web:1.0
```

Dockerfile과 빌드 컨텍스트의 기준은 공식 문서를 사용합니다. [R8][R9]

---

# 25. 포트 매핑

```bash
# [Ubuntu]
docker rm -f e1-1-web 2>/dev/null || true

docker run -d \
  --name e1-1-web \
  -p 8080:80 \
  codyssey-e1-1-web:1.0
```

검증:

```bash
docker ps
docker logs e1-1-web
docker port e1-1-web
curl http://localhost:8080
```

Mac 브라우저:

```text
http://localhost:8080
```

스크린샷에는 주소창, 포트, 웹 응답을 함께 포함합니다. `-p 8080:80`은 Docker host의 8080을 컨테이너의 80에 연결합니다. [R10]

포트 충돌 확인:

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}'
```

기존 컨테이너를 임의 삭제하지 않고 대체 포트를 사용합니다.

```bash
docker run -d \
  --name e1-1-web-8081 \
  -p 8081:80 \
  codyssey-e1-1-web:1.0
```

---

# 26. 바인드 마운트

최종 제출용 `site/index.html`을 덮어쓰지 않도록 별도 디렉터리를 사용합니다.

```bash
# [Ubuntu]
cd ~/codyssey-training/codyssey-training-e1-1
mkdir -p bind-test

cat > bind-test/index.html <<'EOF'
<!doctype html>
<html lang="ko">
<head><meta charset="utf-8"><title>Bind Test</title></head>
<body><h1>바인드 마운트 최초 화면</h1></body>
</html>
EOF
```

실행:

```bash
docker rm -f e1-1-web e1-1-bind 2>/dev/null || true

docker run -d \
  --name e1-1-bind \
  -p 8080:80 \
  -v "$PWD/bind-test:/usr/share/nginx/html:ro" \
  nginx:alpine
```

최초 확인:

```bash
curl http://localhost:8080
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
```

재확인:

```bash
curl http://localhost:8080
```

이미지 재빌드 없이 바뀐 이유와 `:ro`의 의미를 기록합니다. [R11]

---

# 27. Docker 볼륨 영속성

```bash
# [Ubuntu]
docker volume create e1-1-data
docker volume ls
```

첫 번째 컨테이너:

```bash
docker rm -f e1-1-volume-1 2>/dev/null || true

docker run -d \
  --name e1-1-volume-1 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity
```

데이터 작성:

```bash
docker exec e1-1-volume-1 \
  bash -lc 'echo "persistent data" > /data/result.txt && cat /data/result.txt'
```

컨테이너 삭제:

```bash
docker rm -f e1-1-volume-1
```

새 컨테이너:

```bash
docker rm -f e1-1-volume-2 2>/dev/null || true

docker run -d \
  --name e1-1-volume-2 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity
```

데이터 확인:

```bash
docker exec e1-1-volume-2 cat /data/result.txt
```

`persistent data`가 출력되어야 합니다. [R12][R13]

---

# 28. Git·PR 현황 기록 문서

`docs/git-workflow.md`를 작성합니다.

```markdown
# Git·GitHub 작업 기록

## 저장소
- Remote:
- Default branch:
- Git protocol:
- gh 로그인 계정:

## 작업 기록

| 날짜 | 브랜치 | 작업 목적 | 주요 파일 | commit SHA | PR | 상태 |
|---|---|---|---|---|---|---|
| YYYY-MM-DD | docs/environment-baseline | 환경 기록 | docs/environment.md | abc1234 | #1 | merged |

## 현재 상태

```bash
$ git status -sb

$ git branch -vv

$ git log --oneline --graph --decorate --all -15

$ gh pr status --conflict-status
```

## 병합 결과
- PR URL:
- 병합 방식:
- merge commit 또는 squash commit:
- Default branch 반영 확인:
```

## 단계별 현황 명령

```bash
git status -sb
git diff --stat
git diff --cached --stat
git log --oneline --graph --decorate --all -15
git branch -vv
gh status
gh pr status --conflict-status
gh pr list --state all --limit 20
```

실제 출력에서 토큰·민감정보를 제거한 뒤 기록합니다.

---

# 29. 요구사항·테스트·증거 추적

`docs/requirement-traceability.md` 예시:

| ID | 요구사항 | 구현·실습 | 검증 명령 | 증거 | PR·commit | 상태 |
|---|---|---|---|---|---|---|
| ENV-01 | Ubuntu 24.04 | `codyssey-training` | `cat /etc/os-release` | environment | #1 / SHA | ⬜ |
| ENV-02 | OrbStack Docker | command link | `docker version` | docker 화면 | #1 / SHA | ⬜ |
| GH-01 | gh 인증 | GitHub CLI | `gh auth status` | git 문서 | #1 / SHA | ⬜ |
| GH-02 | branch·PR | PR workflow | `gh pr status` | PR URL | #1 / SHA | ⬜ |
| CLI-01 | 터미널 조작 | `practice/` | `pwd`, `ls -la` | terminal | PR / SHA | ⬜ |
| PERM-01 | 권한 변경 | file·directory | `ls -l`, `ls -ld` | permissions | PR / SHA | ⬜ |
| DOC-01 | Docker 점검 | Engine | `docker info` | docker | PR / SHA | ⬜ |
| IMG-01 | 커스텀 이미지 | Dockerfile | `docker build` | build log | PR / SHA | ⬜ |
| PORT-01 | 포트 매핑 | `8080:80` | `curl` | 브라우저 | PR / SHA | ⬜ |
| MOUNT-01 | 바인드 마운트 | `bind-test/` | 변경 비교 | mount | PR / SHA | ⬜ |
| VOL-01 | 볼륨 영속성 | `e1-1-data` | 삭제 전후 `cat` | volume | PR / SHA | ⬜ |
| TS-01 | 문제 해결 2건 | troubleshooting | 재현·복구 | 문서 | PR / SHA | ⬜ |
| SEC-01 | 민감정보 | 전체 | diff·grep | 점검 기록 | PR / SHA | ⬜ |

---

# 30. clean clone 재현 시험

기존 실습과 이름·포트가 충돌하지 않도록 별도 디렉터리와 포트를 사용합니다.

## 30.1 기존 상태 확인

```bash
# [Ubuntu]
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
docker volume inspect e1-1-data
```

## 30.2 새 디렉터리 clone

```bash
cd ~
mkdir -p ~/codyssey-reproduction
cd ~/codyssey-reproduction

gh repo clone MetaStudy999/codyssey-training-e1-1
git -C codyssey-training-e1-1 status -sb
cd codyssey-training-e1-1
```

## 30.3 별도 이름으로 재현

```bash
docker build -t codyssey-e1-1-web:retest .

docker rm -f e1-1-retest 2>/dev/null || true

docker run -d \
  --name e1-1-retest \
  -p 18080:80 \
  codyssey-e1-1-web:retest

curl http://localhost:18080
```

정상 기준:

- 문서만 보고 빌드 성공
- `18080`에서 웹 응답
- 추가 설명 없이 실행 가능
- 누락 파일 없음

재현 결과를 `docs/test-results.md`에 기록하고 작업 branch에서 commit·push·PR 갱신합니다.

---

# 31. 보안과 민감정보

commit 전:

```bash
git status -sb
git diff
git diff --cached

git grep -n -i -E 'token|password|secret|private.?key' || true
find . -maxdepth 4 -type f \
  \( -name '.env' -o -name '*.pem' -o -name 'id_rsa' -o -name 'hosts.yml' \)
```

포함하면 안 되는 정보:

- GitHub token
- 비밀번호·인증 코드
- SSH 개인키
- `~/.config/gh/hosts.yml`
- `.env` 비밀값
- 학교·회사 내부 주소

노출 시:

1. 추가 push 중지
2. 비밀값 폐기·교체
3. Git history 제거 필요성 확인
4. 공식 문서에 따라 조치
5. 공개 기록에는 비밀값 자체를 쓰지 않음

파일만 삭제하는 것으로는 이미 commit된 secret 문제가 해결되지 않을 수 있습니다. [R19][R20]

---

# 32. 트러블슈팅

`docs/troubleshooting.md`에 최소 2건 작성합니다.

```markdown
## 문제 ID: TS-01

- 발생 환경:
- branch:
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

권장 주제:

- `gh auth login` 또는 credential 문제
- push 권한·인증 오류
- branch 또는 upstream 미설정
- PR에 의도하지 않은 파일 포함
- Docker Engine 연결 실패
- command link 오류
- Docker build 경로 오류
- 포트 충돌
- 바인드 마운트 경로 오류
- 컨테이너 이름 중복

---

# 33. 40시간 권장 학습계획

| 단계 | 시간 | 내용 | 결과물 |
|---|---:|---|---|
| 1 | 2시간 | 미션·용어·요구사항 | 요구사항 표 |
| 2 | 3시간 | OrbStack·Ubuntu | 환경 기준선 |
| 3 | 3시간 | Docker 연결·경로 시험 | hello-world·path test |
| 4 | 3시간 | gh 설치·인증·clone | 인증·remote 증거 |
| 5 | 4시간 | branch·add·commit·push | commit 기록 |
| 6 | 3시간 | Draft PR·상태·diff·merge | PR 기록 |
| 7 | 3시간 | 터미널·경로 | CLI 로그 |
| 8 | 3시간 | 권한 | 전후 비교 |
| 9 | 4시간 | Docker 운영 | 운영 로그 |
| 10 | 4시간 | Dockerfile·포트 | 웹 이미지·접속 |
| 11 | 3시간 | 바인드 마운트 | 변경 증거 |
| 12 | 2시간 | 볼륨 영속성 | 삭제 전후 증거 |
| 13 | 2시간 | 문서·트러블슈팅 | 문제 2건 |
| 14 | 1시간 | clean clone·평가 준비 | 최종 점검 |
| 합계 | 40시간 |  |  |

---

# 34. 품질 게이트

## Gate 0. 환경

- [ ] OrbStack 실행
- [ ] Ubuntu 24.04 `codyssey-training`
- [ ] 네트워크 정상
- [ ] `docker version`, `docker info`, `hello-world` 성공
- [ ] Docker build·bind path 사전 시험 성공

## Gate 1. GitHub CLI

- [ ] `gh --version`
- [ ] `gh auth status`
- [ ] `gh auth setup-git`
- [ ] `gh repo clone` 성공
- [ ] remote와 계정 확인

## Gate 2. Git 작업

- [ ] `main` 최신화
- [ ] 작업 branch 생성
- [ ] `status → diff → add → cached diff → commit`
- [ ] 의미 있는 commit 메시지
- [ ] 첫 push의 `-u`
- [ ] force push 미사용

## Gate 3. Pull Request

- [ ] Draft PR 생성
- [ ] PR 본문·검증·증거 작성
- [ ] `gh pr diff` 확인
- [ ] checks·충돌 상태 확인
- [ ] Ready 전환
- [ ] 정책에 맞게 merge
- [ ] Default branch 반영 확인

## Gate 4. 미션 기능

- [ ] 터미널·권한
- [ ] Docker 기본 운영
- [ ] Dockerfile
- [ ] 포트 매핑
- [ ] 바인드 마운트
- [ ] 볼륨 영속성

## Gate 5. 제출

- [ ] README와 docs 완성
- [ ] 트러블슈팅 2건 이상
- [ ] 요구사항·증거·PR·commit 연결
- [ ] 민감정보 없음
- [ ] clean clone 재현
- [ ] Default branch 평가 가능

---

# 35. 시험·동료평가 대비

## 시연 순서

1. 미션 목표
2. OrbStack·Ubuntu·Docker 구조
3. Docker 연결과 경로 사전 시험
4. GitHub CLI 인증 방식
5. branch 생성 이유
6. add 방법과 staging 확인
7. 의미 있는 commit 이력
8. push와 upstream
9. Draft PR 생성과 진행상태 관리
10. PR diff·checks·merge 방식
11. 터미널·권한
12. Dockerfile·포트
13. 바인드 마운트·볼륨
14. 트러블슈팅
15. clean clone
16. 보안 점검

## 예상 질문

1. `git add`와 `git commit`은 무엇이 다른가?
2. `git add -p`, `git add -u`, `git add -A`의 차이는 무엇인가?
3. 왜 `main`에 직접 작업하지 않았는가?
4. Draft PR은 왜 사용하는가?
5. 같은 PR에 추가 commit을 어떻게 반영하는가?
6. merge·squash·rebase의 차이는 무엇인가?
7. `git status -sb`와 `gh pr status`는 무엇을 확인하는가?
8. push가 거절될 때 force push하지 않고 무엇을 확인하는가?
9. Docker machine과 컨테이너 차이는 무엇인가?
10. 바인드 마운트와 볼륨을 비교하라.

---

# 36. 보너스 과제

## 36.1 Docker Compose

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

## 36.2 GitHub Issue 기반 작업 관리

```bash
gh issue create --title "E1-1 볼륨 영속성 검증" --body "검증 명령과 증거를 기록한다."
gh issue list --state open
```

PR 본문에 `Closes #번호`를 연결합니다.

## 36.3 PR 리뷰 연습

동료 PR을 checkout하고 README 절차를 재현한 뒤 구체적 리뷰를 작성합니다.

```bash
gh pr checkout <번호>
gh pr diff <번호>
gh pr review <번호> --comment --body "재현한 명령, 확인 결과, 개선점을 기록"
```

---

# 37. 최종 제출 체크리스트

## 환경

- [ ] OrbStack·Ubuntu 24.04
- [ ] Docker Engine 연결
- [ ] Docker path test
- [ ] 네트워크 확인

## GitHub CLI·Git

- [ ] gh 설치·인증
- [ ] credential helper
- [ ] gh repo clone
- [ ] 작업 branch
- [ ] 선택적 staging
- [ ] 의미 있는 commit
- [ ] push upstream
- [ ] PR 생성·검토·병합
- [ ] Git graph 캡처

## Docker

- [ ] version·info
- [ ] images·ps·logs·stats
- [ ] hello-world
- [ ] Ubuntu 컨테이너
- [ ] Dockerfile·custom image
- [ ] 포트 매핑
- [ ] 바인드 마운트
- [ ] 볼륨 영속성

## 문서·평가

- [ ] README
- [ ] 환경·Git·Docker 문서
- [ ] 트러블슈팅 2건 이상
- [ ] 요구사항 추적표
- [ ] 테스트 결과
- [ ] 증거 인덱스
- [ ] PR·commit 연결
- [ ] 민감정보 점검
- [ ] clean clone
- [ ] Default branch 확인
- [ ] 구두 설명 준비

---

# 38. 공식 참고문헌

> 확인일: **2026-08-02**  
> 제품·프로젝트 공식 문서를 우선합니다. 설치 버전에 따라 옵션이 다를 수 있으므로 `--help`와 공식 문서를 함께 확인합니다.

## OrbStack

- **[R1] OrbStack, What is OrbStack?**  
  <https://docs.orbstack.dev/>
- **[R2] OrbStack, Linux machines**  
  <https://docs.orbstack.dev/machines/>
- **[R3] OrbStack, Commands**  
  <https://docs.orbstack.dev/machines/commands>
- **[R4] OrbStack, Linux distributions**  
  <https://docs.orbstack.dev/machines/distros>
- **[R5] OrbStack, File sharing**  
  <https://docs.orbstack.dev/machines/file-sharing>
- **[R6] OrbStack, Docker containers**  
  <https://docs.orbstack.dev/docker/>

## Docker

- **[R7] Docker, Reference documentation**  
  <https://docs.docker.com/reference/>
- **[R8] Docker, Dockerfile reference**  
  <https://docs.docker.com/reference/dockerfile>
- **[R9] Docker, Build context and .dockerignore**  
  <https://docs.docker.com/build/concepts/context/>
- **[R10] Docker, Port publishing and mapping**  
  <https://docs.docker.com/engine/network/port-publishing/>
- **[R11] Docker, Bind mounts**  
  <https://docs.docker.com/engine/storage/bind-mounts/>
- **[R12] Docker, Storage**  
  <https://docs.docker.com/engine/storage/>
- **[R13] Docker, Volumes**  
  <https://docs.docker.com/engine/storage/volumes/>

## Git·Linux

- **[R14] Git Project, Git Reference**  
  <https://git-scm.com/docs>
- **[R15] GNU Project, chmod invocation**  
  <https://www.gnu.org/software/coreutils/manual/html_node/chmod-invocation.html>
- **[R16] GNU Project, GNU Coreutils Manual**  
  <https://www.gnu.org/software/coreutils/manual/coreutils.html>
- **[R28] Git Project, git-add Documentation**  
  <https://git-scm.com/docs/git-add>

## GitHub·GitHub CLI·VS Code

- **[R17] GitHub Docs, Set up Git**  
  <https://docs.github.com/en/get-started/git-basics/set-up-git>
- **[R18] GitHub Docs, Cloning a repository**  
  <https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository>
- **[R19] GitHub Docs, Remediating a leaked secret**  
  <https://docs.github.com/en/code-security/tutorials/remediate-leaked-secrets/remediating-a-leaked-secret>
- **[R20] GitHub Docs, Removing sensitive data**  
  <https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository>
- **[R21] Visual Studio Code, Source Control**  
  <https://code.visualstudio.com/docs/sourcecontrol/overview/>
- **[R22] Visual Studio Code, GitHub in VS Code**  
  <https://code.visualstudio.com/docs/sourcecontrol/github>
- **[R23] GitHub Docs, Connecting to GitHub with SSH**  
  <https://docs.github.com/en/authentication/connecting-to-github-with-ssh>
- **[R24] GitHub CLI, Installing gh on Linux and BSD**  
  <https://github.com/cli/cli/blob/trunk/docs/install_linux.md>
- **[R25] GitHub CLI, gh auth login**  
  <https://cli.github.com/manual/gh_auth_login>
- **[R26] GitHub CLI, gh auth setup-git**  
  <https://cli.github.com/manual/gh_auth_setup-git>
- **[R27] GitHub CLI, gh repo clone**  
  <https://cli.github.com/manual/gh_repo_clone>
- **[R29] GitHub CLI, gh pr create**  
  <https://cli.github.com/manual/gh_pr_create>
- **[R30] GitHub CLI, gh pr status**  
  <https://cli.github.com/manual/gh_pr_status>
- **[R31] GitHub CLI, gh pr checks**  
  <https://cli.github.com/manual/gh_pr_checks>
- **[R32] GitHub CLI, gh pr merge**  
  <https://cli.github.com/manual/gh_pr_merge>
- **[R33] GitHub CLI, gh pr diff**  
  <https://cli.github.com/manual/gh_pr_diff>
- **[R34] GitHub CLI, gh pr edit**  
  <https://cli.github.com/manual/gh_pr_edit>
- **[R35] GitHub CLI, gh pr ready**  
  <https://cli.github.com/manual/gh_pr_ready>

---

## 최종 완료 정의

> `codyssey-training` Ubuntu 24.04 machine에서 작업했다.  
> Ubuntu의 Docker 명령은 OrbStack Docker Engine에 정상 연결된다.  
> GitHub CLI로 인증·clone·PR 상태 확인을 수행했다.  
> 작업은 branch에서 의미 단위로 add·commit·push했다.  
> Draft PR에서 진행상황을 기록하고 diff·checks를 확인한 뒤 병합했다.  
> 터미널·권한·Dockerfile·포트·마운트·볼륨 실습을 직접 검증했다.  
> 모든 요구사항은 문서·증거·commit·PR과 연결되어 있다.  
> 평가자는 Default branch의 문서만 보고 같은 결과를 재현할 수 있다.
