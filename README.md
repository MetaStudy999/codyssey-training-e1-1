# Codyssey E1-1 · AI/SW 개발 워크스테이션 구축

이 저장소는 코디세이 입학연수 **E1-1. AI/SW 개발 워크스테이션 구축** 미션을 수행하고 증거를 기록하기 위한 저장소입니다.

## 시작 문서

처음 수행하는 학습자는 다음 순서로 진행합니다.

1. [E1-1 초보자 무중단 수행 가이드](./E1-1-training.md)
2. [입문자 한 페이지 체크포인트](./docs/beginner-checkpoints.md)
3. [OrbStack Ubuntu와 VS Code Remote-SSH 연결](./docs/vscode-orbstack-remote-ssh.md)
4. [스크린샷 규칙](./docs/screenshots/README.md)

## 기본 실습환경

- macOS
- OrbStack
- OrbStack Ubuntu 24.04 LTS machine: `codyssey-training`
- OrbStack Docker Engine
- Git
- GitHub CLI(`gh`)
- VS Code + Remote - SSH

## 기본 수행 흐름

```text
Mac 터미널 기초
→ OrbStack Ubuntu
→ Docker 연결
→ GitHub CLI 인증
→ 저장소 clone
→ 작업 branch 생성
→ Mac에서 code --remote로 Ubuntu workspace 열기
→ VS Code 원격 터미널 검증
→ commit·push
→ Draft PR
→ 미션 실습
→ clean clone
→ PR 병합
→ main 최종 검증
```

VS Code는 다음 형태로 실행합니다.

```bash
"$CODE_BIN" --new-window \
  --remote "ssh-remote+codyssey-training@orb" \
  "$REMOTE_DIR/"
```

`code .`만 실행한 결과를 Remote-SSH 성공으로 판정하지 않습니다.

## 입문자 점검 스크립트

스크립트는 설치·삭제를 자동으로 수행하지 않으며, 상태를 `[PASS]`, `[WARN]`, `[FAIL]`로 구분합니다.

| 스크립트 | 실행 위치 | 목적 |
|---|---|---|
| `scripts/preflight-macos.sh` | Mac | OrbStack·SSH·VS Code CLI·Remote-SSH 요구사항 |
| `scripts/preflight-ubuntu.sh` | Ubuntu | Ubuntu·GitHub CLI·Docker·branch 상태 |
| `scripts/verify-vscode-remote.sh` | VS Code Ubuntu | OS·셸·경로·Git root·branch 검증 |
| `scripts/resume-check.sh` | Ubuntu | 중단 후 작업 재개 상태 확인 |
| `scripts/final-check.sh` | main | 필수 파일·보안·Docker build·HTTP smoke test |
| `scripts/cleanup-e1-1.sh` | Ubuntu | 제출 후 E1-1 전용 Docker 자원만 정리 |

실행 예:

```bash
bash scripts/preflight-ubuntu.sh
bash scripts/verify-vscode-remote.sh
```

## 초보자 기본 Git 흐름

첫 수행에서는 여러 branch와 여러 PR로 나누지 않습니다.

```text
main
└── feat/e1-1-complete
    ├── 의미 단위 commit 누적
    ├── Draft Pull Request
    ├── clean clone 검증
    ├── Ready 전환
    └── merge
```

기존 branch 또는 PR이 있으면 새로 만들지 않고 재사용합니다.

```bash
WORK_BRANCH="feat/e1-1-complete"

git fetch origin

gh pr list \
  --head "$WORK_BRANCH" \
  --base main \
  --state open
```

## 진행 현황

- [ ] Mac 터미널 기본 조작
- [ ] OrbStack 및 Ubuntu 24.04 환경
- [ ] OrbStack Docker 연결과 경로 시험
- [ ] GitHub CLI 설치·인증
- [ ] 저장소 쓰기 권한 확인
- [ ] 저장소 clone
- [ ] `feat/e1-1-complete` branch
- [ ] Mac VS Code CLI와 Remote - SSH
- [ ] `code --remote`로 Ubuntu workspace 열기
- [ ] VS Code 원격 터미널 검증
- [ ] 초기 commit과 push
- [ ] Draft Pull Request
- [ ] 터미널·권한 실습
- [ ] Docker 기본 운영
- [ ] Dockerfile 및 커스텀 이미지
- [ ] 포트 매핑
- [ ] 바인드 마운트
- [ ] Docker 볼륨 영속성
- [ ] 트러블슈팅 2건 이상
- [ ] 요구사항·테스트·증거 추적표
- [ ] 현재 작업 branch clean clone
- [ ] PR diff·checks·보안 점검
- [ ] PR 병합
- [ ] Default branch 최종 smoke test
- [ ] 동료평가 준비

## 작업 재개

```bash
cd ~/codyssey-training/codyssey-training-e1-1
bash scripts/resume-check.sh
```

터미널을 닫으면 `WORK_BRANCH`, `REMOTE_DIR`, `HOST_PORT`, `PR_NUMBER`, `SOURCE_DIR`, `CURRENT_BRANCH`, `RETEST_DIR` 같은 셸 변수는 사라집니다. 필요한 시점에 다시 계산합니다.

## 중요 주의사항

- 현재 branch가 `main`이면 파일을 수정하지 않습니다.
- `gh auth logout`은 모든 작업과 제출 확인이 끝난 뒤에만 실행합니다.
- `<파일>`, `<PR번호>` 같은 설명용 표기를 터미널에 그대로 입력하지 않습니다.
- `git push --force`, `git push -f`를 사용하지 않습니다.
- `docker system prune`, `docker system prune -a`를 사용하지 않습니다.
- clean clone 검증은 PR 병합 전에 수행합니다.
- 스크린샷에 token·인증 코드·개인키·학교 내부정보를 포함하지 않습니다.
- 평가 대상은 GitHub 저장소의 Default branch입니다.
