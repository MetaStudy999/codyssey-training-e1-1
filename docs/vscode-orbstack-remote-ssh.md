# OrbStack Ubuntu와 VS Code Remote-SSH 연결

> 대상 환경: macOS + OrbStack + Ubuntu 24.04 machine `codyssey-training`

## 1. 연결 원칙

- Mac 터미널에서 Ubuntu 대화형 셸을 사용할 때는 `orb -m codyssey-training`을 사용합니다.
- VS Code에서 Ubuntu 파일·Git·터미널·확장을 사용하려면 **Remote - SSH**로 연결합니다.
- 기본 방법은 Mac 터미널에서 `code --remote`로 원격 host와 원격 작업 디렉터리를 동시에 여는 방식입니다.
- GUI의 `Remote-SSH: Connect to Host...`는 CLI 실행이 실패했을 때 사용하는 대체 방법입니다.
- Ubuntu 안에서 `code .`만 실행한 결과를 Remote-SSH 성공으로 판정하지 않습니다.
- OrbStack에는 SSH 서버가 내장되어 있으므로 Ubuntu에 `openssh-server`를 설치하거나 `sshd_config`를 수정하지 않습니다.

---

## 2. Mac에서 SSH 사전 확인

```bash
# [macOS]
orb status
orb list
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

- Ubuntu 24.04 또는 `VERSION_CODENAME=noble`
- OrbStack key 인증으로 접속
- `exit` 후 Mac 터미널로 복귀

SSH가 실패하면 다음 단계로 넘어가지 않습니다.

```bash
# [macOS: 오류 시]
ssh -G codyssey-training@orb | head -n 30
orb status
orb info codyssey-training
orb ssh
```

---

## 3. 관리자 권한 없이 VS Code CLI 찾기

### 3.1 먼저 PATH의 `code` 확인

```bash
# [macOS]
command -v code || true
code --version 2>/dev/null || true
```

명령이 정상이라면:

```bash
CODE_BIN="$(command -v code)"
```

### 3.2 `code: command not found`일 때

Mac VS Code에서 다음을 실행할 수 있습니다.

```text
Shift + Command + P
→ Shell Command: Install 'code' command in PATH
```

학교 iMac에서 권한 문제로 실패하면 시스템 경로에 링크를 만들지 않고 앱 내부 CLI를 직접 찾습니다.

```bash
# [macOS]
CODE_BIN=""

for candidate in \
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
  "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
do
  if [ -x "$candidate" ]; then
    CODE_BIN="$candidate"
    break
  fi
done

if [ -z "$CODE_BIN" ]; then
  echo "[FAIL] VS Code CLI를 찾지 못했습니다."
  exit 1
fi

printf 'CODE_BIN=%s\n' "$CODE_BIN"
"$CODE_BIN" --version
```

이 방식은 `/usr/local/bin` 등에 링크를 생성하지 않습니다.

### 3.3 `--remote` 지원 확인

```bash
"$CODE_BIN" --help | grep -E -- '--remote|--folder-uri'
```

출력이 없으면 다음을 확인합니다.

```bash
type -a code 2>/dev/null || true
"$CODE_BIN" --version
```

오래된 VS Code나 다른 프로그램의 `code`를 실행하고 있을 수 있습니다.

---

## 4. Remote - SSH 확장 확인

```bash
# [macOS]
"$CODE_BIN" --list-extensions \
  | grep -Fx 'ms-vscode-remote.remote-ssh' || true
```

출력이 없을 때 설치합니다.

```bash
"$CODE_BIN" --install-extension ms-vscode-remote.remote-ssh
```

정상 기준:

```text
ms-vscode-remote.remote-ssh
```

---

## 5. VS Code Server 원격 요구사항 확인

Mac 터미널에서 실행합니다.

```bash
# [macOS]
ssh codyssey-training@orb '
  command -v bash &&
  command -v tar &&
  { command -v curl || command -v wget; } &&
  test -w "$HOME" &&
  df -h "$HOME"
'
```

정상 기준:

- `bash` 경로 출력
- `tar` 경로 출력
- `curl` 또는 `wget` 경로 출력
- HOME 디렉터리 쓰기 가능
- 디스크 여유 공간 확인

저장소에 포함된 점검 스크립트도 사용할 수 있습니다.

```bash
bash scripts/preflight-macos.sh
```

> 이 스크립트는 저장소 clone 이후 Mac에서 실행합니다.

---

## 6. CLI로 원격 workspace 열기

### 6.1 원격 저장소 존재 확인

```bash
# [macOS]
ssh codyssey-training@orb \
  'test -d "$HOME/codyssey-training/codyssey-training-e1-1" && echo "REMOTE_DIR_OK"'
```

예상 출력:

```text
REMOTE_DIR_OK
```

출력이 없으면 clone과 작업 branch 생성을 먼저 완료합니다.

### 6.2 Ubuntu 절대 경로 계산

```bash
# [macOS]
REMOTE_DIR="$(ssh codyssey-training@orb \
  'printf "%s/codyssey-training/codyssey-training-e1-1" "$HOME"')"

