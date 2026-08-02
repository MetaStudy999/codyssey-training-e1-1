#!/usr/bin/env bash

# VS Code Remote-SSH 통합 터미널 검증
# Remote-SSH로 연 VS Code의 Terminal -> New Terminal에서 실행합니다.
# 실행: bash scripts/verify-vscode-remote.sh

set -u

FAILURES=0
EXPECTED_BRANCH="${1:-feat/e1-1-complete}"
EXPECTED_REPO="${HOME}/codyssey-training/codyssey-training-e1-1"

pass() { printf '[PASS] %s\n' "$*"; }
fail() { printf '[FAIL] %s\n' "$*" >&2; FAILURES=$((FAILURES + 1)); }
warn() { printf '[WARN] %s\n' "$*" >&2; }

printf '=== VS Code Remote-SSH 통합 터미널 검증 ===\n'

if [ -r /etc/os-release ] && grep -q 'VERSION_CODENAME=noble' /etc/os-release; then
  pass "Ubuntu 24.04 noble"
else
  fail "Ubuntu 24.04 환경이 아닙니다"
fi

if [ "${TERM_PROGRAM:-}" = "vscode" ] || [ -n "${VSCODE_IPC_HOOK_CLI:-}" ]; then
  pass "VS Code 통합 터미널 환경 확인"
else
  warn "VS Code 통합 터미널 환경 변수를 확인하지 못했습니다"
fi

CURRENT_SHELL="$(ps -p $$ -o comm= 2>/dev/null | tr -d ' ' || true)"
if [ "$CURRENT_SHELL" = "bash" ]; then
  pass "현재 셸 프로세스: bash"
else
  warn "현재 셸 프로세스: ${CURRENT_SHELL:-확인 불가}"
fi

CURRENT_DIR="$(pwd -P)"
if [ "$CURRENT_DIR" = "$EXPECTED_REPO" ]; then
  pass "현재 디렉터리: $CURRENT_DIR"
elif [[ "$CURRENT_DIR" == /Users/* ]]; then
  fail "Mac 로컬 경로가 열렸습니다: $CURRENT_DIR"
else
  fail "예상 저장소 경로가 아닙니다: $CURRENT_DIR"
fi

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  GIT_ROOT="$(git rev-parse --show-toplevel)"
  if [ "$GIT_ROOT" = "$EXPECTED_REPO" ]; then
    pass "Git 최상위 경로: $GIT_ROOT"
  else
    fail "Git 최상위 경로가 예상과 다릅니다: $GIT_ROOT"
  fi
else
  fail "현재 위치는 Git 저장소가 아닙니다"
fi

CURRENT_BRANCH="$(git branch --show-current 2>/dev/null || true)"
if [ "$CURRENT_BRANCH" = "$EXPECTED_BRANCH" ]; then
  pass "현재 브랜치: $CURRENT_BRANCH"
elif [ "$CURRENT_BRANCH" = "main" ]; then
  fail "현재 브랜치가 main입니다. 파일을 수정하지 마십시오"
else
  fail "현재 브랜치가 예상과 다릅니다: ${CURRENT_BRANCH:-확인 불가}"
fi

if [ -n "${SSH_CONNECTION:-}" ] || [ -n "${SSH_CLIENT:-}" ]; then
  pass "SSH 세션 환경 확인"
else
  warn "SSH_CONNECTION/SSH_CLIENT가 없습니다. VS Code 왼쪽 아래 Remote indicator를 직접 확인하십시오"
fi

printf '\n'
printf 'hostname: %s\n' "$(hostname)"
printf 'SHELL: %s\n' "${SHELL:-확인 불가}"
printf 'process: %s\n' "${CURRENT_SHELL:-확인 불가}"
printf 'pwd: %s\n' "$CURRENT_DIR"
printf 'branch: %s\n' "${CURRENT_BRANCH:-확인 불가}"

printf '\n'
if [ "$FAILURES" -eq 0 ]; then
  pass "VS Code Remote-SSH 터미널 검증 완료"
  exit 0
fi

fail "검증 실패 항목 수: $FAILURES"
exit 1
