# E1-1 스크린샷 규칙

## 파일명

다음 형식을 사용합니다.

```text
두 자리 순번-검증내용.png
```

예시:

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

## 스크린샷에 포함할 내용

- 실행 위치를 구분할 수 있는 터미널 또는 VS Code 상태 표시
- 실행한 핵심 명령
- 정상 결과
- 필요할 때 현재 branch와 작업 경로

## 촬영 전 보안 점검

다음 내용은 가리거나 화면에서 제거합니다.

- GitHub token
- 브라우저 인증 코드
- 비밀번호
- SSH 개인키 내용
- `~/.config/gh/hosts.yml`
- `~/.ssh/config` 전체 내용
- 학교 내부 IP·호스트·계정 정보
- 이메일·전화번호 등 개인정보
- 관련 없는 브라우저 탭

## Git 추가 전 확인

```bash
git status -sb
git diff --cached --name-only
```

이미지를 staging한 뒤에는 각 파일을 직접 열어 민감정보가 없는지 다시 확인합니다.
