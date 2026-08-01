# 테스트 결과

## 1. 환경

| 테스트 | 명령 | 기대 결과 | 실제 결과 | 상태 |
|---|---|---|---|---|
| Ubuntu 버전 | `cat /etc/os-release` | Ubuntu 24.04 |  | ⬜ |
| Docker Client·Server | `docker version` | Client·Server 출력 |  | ⬜ |
| Docker Engine | `docker info` | Engine 정보 |  | ⬜ |
| hello-world | `docker run --rm hello-world` | 정상 메시지 |  | ⬜ |
| build path | `docker build -t orb-path-test .` | 빌드 성공 |  | ⬜ |
| bind path | `docker run --rm -v ...` | 파일 출력 |  | ⬜ |

## 2. Git·GitHub

| 테스트 | 명령 | 기대 결과 | 실제 결과 | 상태 |
|---|---|---|---|---|
| gh 인증 | `gh auth status` | 로그인 계정 표시 |  | ⬜ |
| 쓰기 권한 | `gh repo view --json viewerPermission` | WRITE 이상 |  | ⬜ |
| 작업 브랜치 | `git branch --show-current` | `feat/e1-1-complete` |  | ⬜ |
| 원격 추적 | `git branch -vv` | origin branch 연결 |  | ⬜ |
| PR 상태 | `gh pr status --conflict-status` | 현재 PR 표시 |  | ⬜ |

## 3. Docker 미션

| 테스트 | 검증 | 실제 결과 | 증거 | 상태 |
|---|---|---|---|---|
| 이미지 빌드 | `docker build` |  |  | ⬜ |
| 포트 매핑 | `curl http://localhost:$HOST_PORT` |  |  | ⬜ |
| 바인드 마운트 | 변경 전후 비교 |  |  | ⬜ |
| 볼륨 영속성 | 삭제 후 `cat` |  |  | ⬜ |

## 4. Clean clone 검증

- 검증 날짜:
- 검증 브랜치:
- 검증 폴더:
- 검증 포트:
- Docker build:
- HTTP 응답:
- 누락 파일:
- 결과: PASS / FAIL

## 5. Pull Request checks

- checks 존재 여부:
- 통과 여부:
- CI가 없는 경우 수동 검증 기록:
- Ready 전환 확인:
- 병합 확인:

## 6. 최종 main smoke test

- `main` 최신화:
- 최종 이미지 빌드:
- 포트 `18082` 응답:
- 최종 결과: PASS / FAIL
