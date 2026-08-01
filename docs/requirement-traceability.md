# 요구사항·테스트·증거 추적표

> 상태는 `⬜ 미수행`, `🟨 진행`, `✅ 완료`, `❌ 실패`로 표시합니다.

| ID | 요구사항 | 구현·실습 위치 | 검증 명령 | 증거 위치 | commit·PR | 상태 |
|---|---|---|---|---|---|---|
| ENV-01 | OrbStack Ubuntu 24.04 | `codyssey-training` | `cat /etc/os-release` | `docs/environment.md` |  | ⬜ |
| ENV-02 | OrbStack Docker 연결 | command link | `docker version`, `docker info` | `docs/environment.md` |  | ⬜ |
| ENV-03 | Docker 경로 사전 시험 | `~/docker-path-test` | build·bind test | `docs/test-results.md` |  | ⬜ |
| GH-01 | GitHub CLI 설치 | Ubuntu | `gh --version` | `docs/environment.md` |  | ⬜ |
| GH-02 | GitHub CLI 인증 | HTTPS web login | `gh auth status` | `docs/git-workflow.md` |  | ⬜ |
| GH-03 | 저장소 쓰기 권한 | 대상 저장소 | `gh repo view --json viewerPermission` | `docs/git-workflow.md` |  | ⬜ |
| GIT-01 | 작업 브랜치 | `feat/e1-1-complete` | `git branch --show-current` | Git graph |  | ⬜ |
| GIT-02 | 의미 단위 commit | Git history | `git log --oneline` | Git graph |  | ⬜ |
| GIT-03 | Draft PR | GitHub PR | `gh pr view` | PR URL |  | ⬜ |
| CLI-01 | 터미널 조작 | `practice/` | `pwd`, `ls -la` | `docs/terminal-and-permissions.md` |  | ⬜ |
| PERM-01 | 파일 권한 | `permission-file.txt` | `ls -l` | permissions 문서 |  | ⬜ |
| PERM-02 | 디렉터리 권한 | `permission-dir` | `ls -ld` | permissions 문서 |  | ⬜ |
| DOC-01 | Docker 기본 운영 | OrbStack Engine | `images`, `ps`, `logs`, `stats` | `docs/docker-operations.md` |  | ⬜ |
| IMG-01 | 커스텀 이미지 | `Dockerfile`, `site/` | `docker build` | build 기록 |  | ⬜ |
| PORT-01 | 포트 매핑 | `$HOST_PORT:80` | `curl` | port screenshot |  | ⬜ |
| MOUNT-01 | 바인드 마운트 | `bind-test/` | 변경 전후 `curl` | `docs/bind-mount.md` |  | ⬜ |
| VOL-01 | 볼륨 영속성 | `e1-1-data` | 삭제 전후 `cat` | `docs/volume-persistence.md` |  | ⬜ |
| TS-01 | 트러블슈팅 2건 | troubleshooting | 재현·복구 | `docs/troubleshooting.md` |  | ⬜ |
| TEST-01 | 작업 브랜치 clean clone | timestamp 폴더 | build·HTTP | `docs/test-results.md` |  | ⬜ |
| PR-01 | PR diff·checks | PR | `gh pr diff`, `gh pr checks` | PR URL |  | ⬜ |
| PR-02 | PR 병합 | main | `gh pr list --state merged` | PR URL |  | ⬜ |
| FINAL-01 | main smoke test | Default branch | build·HTTP | `docs/test-results.md` |  | ⬜ |
| SEC-01 | 민감정보 점검 | 전체 저장소 | `git diff`, `git grep` | 점검 기록 |  | ⬜ |
