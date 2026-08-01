## 작업 목적

<!-- 이 PR이 해결하거나 추가하는 내용을 1~3문장으로 작성합니다. -->

## 변경 내용

- [ ] 환경 또는 설정
- [ ] 터미널·권한 기록
- [ ] Docker 기본 운영
- [ ] Dockerfile·웹 파일
- [ ] 포트·바인드 마운트·볼륨
- [ ] 테스트·검증 자료
- [ ] 트러블슈팅
- [ ] 기타

### 주요 변경 파일

<!-- 예: README.md, Dockerfile, docs/environment.md -->

## 검증 방법

```bash
# 실제로 실행한 검증 명령을 작성합니다.
```

## 검증 결과

<!-- 예상 결과가 아니라 본인이 확인한 실제 결과를 요약합니다. -->

## 증거 위치

<!-- README 절, docs 문서, screenshots 경로 등을 작성합니다. -->

## Git 점검

- [ ] 작업 branch가 `feat/e1-1-complete`이다.
- [ ] `git status -sb`를 확인했다.
- [ ] `git diff`로 작업 내용을 확인했다.
- [ ] `git diff --cached`로 commit 대상을 확인했다.
- [ ] 의미 단위로 commit했다.
- [ ] 원격 작업 branch에 push했다.
- [ ] force push를 사용하지 않았다.

## 미션 점검

- [ ] 터미널·권한 실습을 기록했다.
- [ ] Docker 기본 운영을 기록했다.
- [ ] Dockerfile 이미지 빌드에 성공했다.
- [ ] 선택한 호스트 포트로 접속했다.
- [ ] `bind-test/`로 바인드 마운트를 검증했다.
- [ ] 컨테이너 삭제 후 볼륨 데이터를 확인했다.
- [ ] 트러블슈팅을 최소 2건 기록했다.

## 병합 전 검증

- [ ] 현재 PR 작업 branch를 새 timestamp 폴더에 clean clone했다.
- [ ] clean clone에서 Docker build에 성공했다.
- [ ] clean clone에서 HTTP 응답을 확인했다.
- [ ] clean clone 결과를 `docs/test-results.md`에 기록했다.
- [ ] `gh pr diff`에서 의도하지 않은 파일이 없음을 확인했다.
- [ ] `gh pr checks` 결과를 확인했다.
- [ ] CI가 없다면 수동 검증 완료 사실을 기록했다.
- [ ] PR을 Ready로 전환하기 전에 위 항목을 완료했다.

## 보안 점검

- [ ] `.env.local`이 commit되지 않았다.
- [ ] `~/.config/gh/` 파일이 포함되지 않았다.
- [ ] 토큰·비밀번호·개인키·인증 코드가 없다.
- [ ] 스크린샷에 민감정보가 없다.

## 관련 항목

<!-- 요구사항 ID, Issue 번호, 트러블슈팅 ID 등을 연결합니다. 예: ENV-02, TS-01 -->