printf 'REMOTE_DIR=%s\n' "$REMOTE_DIR"
```

정상 예시:

```text
REMOTE_DIR=/home/사용자명/codyssey-training/codyssey-training-e1-1
```

Mac 터미널에서 `~/codyssey-training/...`를 직접 쓰지 않습니다. 그 `~`는 Mac 사용자의 home으로 해석될 수 있습니다.

### 6.3 기본 실행 명령

```bash
# [macOS]
"$CODE_BIN" --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$REMOTE_DIR/"
```

의미:

- `--new-window`: 기존 Mac 로컬 창과 분리
- `--remote`: `codyssey-training@orb`에 Remote-SSH 연결
- `"$REMOTE_DIR/"`: Ubuntu의 저장소 폴더 열기
- 마지막 `/`: 파일이 아니라 폴더임을 명확히 표시

### 6.4 한 번에 실행하는 축약 명령

사전 확인을 모두 통과한 뒤에만 사용합니다.

```bash
# [macOS]
"$CODE_BIN" --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$(ssh codyssey-training@orb \
    'printf "%s/codyssey-training/codyssey-training-e1-1/" "$HOME"')"
```

초보자의 첫 수행은 6.1 → 6.2 → 6.3 순서가 기본입니다.

---

## 7. GUI 대체 방법

CLI가 실패했을 때만 사용합니다.

1. VS Code에서 `Shift + Command + P`
2. `Remote-SSH: Connect to Host...`
3. `codyssey-training@orb` 선택
4. 플랫폼을 묻는 경우 `Linux` 선택
5. VS Code Server 설치 완료까지 대기
6. `File → Open Folder...`
7. `~/codyssey-training/codyssey-training-e1-1` 열기

연결 로그:

```text
View → Output → Remote - SSH
```

---

## 8. 원격 창과 통합 터미널 검증

VS Code에서 확인합니다.

- 새 창이 열렸다.
- 왼쪽 아래 Remote indicator가 SSH 연결을 표시한다.
- Explorer 최상단이 `codyssey-training-e1-1`이다.

다음 메뉴로 새 터미널을 엽니다.

```text
Terminal → New Terminal
```

다음 스크립트를 실행합니다.

```bash
# [VS Code Ubuntu]
bash scripts/verify-vscode-remote.sh
```

직접 확인하려면:

```bash
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
| 셸 | Bash 또는 Ubuntu 사용자 셸 |
| `pwd` | Ubuntu 저장소 경로 |
| Git root | 같은 저장소 경로 |
| branch | `feat/e1-1-complete` |
| 상태 표시줄 | SSH 원격 연결 표시 |

실패 사례:

- `/Users/...` 경로가 출력됨
- Remote indicator가 없음
- 현재 branch가 `main`
- `git rev-parse`가 저장소가 아니라고 출력

---

## 9. 저장소 터미널 설정

`.vscode/settings.json`:

```json
{
  "terminal.integrated.cwd": "${workspaceFolder}",
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.splitCwd": "workspaceRoot"
}
```

새 터미널은 Linux Bash와 workspace root에서 시작해야 합니다.

다음 명령은 Mac 로컬 터미널을 열 수 있으므로 E1-1에서는 사용하지 않습니다.

```text
Terminal: Create New Integrated Terminal (Local)
```

---

## 10. 중단 후 다시 시작하기

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
REMOTE_DIR
WORK_BRANCH
HOST_PORT
PR_NUMBER
SOURCE_DIR
CURRENT_BRANCH
RETEST_DIR
```

Mac에서는 `CODE_BIN`과 `REMOTE_DIR`을 다시 계산합니다. Ubuntu에서 `.env.local`이 있다면 다음처럼 포트를 다시 읽습니다.

```bash
source .env.local
```

---

## 11. 오류 대응

### `code: command not found`

- `Shell Command: Install 'code' command in PATH` 시도
- 권한 실패 시 앱 내부 `CODE_BIN` 사용

### Remote - SSH 확장 없음

```bash
"$CODE_BIN" --install-extension ms-vscode-remote.remote-ssh
```

### 원격 경로 없음

```bash
ssh codyssey-training@orb \
  'printf "HOME=%s\n" "$HOME"; ls -ld "$HOME/codyssey-training/codyssey-training-e1-1"'
```

### Mac 로컬 폴더가 열림

다음 명령은 사용하지 않습니다.

```bash
code ~/codyssey-training/codyssey-training-e1-1
```

반드시 `--remote`와 Ubuntu 절대 경로를 함께 사용합니다.

### VS Code Server 설치 실패

```text
View → Output → Remote - SSH
```

로그에서 네트워크, 디스크 공간, HOME 쓰기 권한, `tar`, `curl` 또는 `wget`을 확인합니다.

---

## 12. 보안 주의

- `~/.orbstack/ssh/id_ed25519`를 출력하거나 저장소에 복사하지 않습니다.
- `~/.ssh/config` 전체 내용을 스크린샷으로 공개하지 않습니다.
- GitHub token·브라우저 인증 코드를 촬영하지 않습니다.
- 외부 기기에서 OrbStack SSH로 직접 접속하는 구성은 이 미션 범위가 아닙니다.

## 공식 참고문헌

- OrbStack SSH access: <https://docs.orbstack.dev/machines/ssh>
- OrbStack commands: <https://docs.orbstack.dev/machines/commands>
- VS Code Remote Development using SSH: <https://code.visualstudio.com/docs/remote/ssh>
- VS Code command line: <https://code.visualstudio.com/docs/configure/command-line>
- VS Code macOS setup: <https://code.visualstudio.com/docs/setup/mac>
- VS Code terminal basics: <https://code.visualstudio.com/docs/terminal/basics>
