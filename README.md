# Codyssey E1-1 · AI/SW 개발 워크스테이션 구축

이 저장소는 코디세이 입학연수 **E1-1. AI/SW 개발 워크스테이션 구축** 미션을 수행하고 증거를 기록하기 위한 저장소입니다.

## 먼저 읽을 문서

1. [`E1-1-training.md`](./E1-1-training.md)를 처음부터 순서대로 진행합니다.
2. 실제 명령 출력과 스크린샷은 `README.md`와 `docs/`에 기록합니다.
3. 작업은 `main`에 직접 쌓기보다 기능 브랜치 → commit → push → Pull Request 순서로 반영합니다.

## 권장 실습환경

- macOS
- OrbStack
- OrbStack Ubuntu 24.04 LTS Linux machine: `codyssey-training`
- OrbStack Docker Engine
- Git, GitHub CLI(`gh`), VS Code

## 진행 현황

- [ ] OrbStack 및 Ubuntu 24.04 환경 구성
- [ ] OrbStack Docker 연동 및 경로 사전 시험
- [ ] GitHub CLI 설치·인증
- [ ] GitHub 저장소 clone
- [ ] 터미널 기본 조작
- [ ] 파일·디렉터리 권한
- [ ] Docker 기본 운영
- [ ] Dockerfile 및 커스텀 이미지
- [ ] 포트 매핑
- [ ] 바인드 마운트
- [ ] Docker 볼륨 영속성
- [ ] Git 브랜치·add·commit·push
- [ ] Pull Request 생성·검토·병합
- [ ] 트러블슈팅 2건 이상
- [ ] 요구사항·테스트·증거 추적표
- [ ] clean clone 재현 시험
- [ ] 민감정보 점검
- [ ] 동료평가 준비

## 제출 전 확인

```bash
git status -sb
git log --oneline --graph --decorate --all
gh auth status
gh pr status --conflict-status
```

평가 대상은 GitHub 저장소의 **Default branch**입니다. PR 병합과 최종 push가 완료되었는지 확인합니다.
