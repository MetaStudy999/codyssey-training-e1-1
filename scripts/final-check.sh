#!/usr/bin/env bash

# 병합 후 main 최종 검증
# 실행: bash scripts/final-check.sh
# E1-1 전용 임시 컨테이너만 만들고 종료 시 제거합니다.

set -u

FAILURES=0
EXPECTED_BRANCH="main"
REQUIRED_FILES=(
  README.md
  E1-1-training.md
  Dockerfile
  site/index.html
  bind-test/index.html
  docs/environment.md
  docs/test-results.md
  docs/troubleshooting.md
  docs/requirement-traceability.md
)

pass() { printf '[PASS] %s\n' "$*"; }
fail() { printf '[FAIL] %s\n' "$*" >&2; FAILURES=$((FAILURES + 1)); }
warn() { printf '[WARN] %s\n' "$*" >&2; }

printf '=== E1-1 main 최종 검증 ===\n'

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  fail "Git 저장소에서 실행해야 합니다"
  exit 1
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT" || exit 1

CURRENT_BRANCH="$(git branch --show-current 2>/dev/null || true)"
if [ "$CURRENT_BRANCH" = "$EXPECTED_BRANCH" ]; then
  pass "현재 브랜치: main"
else
  fail "현재 브랜치가 main이 아닙니다: ${CURRENT_BRANCH:-확인 불가}"
fi

if [ -z "$(git status --porcelain)" ]; then
  pass "Git 작업 트리 clean"
else
  fail "commit되지 않은 변경이 있습니다"
  git status -sb
fi

for required_file in "${REQUIRED_FILES[@]}"; do
  if [ -e "$required_file" ]; then
    pass "필수 파일: $required_file"
  else
    fail "필수 파일 없음: $required_file"
  fi
done

for sensitive_path in .env .env.local id_rsa id_ed25519 hosts.yml; do
  if git ls-files --error-unmatch "$sensitive_path" >/dev/null 2>&1; then
    fail "민감 파일이 Git에 추적됩니다: $sensitive_path"
  fi
done

if git grep -n -i -E 'BEGIN (RSA|OPENSSH|EC) PRIVATE KEY' >/dev/null 2>&1; then
  fail "저장소에서 개인키 형태의 문자열을 발견했습니다"
else
  pass "개인키 문자열 기본 검사"
fi

if ! docker version >/dev/null 2>&1 || ! docker info >/dev/null 2>&1; then
  fail "Docker Engine에 연결할 수 없습니다"
else
  pass "Docker Engine 연결"
fi

if [ "$FAILURES" -eq 0 ]; then
  IMAGE="codyssey-e1-1-web:final-check"
  CONTAINER="e1-1-final-check-$$"
  PORT="18082"

  if command -v mac >/dev/null 2>&1 \
    && mac lsof -nP -iTCP:"$PORT" -sTCP:LISTEN 2>/dev/null | grep -q LISTEN; then
    PORT="18083"
  fi

  cleanup() {
    docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  }
  trap cleanup EXIT INT TERM

  if docker build -t "$IMAGE" .; then
    pass "Docker 이미지 빌드"
  else
    fail "Docker 이미지 빌드 실패"
  fi

  if [ "$FAILURES" -eq 0 ]; then
    if docker run -d --name "$CONTAINER" -p "${PORT}:80" "$IMAGE" >/dev/null; then
      pass "임시 컨테이너 실행"
    else
      fail "임시 컨테이너 실행 실패"
    fi
  fi

  if [ "$FAILURES" -eq 0 ]; then
    RESPONSE_OK=0
    for _ in 1 2 3 4 5; do
      if curl -fsS "http://localhost:${PORT}" | grep -q 'AI/SW 개발 워크스테이션 구축'; then
        RESPONSE_OK=1
        break
      fi
      sleep 1
    done

    if [ "$RESPONSE_OK" -eq 1 ]; then
      pass "HTTP 응답 내용 확인"
    else
      fail "HTTP 응답 검증 실패"
    fi
  fi
fi

printf '\n'
if [ "$FAILURES" -eq 0 ]; then
  pass "최종 검증 완료"
  exit 0
fi

fail "최종 검증 실패 항목 수: $FAILURES"
exit 1
