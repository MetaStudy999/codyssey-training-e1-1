# E1-1 입문자 한 페이지 체크포인트

> 각 단계의 `[PASS]` 또는 정상 기준을 확인한 뒤 다음 단계로 이동합니다. 실패하면 다음 단계로 넘어가지 않습니다.

## 1. 전체 진행표

| 단계 | 실행 위치 | 핵심 확인 | 정상 기준 | 실패 시 |
|---|---|---|---|---|
| 1 | Mac | `orb status` | OrbStack 실행 중 | OrbStack 실행·권한 확인 |
| 2 | Mac | `orb info codyssey-training` | machine 정보 출력 | machine 생성 여부 확인 |
| 3 | Ubuntu | `/etc/os-release` | Ubuntu 24.04 noble | 잘못된 machine 중단 |
| 4 | Ubuntu | `docker version` | Client와 Server 표시 | `mac link docker`·OrbStack 확인 |
| 5 | Ubuntu | `gh auth status` | GitHub 로그인 계정 표시 | 브라우저 인증 재실행 |
| 6 | Ubuntu | `viewerPermission` | WRITE 이상 | 관리자에게 권한 요청 |
| 7 | Ubuntu | `git branch --show-current` | `feat/e1-1-complete` | 파일 수정 중단 후 branch 전환 |
| 8 | Mac | `ssh codyssey-training@orb` | Ubuntu 셸 접속 | SSH 진단 후 중단 |
| 9 | Mac | `code --remote ...` | 원격 workspace 새 창 | GUI 대체 절차 사용 |
| 10 | VS Code Ubuntu | `pwd`, OS, branch | Ubuntu 저장소·작업 branch | 원격 창 다시 열기 |
| 11 | VS Code Ubuntu | `git diff --cached` | 의도한 파일만 staging | staging 수정 |
| 12 | GitHub | Draft PR | 기존 작업 branch PR | 중복 PR 생성 금지 |
| 13 | VS Code Ubuntu | Docker 실습 | build·curl·mount·volume 성공 | 해당 단계에서 중단 |
| 14 | Ubuntu | clean clone | 새 폴더에서 build·HTTP 성공 | 병합 금지 |
| 15 | GitHub | PR checks | 통과 또는 CI 없음 기록 | 실패 해결 후 병합 |
| 16 | Ubuntu | `scripts/final-check.sh` | 모든 `[PASS]` | 완료 판정 금지 |

## 2. 처음 시작할 때

Mac 터미널:

```bash
orb status
orb list
```

Ubuntu에서 저장소를 clone하고 작업 branch를 만든 뒤:

```bash
bash scripts/preflight-ubuntu.sh
```

저장소가 Ubuntu에만 clone되어 있다면 Mac 사전 점검 스크립트를 임시 파일로 복사한 뒤 실행합니다.

```bash
# [macOS]
ssh codyssey-training@orb \
  'cat "$HOME/codyssey-training/codyssey-training-e1-1/scripts/preflight-macos.sh"' \
  > /tmp/e1-1-preflight-macos.sh

sed -n '1,220p' /tmp/e1-1-preflight-macos.sh
bash /tmp/e1-1-preflight-macos.sh
```

Mac에도 저장소를 별도로 clone한 경우에는 해당 저장소에서 직접 실행할 수 있습니다.

```bash
bash scripts/preflight-macos.sh
```

## 3. VS Code Remote-SSH 기본 실행

Mac 터미널에서 실행합니다.

```bash
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

REMOTE_DIR="$(ssh codyssey-training@orb \
  'printf "%s/codyssey-training/codyssey-training-e1-1" "$HOME"')"

"$CODE_BIN" --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$REMOTE_DIR/"
```

VS Code의 새 원격 터미널에서:

```bash
bash scripts/verify-vscode-remote.sh
```

## 4. 중단 후 다시 시작할 때

Mac:

```bash
orb status
ssh codyssey-training@orb
```

Ubuntu 또는 VS Code Remote-SSH 터미널:

```bash
cd ~/codyssey-training/codyssey-training-e1-1
bash scripts/resume-check.sh
```

터미널을 닫으면 다음 변수는 사라집니다.

```text
CODE_BIN
WORK_BRANCH
REMOTE_DIR
HOST_PORT
PR_NUMBER
SOURCE_DIR
CURRENT_BRANCH
RETEST_DIR
```

`HOST_PORT`는 `.env.local`이 있다면 다음처럼 다시 불러옵니다.

```bash
source .env.local
```

나머지 변수는 사용 직전에 문서의 명령으로 다시 계산합니다.

## 5. 기존 branch와 PR 재사용

```bash
WORK_BRANCH="feat/e1-1-complete"

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

기존 PR 확인:

```bash
gh pr list \
  --head "$WORK_BRANCH" \
  --base main \
  --state open
```

기존 PR이 표시되면 새 PR을 만들지 않고 같은 branch에 계속 push합니다.

## 6. 스크린샷 규칙

권장 파일명:

```text
docs/screenshots/vscode/01-remote-ssh-status.png
docs/screenshots/vscode/02-ubuntu-shell-path.png
docs/screenshots/vscode/03-git-branch.png
docs/screenshots/docker/01-docker-version.png
docs/screenshots/port/01-browser-response.png
docs/screenshots/mount/01-bind-before.png
docs/screenshots/mount/02-bind-after.png
docs/screenshots/volume/01-volume-persistence.png
```

촬영 전 확인:

- GitHub token·인증 코드가 보이지 않는다.
- SSH 개인키와 설정 파일 내용이 보이지 않는다.
- 학교 내부 주소·계정 정보가 보이지 않는다.
- 브라우저의 불필요한 탭과 개인정보가 보이지 않는다.
- 현재 실행 위치와 성공 결과가 함께 보인다.

## 7. 최종 검증과 정리

병합 후 `main`에서:

```bash
git switch main
git pull --ff-only origin main
bash scripts/final-check.sh
```

제출과 증거 확인이 모두 끝난 뒤 E1-1 자원만 정리합니다.

```bash
bash scripts/cleanup-e1-1.sh
```

다음 명령은 사용하지 않습니다.

```bash
docker system prune
docker system prune -a
git push --force
```
