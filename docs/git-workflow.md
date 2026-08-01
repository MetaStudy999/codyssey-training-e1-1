# Git·GitHub 작업 기록

> 실제 수행하면서 채웁니다. 토큰, 비밀번호, 개인키, 인증 코드는 기록하지 않습니다.

## 1. 저장소 기준선

- Repository: `MetaStudy999/codyssey-training-e1-1`
- Default branch: `main`
- 작업 branch: `feat/e1-1-complete`
- Git protocol: `https`
- `gh` 버전:
- Git 버전:
- 작업 환경: OrbStack Ubuntu 24.04 `codyssey-training`
- `viewerPermission`:

## 2. 인증·권한 확인

```bash
gh auth status --hostname github.com
gh config get git_protocol
gh repo view MetaStudy999/codyssey-training-e1-1 \
  --json nameWithOwner,viewerPermission
```

- [ ] GitHub 로그인 계정 확인
- [ ] Git protocol `https`
- [ ] `ADMIN`, `MAINTAIN`, `WRITE` 중 하나

## 3. 현재 상태

```bash
git status -sb
git branch -vv
git remote -v
git log --oneline --graph --decorate --all -20
gh pr status --conflict-status
```

## 4. Commit 기록

| 순서 | Commit 메시지 | 포함 파일 | 검증 명령 | Commit SHA | Push |
|---:|---|---|---|---|---|
| 1 | `Docs: initialize E1-1 evidence structure` | docs templates | `git diff --cached` |  | ⬜ |
| 2 | `Docs: record terminal and permission practice` | permissions 문서 | `ls -l`, `ls -ld` |  | ⬜ |
| 3 | `Docs: record Docker image and container operations` | Docker 문서 | `docker ps`, `docker logs` |  | ⬜ |
| 4 | `Feat: add NGINX Dockerfile and static page` | Dockerfile, site | `docker build` |  | ⬜ |
| 5 | `Test: verify Docker port mapping` | test results | `curl` |  | ⬜ |
| 6 | `Test: verify bind mount file updates` | bind-test, 문서 | 변경 전후 `curl` |  | ⬜ |
| 7 | `Test: verify Docker volume persistence` | volume 문서 | 삭제 전후 `cat` |  | ⬜ |
| 8 | `Docs: add troubleshooting and evidence traceability` | docs | 문서 점검 |  | ⬜ |
| 9 | `Test: record clean clone verification` | test results | 새 폴더 build·HTTP |  | ⬜ |
| 10 | `Docs: finalize E1-1 submission` | README, docs | 최종 점검 |  | ⬜ |

## 5. Pull Request 기록

- PR 번호:
- PR URL:
- Base branch: `main`
- Head branch: `feat/e1-1-complete`
- Draft 생성일:
- clean clone 검증일:
- Ready 전환일:
- 병합일:
- 병합 방식: `merge`
- 병합 commit:

### PR 상태 명령

```bash
PR_NUMBER="$(gh pr view --json number --jq '.number')"

gh pr status --conflict-status
gh pr view "$PR_NUMBER"
gh pr diff "$PR_NUMBER" --name-only
gh pr checks "$PR_NUMBER"
```

### Checks 판정

- [ ] 검사가 있고 모두 통과
- [ ] 또는 CI가 없어 수동 clean clone 결과를 기록
- [ ] 실패·대기 상태에서 병합하지 않음

## 6. Clean clone 기록

- 검증 브랜치:
- timestamp 검증 폴더:
- 이미지 빌드:
- 검증 포트:
- HTTP 응답:
- 결과: PASS / FAIL

> clean clone은 PR 병합 전에 수행하고, 결과를 같은 PR에 commit·push합니다.

## 7. 병합 후 확인

```bash
git switch main
git pull --ff-only origin main
git fetch --prune
git log --oneline --graph --decorate --all -20
gh pr list --state merged --limit 10
```

- [ ] Default branch에 변경 반영
- [ ] 로컬 `main` 최신화
- [ ] 원격 작업 branch 삭제 확인
- [ ] `main`에서 최종 Docker build 성공
- [ ] `main`에서 최종 HTTP 응답 성공
- [ ] 평가 문서에서 PR·commit 링크 확인

## 8. 공용 장비 종료

모든 작업과 제출 확인이 끝난 뒤에만 실행합니다.

```bash
gh auth logout --hostname github.com
```
