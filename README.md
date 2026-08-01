# Codyssey E1-1 · AI/SW 개발 워크스테이션 구축

이 저장소는 코디세이 입학연수 **E1-1. AI/SW 개발 워크스테이션 구축** 미션을 수행하고 증거를 기록하기 위한 저장소입니다.

## 시작 문서

처음 수행하는 학습자는 다음 문서를 위에서부터 순서대로 진행합니다.

- [E1-1 초보자 무중단 수행 가이드](./E1-1-training.md)

## 기본 실습환경

- macOS
- OrbStack
- OrbStack Ubuntu 24.04 LTS Linux machine: `codyssey-training`
- OrbStack Docker Engine
- Git
- GitHub CLI(`gh`)
- VS Code

## 초보자 기본 Git 흐름

첫 수행에서는 여러 브랜치와 여러 PR로 나누지 않습니다.

```text
main
└── feat/e1-1-complete
    ├── 의미 단위 commit 누적
    ├── Draft Pull Request
    ├── clean clone 검증
    ├── Ready 전환
    └── merge
```

중요한 순서:

```text
터미널 기초
→ OrbStack Ubuntu
→ Docker 연결
→ gh 인증
→ clone
→ 작업 브랜치
→ add·commit·push
→ Draft PR
→ 미션 실습
→ clean clone
→ Ready
→ merge
→ main 최종 확인
```

## 진행 현황

- [ ] Mac 터미널 기본 조작
- [ ] OrbStack 및 Ubuntu 24.04 환경
- [ ] OrbStack Docker 연결과 경로 시험
- [ ] GitHub CLI 설치·인증
- [ ] 저장소 쓰기 권한 확인
- [ ] 저장소 clone
- [ ] VS Code 연결
- [ ] `feat/e1-1-complete` 브랜치
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
- [ ] 현재 작업 브랜치 clean clone
- [ ] PR diff·checks·보안 점검
- [ ] PR 병합
- [ ] Default branch 최종 smoke test
- [ ] 동료평가 준비

## 작업 상태 확인

```bash
git status -sb
git branch -vv
git log --oneline --graph --decorate --all -20
gh auth status --hostname github.com
gh pr status --conflict-status
```

## 중요 주의사항

- `gh auth logout`은 인증 직후 실행하지 않습니다.
- 공용 장비에서는 모든 작업과 제출 확인이 끝난 뒤에만 로그아웃합니다.
- `<파일>`, `<PR번호>` 같은 표기를 터미널에 그대로 입력하지 않습니다.
- `git push --force`와 `git push -f`를 사용하지 않습니다.
- clean clone 검증은 PR 병합 전에 수행합니다.
- 평가 대상은 GitHub 저장소의 Default branch입니다.
