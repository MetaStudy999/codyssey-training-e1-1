#!/usr/bin/env bash

# 중단 후 작업 재개 점검
# OrbStack Ubuntu 또는 VS Code Remote-SSH 터미널에서 실행합니다.
# 실행: bash scripts/resume-check.sh

set -u

FAILURES=0
EXPECTED_BRANCH="${1:-feat/e1-1-complete}"
REPO_DIR="${HOME}/codyssey-training/codyssey-training-e1-1"

pass() { printf '[PASS] %s\n' "$*"; }
fail() { printf '[FAIL] %s\n' "$*" >&2; FAILURES=$((FAILURES + 1)); }
warn() { printf '[WARN] %s\n' "$*" >&2; }
info() { printf '[INFO] %s\n' "$*"; }

printf '=== E1-1 작업 재개 점검 ===\n'

if [ ! -d "$REPO_DIR/.git" ]; then
  fail "저장소를 찾지 못했습니다: $REPO_DIR"
  exit 1
fi

cd "$REPO_DIR" || exit 1
pass "저장소 이동: $REPO_DIR"

CURRENT_BRANCH="$(git branch --show-current 2>/dev/null || true)"
if [ "$CURRENT_BRANCH" = "$EXPECTED_BRANCH" ]; then
  pass "작업 브랜치: $CURRENT_BRANCH"
elif [ "$CURRENT_BRANCH" = "main" ]; then
  fail "현재 브랜치가 main입니다. 파일을 수정하지 마십시오"
  info "전환 명령: git switch $EXPECTED_BRANCH"
else
  warn "현재 브랜치: ${CURRENT_BRANCH:-확인 불가}; 예상: $EXPECTED_BRANCH"
fi

git status -sb

if gh auth status --hostname github.com >/dev/null 2>&1; then
  pass "GitHub CLI 인증"
else
  fail "GitHub CLI 인증이 없거나 만료되었습니다"
fi

if docker version >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
  pass "Docker Engine 연결"
else
  fail "Docker Engine 연결 실패"
fi

OPEN_PR="$(gh pr list \
  --head "$EXPECTED_BRANCH" \
  --base main \
  --state open \
  --json number,url \
  --jq '.[0] | if . then "#\(.number) \(.url)" else "" end' \
  2>/dev/null || true)"

if [ -n "$OPEN_PR" ]; then
  pass "기존 Pull Request: $OPEN_PR"
else
  warn "열린 Pull Request를 찾지 못했습니다"
fi

if [ -f .env.local ]; then
  # 값 자체는 출력하지 않고 변수 이름만 확인합니다.
  if grep -q '^HOST_PORT=' .env.local; then
    pass ".env.local의 HOST_PORT 확인"
    info "현재 셸에 반영: source .env.local"
  else
    warn ".env.local에 HOST_PORT가 없습니다"
  fi
else
  warn ".env.local이 없습니다. 포트 실습 전에는 정상일 수 있습니다"
fi

printf '\n'
info "터미널을 닫으면 다음 셸 변수는 사라집니다:"
printf '  WORK_BRANCH REMOTE_DIR HOST_PORT PR_NUMBER SOURCE_DIR CURRENT_BRANCH RETEST_DIR\n'
info "필요할 때 문서의 명령으로 다시 계산하십시오. 스크립트에서 export한 값은 부모 셸에 남지 않습니다."

printf '\n'
if [ "$FAILURES" -eq 0 ]; then
  pass "작업 재개 가능"
  exit 0
fi

fail "재개 전에 해결할 실패 항목 수: $FAILURES"
exit 1
