# OrbStack Ubuntu와 VS Code Remote-SSH 연결

> 대상 환경: macOS + OrbStack + Ubuntu 24.04 machine `codyssey-training`

## 1. 연결 원칙

- Mac 터미널에서 Ubuntu를 직접 실습할 때는 `orb -m codyssey-training`을 사용합니다.
- VS Code에서 Ubuntu 파일·Git·터미널·확장을 사용하려면 **Remote - SSH**로 연결합니다.
- Ubuntu 안에서 `code .`를 실행하는 것만으로는 현재 VS Code 창이 Remote-SSH 창인지 보장하지 않습니다.
- OrbStack에는 Linux machine용 SSH 서버가 내장되어 있으므로 Ubuntu에 `openssh-server`를 별도로 설치하거나 `sshd_config`를 수정하지 않습니다.
- OrbStack SSH는 Mac의 `localhost`에서만 접근하며 비밀번호가 아니라 OrbStack이 생성한 키를 사용합니다.

## 2. Mac 터미널에서 SSH 사전 확인

```bash
# [macOS]
orb status
orb list
ssh codyssey-training@orb
```

처음 연결할 때 호스트 키 확인이 표시되면 호스트가 `orb`인지 확인한 뒤 진행합니다.

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

`Permission denied`, `Connection refused`, 호스트 선택 오류가 해결되기 전에는 VS Code 단계로 넘어가지 않습니다.

## 3. VS Code 확장 설치

Mac의 VS Code에서 Extensions 화면을 열고 다음 확장을 설치합니다.

```text
Remote - SSH
확장 ID: ms-vscode-remote.remote-ssh
```

설치는 **Mac 쪽 VS Code**에서 먼저 수행합니다.

## 4. Remote-SSH 연결

1. VS Code에서 `Shift + Command + P`를 누릅니다.
2. `Remote-SSH: Connect to Host...`를 실행합니다.
3. 다음 연결 대상을 입력하거나 선택합니다.

```text
codyssey-training@orb
```

4. 플랫폼 선택이 나오면 `Linux`를 선택합니다.
5. VS Code Server 설치가 끝날 때까지 기다립니다.
6. 왼쪽 아래 상태 표시줄에 SSH 원격 연결 표시가 있는지 확인합니다.

연결 로그가 필요하면 다음 메뉴를 사용합니다.

```text
View → Output → Remote - SSH
```

## 5. Ubuntu 저장소 폴더 열기

Remote-SSH 창에서 다음 메뉴를 선택합니다.

```text
File → Open Folder...
```

열 폴더:

```text
~/codyssey-training/codyssey-training-e1-1
```

Explorer 최상단 폴더가 `codyssey-training-e1-1`인지 확인합니다.

## 6. 통합 터미널 검증

Remote-SSH 창에서 기존 터미널을 재사용하지 말고 새 터미널을 엽니다.

```text
Terminal → New Terminal
```

다음 명령을 실행합니다.

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

- 운영체제: Ubuntu 24.04
- 셸 프로세스: `bash` 또는 사용자가 Ubuntu에 설정한 셸
- `pwd`: 저장소 폴더
- Git 최상위 경로: 같은 저장소 폴더
- 현재 브랜치: `feat/e1-1-complete`
- VS Code 왼쪽 아래: SSH 원격 연결 표시

다음 중 하나라도 나오면 원격 연결 성공으로 판정하지 않습니다.

- 셸이 Mac의 `zsh`이고 경로가 `/Users/...`
- `pwd`가 저장소 밖의 홈 디렉터리
- `git rev-parse`가 저장소가 아니라고 출력
- 현재 브랜치가 `main`
- 왼쪽 아래에 SSH 원격 표시가 없음

## 7. 저장소의 터미널 설정

이 저장소의 `.vscode/settings.json`은 Linux Remote-SSH 창에서 다음을 기본값으로 사용합니다.

```json
{
  "terminal.integrated.cwd": "${workspaceFolder}",
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.splitCwd": "workspaceRoot"
}
```

새 터미널은 열린 workspace 루트에서 Bash로 시작해야 합니다. 사용자 또는 Remote 설정이 우선순위상 충돌하면 `Preferences: Open Remote Settings (JSON)`에서 수정된 터미널 설정을 확인합니다.

## 8. 로컬 터미널과 원격 터미널 구분

Remote-SSH 창에서도 명령 팔레트의 다음 명령은 Mac 로컬 터미널을 열 수 있습니다.

```text
Terminal: Create New Integrated Terminal (Local)
```

E1-1 실습에서는 이를 사용하지 않습니다. 일반적인 `Terminal → New Terminal`을 사용하고 매번 `pwd`, `/etc/os-release`, `git branch --show-current`를 확인합니다.

## 9. 연결 방식 비교

| 목적 | 방식 |
|---|---|
| Mac 터미널에서 Ubuntu 대화형 셸 | `orb -m codyssey-training` |
| SSH 기능 사전 확인 | `ssh codyssey-training@orb` |
| VS Code 원격 편집·원격 터미널 | Remote-SSH → `codyssey-training@orb` |
| Mac VS Code만 열기 | Ubuntu의 `code .`는 보조 수단이며 Remote-SSH 성공 증거가 아님 |

## 10. 보안 주의

- `~/.orbstack/ssh/id_ed25519` 개인키를 저장소나 스크린샷에 포함하지 않습니다.
- `~/.ssh/config` 전체 내용을 공개하지 않습니다.
- 학교 장비에서 OrbStack SSH는 기본적으로 Mac 로컬 접근용입니다.
- 다른 모바일 기기나 외부 PC에서 직접 접속하려면 별도 보안 설계가 필요하며 이 미션 범위에 포함하지 않습니다.

## 공식 참고문헌

- OrbStack SSH access: <https://docs.orbstack.dev/machines/ssh>
- OrbStack commands: <https://docs.orbstack.dev/machines/commands>
- VS Code Remote Development using SSH: <https://code.visualstudio.com/docs/remote/ssh>
- VS Code Remote-SSH tutorial: <https://code.visualstudio.com/docs/remote/ssh-tutorial>
- VS Code terminal basics: <https://code.visualstudio.com/docs/terminal/basics>
- VS Code terminal profiles: <https://code.visualstudio.com/docs/terminal/profiles>
