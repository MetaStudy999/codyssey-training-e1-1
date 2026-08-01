# OrbStack Ubuntu와 VS Code Remote-SSH 연결

> 대상 환경: macOS + OrbStack + Ubuntu 24.04 machine `codyssey-training`

## 1. 연결 원칙

- Mac 터미널에서 Ubuntu를 직접 실습할 때는 `orb -m codyssey-training`을 사용합니다.
- VS Code에서 Ubuntu 파일·Git·터미널·확장을 사용하려면 **Remote - SSH**로 연결합니다.
- 기본 실행 방법은 Mac 터미널에서 `code --remote`로 원격 host와 작업 디렉터리를 동시에 지정하는 방식입니다.
- GUI의 `Remote-SSH: Connect to Host...`와 `File → Open Folder...`는 CLI 실행이 실패할 때 사용하는 대체 방법입니다.
- Ubuntu 안에서 `code .`를 실행하는 것만으로는 현재 VS Code 창이 Remote-SSH 창인지 보장하지 않습니다.
- OrbStack에는 Linux machine용 SSH 서버가 내장되어 있으므로 Ubuntu에 `openssh-server`를 별도로 설치하거나 `sshd_config`를 수정하지 않습니다.
- OrbStack SSH는 Mac의 localhost를 통해 접근하며 비밀번호가 아니라 OrbStack이 생성한 키를 사용합니다.

## 2. Mac 터미널에서 SSH 사전 확인

```bash
# [macOS]
orb status
orb list
ssh codyssey-training@orb
```

처음 연결할 때 host key 확인이 표시되면 연결 대상이 `orb`인지 확인한 뒤 진행합니다.

SSH로 Ubuntu에 접속한 상태에서 실행합니다.

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
- 비밀번호 설치·입력 없이 OrbStack 키 인증으로 접속
- `exit` 후 Mac 터미널로 복귀

SSH가 실패하면 다음을 확인합니다.

```bash
# [macOS]
orb status
orb info codyssey-training
ssh -G codyssey-training@orb | head -n 30
orb ssh
```

`Permission denied`, `Connection refused`, host 선택 오류가 해결되기 전에는 VS Code 단계로 넘어가지 않습니다.

## 3. Mac의 VS Code CLI와 Remote - SSH 준비

### 3.1 `code` 명령 확인

```bash
# [macOS]
command -v code
code --version
code --help | grep -E -- '--remote|--folder-uri'
```

`code: command not found`가 나오면 Mac의 VS Code에서 다음을 실행합니다.

```text
Shift + Command + P
→ Shell Command: Install 'code' command in PATH
```

설치 후 Mac 터미널을 완전히 닫았다가 다시 열고 `code --version`을 확인합니다.

### 3.2 Remote - SSH 확장 확인과 설치

```bash
# [macOS]
code --list-extensions | grep -Fx 'ms-vscode-remote.remote-ssh' || \
  code --install-extension ms-vscode-remote.remote-ssh
```

정상 기준:

```text
ms-vscode-remote.remote-ssh
```

확장은 Mac 쪽 VS Code에 설치합니다.

## 4. CLI로 Remote-SSH host와 작업 디렉터리 동시에 열기

> 다음 명령은 **Mac 터미널에서 실행**합니다. Ubuntu 터미널에서 실행하지 않습니다.

### 4.1 원격 저장소 디렉터리 존재 확인

```bash
# [macOS]
ssh codyssey-training@orb \
  'test -d "$HOME/codyssey-training/codyssey-training-e1-1" && echo "REMOTE_DIR_OK"'
```

예상 출력:

```text
REMOTE_DIR_OK
```

출력이 없고 종료 코드가 실패하면 저장소 clone과 작업 브랜치 생성 단계를 먼저 완료합니다.

### 4.2 원격 절대 경로 구하기

