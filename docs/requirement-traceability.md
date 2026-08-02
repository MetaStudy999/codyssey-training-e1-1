# 요구사항·테스트·증거 추적표

> 상태는 `⬜ 미수행`, `🟨 진행`, `✅ 완료`, `❌ 실패`로 표시합니다.

| ID | 요구사항 | 구현·실습 위치 | 검증 명령 | 증거 위치 | commit·PR | 상태 |
|---|---|---|---|---|---|---|
| ENV-01 | OrbStack Ubuntu 24.04 | `codyssey-training` | `cat /etc/os-release` | `docs/environment.md` |  | ⬜ |
| ENV-02 | OrbStack Docker 연결 | command link | `docker version`, `docker info` | `docs/environment.md` |  | ⬜ |
| ENV-03 | Docker 경로 사전 시험 | `~/docker-path-test` | build·bind test | `docs/test-results.md` |  | ⬜ |
| PRE-01 | Mac 사전 점검 | macOS | `bash scripts/preflight-macos.sh` | 터미널 로그 |  | ⬜ |
| PRE-02 | Ubuntu 사전 점검 | Ubuntu | `bash scripts/preflight-ubuntu.sh` | 터미널 로그 |  | ⬜ |
| VSC-01 | OrbStack 내장 SSH 연결 | Mac → `codyssey-training@orb` | `ssh codyssey-training@orb` | `docs/environment.md` |  | ⬜ |
| VSC-02 | 관리자 권한 없는 VS Code CLI 확인 | macOS | `CODE_BIN`, `code --version` | 터미널 로그 |  | ⬜ |
| VSC-03 | CLI로 원격 workspace 열기 | Mac → Ubuntu workspace | `code --remote "ssh-remote+codyssey-training@orb" "$REMOTE_DIR/"` | `docs/screenshots/vscode/` |  | ⬜ |
| VSC-04 | VS Code Remote-SSH 상태 | Remote - SSH 창 | 상태 표시줄·Remote SSH Output | `docs/screenshots/vscode/` |  | ⬜ |
| VSC-05 | 원격 통합 터미널 | Ubuntu workspace | `bash scripts/verify-vscode-remote.sh` | `docs/environment.md` |  | ⬜ |
| RES-01 | 중단 후 재개 가능 | Ubuntu workspace | `bash scripts/resume-check.sh` | 터미널 로그 |  | ⬜ |
| GH-01 | GitHub CLI 설치 | Ubuntu | `gh --version` | `docs/environment.md` |  | ⬜ |
| GH-02 | GitHub CLI 인증 | HTTPS web login | `gh auth status` | `docs/git-workflow.md` |  | ⬜ |
| GH-03 | 저장소 쓰기 권한 | 대상 저장소 | `gh repo view --json viewerPermission` | `docs/git-workflow.md` |  | ⬜ |
| GIT-01 | 작업 branch | `feat/e1-1-complete` | `git branch --show-current` | Git graph |  | ⬜ |
| GIT-02 | 기존 local·remote branch 재사용 | Git | `show-ref`, `ls-remote` | `docs/git-workflow.md` |  | ⬜ |
| GIT-03 | 의미 단위 commit | Git history | `git log --oneline` | Git graph |  | ⬜ |
| GIT-04 | 기존 Draft PR 재사용 | GitHub PR | `gh pr list --head` | PR URL |  | ⬜ |
| CLI-01 | 터미널 조작 | `practice/` | `pwd`, `ls -la` | `docs/terminal-and-permissions.md` |  | ⬜ |
| PERM-01 | 파일 권한 | `permission-file.txt` | `ls -l` | permissions 문서 |  | ⬜ |
| PERM-02 | 디렉터리 권한 | `permission-dir` | `ls -ld` | permissions 문서 |  | ⬜ |
| DOC-01 | Docker 기본 운영 | OrbStack Engine | `images`, `ps`, `logs`, `stats` | `docs/docker-operations.md` |  | ⬜ |
| IMG-01 | 커스텀 이미지 | `Dockerfile`, `site/` | `docker build` | build 기록 |  | ⬜ |
| PORT-01 | 포트 매핑 | `$HOST_PORT:80` | `curl` | port screenshot |  | ⬜ |
| MOUNT-01 | 바인드 마운트 | `bind-test/` | 변경 전후 `curl` | `docs/bind-mount.md` |  | ⬜ |
| VOL-01 | 볼륨 영속성 | `e1-1-data` | 삭제 전후 `cat` | `docs/volume-persistence.md` |  | ⬜ |
| SHOT-01 | 스크린샷 파일명·보안 | `docs/screenshots/` | 수동 검토 | `docs/screenshots/README.md` |  | ⬜ |
| TS-01 | 트러블슈팅 2건 | troubleshooting | 재현·복구 | `docs/troubleshooting.md` |  | ⬜ |
| TEST-01 | 작업 branch clean clone | timestamp 폴더 | build·HTTP | `docs/test-results.md` |  | ⬜ |
| PR-01 | PR diff·checks | PR | `gh pr diff`, `gh pr checks` | PR URL |  | ⬜ |
| PR-02 | PR 병합 | main | `gh pr list --state merged` | PR URL |  | ⬜ |
| FINAL-01 | main 최종 검사 | Default branch | `bash scripts/final-check.sh` | `docs/test-results.md` |  | ⬜ |
| CLEAN-01 | E1-1 자원만 정리 | Ubuntu | `bash scripts/cleanup-e1-1.sh` | 정리 로그 |  | ⬜ |
| SEC-01 | 민감정보 점검 | 전체 저장소 | `git diff`, `git grep` | 점검 기록 |  | ⬜ |
