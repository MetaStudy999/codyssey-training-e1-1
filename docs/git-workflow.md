# Git·GitHub 작업 기록

> 실제 수행하면서 아래 항목을 채웁니다. 토큰, 비밀번호, 개인키, 인증 코드는 기록하지 않습니다.

## 1. 저장소 기준선

- Repository: `MetaStudy999/codyssey-training-e1-1`
- Default branch: `main`
- Git protocol:
- `gh` 버전:
- Git 버전:
- 작업 환경: OrbStack Ubuntu 24.04 `codyssey-training`

## 2. 현재 상태 확인

```bash
git status -sb
git branch -vv
git remote -v
git log --oneline --graph --decorate --all -15
gh auth status --hostname github.com
gh pr status --conflict-status
```

## 3. 작업 기록

| 날짜 | 브랜치 | 작업 목적 | 주요 파일 | commit SHA | PR | 상태 |
|---|---|---|---|---|---|---|
| YYYY-MM-DD | docs/example | 예시 | README.md | abc1234 | #1 | draft |

상태 예시: `local`, `pushed`, `draft`, `review`, `merged`, `closed`

## 4. Commit 기록

| 순서 | Commit 메시지 | 포함한 파일 | 검증 명령 | 결과 |
|---:|---|---|---|---|
| 1 | `Docs: ...` |  |  |  |

## 5. Pull Request 기록

- PR 번호:
- PR URL:
- Base branch:
- Head branch:
- Draft 생성일:
- Ready 전환일:
- 병합일:
- 병합 방식: merge / squash / rebase
- 병합 commit:

### 변경 내용

- 

### 검증

```bash
# 실제 실행한 검증 명령
```

### 증거

- 

## 6. 병합 후 확인

```bash
git switch main
git pull --ff-only origin main
git fetch --prune
git log --oneline --graph --decorate --all -20
gh pr list --state merged --limit 10
```

- [ ] Default branch에 변경 반영
- [ ] 로컬 main 최신화
- [ ] 작업 브랜치 정리
- [ ] clean clone 재현
- [ ] 평가 문서에서 PR·commit 링크 확인