Mac 터미널에서 `~/codyssey-training/...`를 직접 전달하면 `~`가 Mac 사용자의 home으로 해석될 수 있습니다. 먼저 Ubuntu의 `$HOME`을 조회해 원격 절대 경로를 만듭니다.

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

### 4.3 기본 실행 명령

```bash
# [macOS]
code --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$REMOTE_DIR/"
```

- `--remote "ssh-remote+codyssey-training@orb"`: OrbStack Ubuntu에 Remote-SSH로 연결
- `"$REMOTE_DIR/"`: Ubuntu 안의 작업 디렉터리를 열기
- 경로 끝의 `/`: VS Code가 해당 대상을 파일이 아니라 폴더로 판정하도록 명시
- `--new-window`: 기존 Mac 로컬 창과 분리된 새 원격 창으로 열기

### 4.4 한 번에 실행하는 명령

SSH 사전 확인과 clone이 이미 완료된 뒤에는 다음 한 줄도 사용할 수 있습니다.

```bash
# [macOS]
code --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$(ssh codyssey-training@orb \
    'printf "%s/codyssey-training/codyssey-training-e1-1/" "$HOME"')"
```

초보자 첫 수행에서는 오류 위치를 구분하기 쉬운 4.1 → 4.2 → 4.3 순서를 권장합니다.

## 5. CLI 실행 결과 확인

VS Code가 열린 뒤 다음을 확인합니다.

- 새 VS Code 창이 열렸다.
- 왼쪽 아래 상태 표시줄에 SSH 원격 연결 표시가 있다.
- Explorer 최상단 폴더가 `codyssey-training-e1-1`이다.
- 창 제목이나 Remote indicator가 `codyssey-training@orb` 연결을 나타낸다.

연결 로그:

```text
View → Output → Remote - SSH
```

플랫폼 선택이 나오면 `Linux`를 선택하고 VS Code Server 설치가 끝날 때까지 기다립니다.

## 6. GUI 대체 방법

CLI가 실패했을 때만 다음 절차를 사용합니다.

1. VS Code에서 `Shift + Command + P`
2. `Remote-SSH: Connect to Host...`
3. 다음 연결 대상을 입력 또는 선택

```text
codyssey-training@orb
```

4. 플랫폼 선택이 나오면 `Linux` 선택
5. 연결 후 `File → Open Folder...`
6. 다음 Ubuntu 폴더 열기

```text
~/codyssey-training/codyssey-training-e1-1
```

GUI 방식도 최종적으로는 CLI 방식과 같은 Remote-SSH host와 Ubuntu 작업 디렉터리를 열어야 합니다.

## 7. 통합 터미널 검증

Remote-SSH 창에서 기존 터미널을 재사용하지 말고 새 터미널을 엽니다.

```text
Terminal → New Terminal
```

다음 명령을 실행합니다.

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

- 운영체제: Ubuntu 24.04
- 셸 프로세스: `bash` 또는 사용자가 Ubuntu에 설정한 셸
- `pwd`: Ubuntu의 저장소 폴더
- Git 최상위 경로: 같은 저장소 폴더
- 현재 브랜치: `feat/e1-1-complete`
- VS Code 왼쪽 아래: SSH 원격 연결 표시

다음 중 하나라도 나오면 원격 연결 성공으로 판정하지 않습니다.

- 셸이 Mac의 `zsh`이고 경로가 `/Users/...`
- `pwd`가 저장소 밖의 home 디렉터리
- `git rev-parse`가 저장소가 아니라고 출력
- 현재 브랜치가 `main`
- 왼쪽 아래에 SSH 원격 표시가 없음

## 8. 저장소의 터미널 설정

이 저장소의 `.vscode/settings.json`은 Linux Remote-SSH 창에서 다음을 기본값으로 사용합니다.

```json
{
  "terminal.integrated.cwd": "${workspaceFolder}",
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.splitCwd": "workspaceRoot"
}
```

새 터미널은 열린 workspace root에서 Bash로 시작해야 합니다. 사용자 또는 Remote 설정이 우선순위상 충돌하면 `Preferences: Open Remote Settings (JSON)`에서 적용된 터미널 설정을 확인합니다.

## 9. 로컬 터미널과 원격 터미널 구분

Remote-SSH 창에서도 명령 팔레트의 다음 명령은 Mac 로컬 터미널을 열 수 있습니다.

```text
Terminal: Create New Integrated Terminal (Local)
```

E1-1 실습에서는 이를 사용하지 않습니다. 일반적인 `Terminal → New Terminal`을 사용하고 매번 `pwd`, `/etc/os-release`, `git branch --show-current`를 확인합니다.

## 10. 오류 대응

### 10.1 `code: command not found`

Mac VS Code에서 다음 명령을 실행하고 터미널을 다시 엽니다.

```text
Shell Command: Install 'code' command in PATH
```

### 10.2 `--remote` option을 찾을 수 없음

```bash
code --version
code --help | grep -- '--remote'
```

오래된 VS Code 또는 다른 `code` 실행 파일을 사용하고 있지 않은지 확인합니다.

```bash
type -a code
```

### 10.3 Remote - SSH 확장이 없음

```bash
code --install-extension ms-vscode-remote.remote-ssh
```

### 10.4 원격 경로가 없다고 나옴

```bash
ssh codyssey-training@orb \
  'printf "HOME=%s\n" "$HOME"; ls -ld "$HOME/codyssey-training/codyssey-training-e1-1"'
```

저장소가 다른 위치에 있으면 실제 Ubuntu 절대 경로를 `REMOTE_DIR`에 설정합니다.

### 10.5 Mac 로컬 폴더가 열림

다음을 사용하지 않습니다.

```bash
code ~/codyssey-training/codyssey-training-e1-1
```

이 명령의 `~`는 Mac home을 의미합니다. 반드시 `--remote`와 Ubuntu 절대 경로를 함께 사용합니다.

## 11. 연결 방식 비교

| 목적 | 방식 |
|---|---|
| Mac 터미널에서 Ubuntu 대화형 셸 | `orb -m codyssey-training` |
| SSH 기능 사전 확인 | `ssh codyssey-training@orb` |
| CLI로 원격 workspace 즉시 열기 | `code --remote "ssh-remote+codyssey-training@orb" "$REMOTE_DIR/"` |
| GUI로 원격 workspace 열기 | Remote-SSH → `codyssey-training@orb` → Open Folder |
| Mac VS Code만 열기 | Ubuntu의 `code .`는 보조 수단이며 Remote-SSH 성공 증거가 아님 |

## 12. 보안 주의

- `~/.orbstack/ssh/id_ed25519` 개인키를 저장소나 스크린샷에 포함하지 않습니다.
- `~/.ssh/config` 전체 내용을 공개하지 않습니다.
- `ssh -G` 출력에는 환경별 경로가 포함될 수 있으므로 공개 전 확인합니다.
- 학교 장비에서 OrbStack SSH는 기본적으로 Mac 로컬 접근용입니다.
- 다른 모바일 기기나 외부 PC에서 직접 접속하려면 별도 보안 설계가 필요하며 이 미션 범위에 포함하지 않습니다.

## 공식 참고문헌

- OrbStack SSH access: <https://docs.orbstack.dev/machines/ssh>
- OrbStack commands: <https://docs.orbstack.dev/machines/commands>
- VS Code command-line interface: <https://code.visualstudio.com/docs/configure/command-line>
- VS Code Remote Development using SSH: <https://code.visualstudio.com/docs/remote/ssh>
- VS Code Remote Development tips and tricks: <https://code.visualstudio.com/docs/remote/troubleshooting>
- VS Code Remote-SSH tutorial: <https://code.visualstudio.com/docs/remote/ssh-tutorial>
- VS Code terminal basics: <https://code.visualstudio.com/docs/terminal/basics>
- VS Code terminal profiles: <https://code.visualstudio.com/docs/terminal/profiles>
