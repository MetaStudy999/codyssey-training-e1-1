#!/usr/bin/env bash

# E1-1 OrbStack Ubuntu 사전 점검
# 실행: bash scripts/preflight-ubuntu.sh
# 설치·삭제·설정 변경 없이 현재 상태만 확인합니다.

set -u

FAILURES=0
EXPECTED_BRANCH="${1:-feat/e1-1-complete}"
REPO_DIR="${HOME}/codyssey-training/codyssey-training-e1-1"

pass() { printf '[PASS] %s\n' "$*"; }
fail() { printf '[FAIL] %s\n' "$*" >&2; FAILURES=$((FAILURES + 1)); }
warn() { printf '[WARN] %s\n' "$*" >&2; }
info() { printf '[INFO] %s\n' "$*"; }

printf '=== E1-1 Ubuntu 사전 점검 ===\n'

if [ -r /etc/os-release ] && grep -q 'VERSION_CODENAME=noble' /etc/os-release; then
  pass "Ubuntu 24.04 noble 확인"
else
  fail "Ubuntu 24.04 noble 환경을 확인하지 못했습니다"
fi

for command_name in bash tar git gh docker mac; do
  if command -v "$command_name" >/dev/null 2>&1; then
    pass "$command_name 명령 확인: $(command -v "$command_name")"
  else
    fail "$command_name 명령을 찾지 못했습니다"
  fi
done

if command -v curl >/dev/null 2>&1 || command -v wget >/dev/null 2>&1; then
  pass "curl 또는 wget 확인"
else
  fail "curl과 wget을 모두 찾지 못했습니다"
fi

if [ -w "$HOME" ]; then
  pass "HOME 디렉터리 쓰기 가능: $HOME"
else
  fail "HOME 디렉터리에 쓸 수 없습니다: $HOME"
fi

df -h "$HOME" 2>/dev/null | tail -n 1 || warn "HOME 디스크 사용량을 읽지 못했습니다"

if getent hosts github.com >/dev/null 2>&1; then
  pass "github.com DNS 확인"
else
  fail "github.com DNS 확인 실패"
fi

if command -v gh >/dev/null 2>&1; then
  if gh auth status --hostname github.com >/dev/null 2>&1; then
    pass "GitHub CLI 인증 확인"
  else
    fail "GitHub CLI 인증을 확인하지 못했습니다"
  fi
fi

if command -v docker >/dev/null 2>&1; then
  if docker version >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    pass "Docker Client와 Server 연결 확인"
  else
    fail "Docker Engine 연결 실패"
  fi
fi

if [ -d "$REPO_DIR/.git" ]; then
  pass "저장소 확인: $REPO_DIR"
  cd "$REPO_DIR" || exit 1

  CURRENT_BRANCH="$(git branch --show-current 2>/dev/null || true)"
  if [ "$CURRENT_BRANCH" = "$EXPECTED_BRANCH" ]; then
    pass "작업 브랜치 확인: $CURRENT_BRANCH"
  elif [ "$CURRENT_BRANCH" = "main" ]; then
    fail "현재 브랜치가 main입니다. 파일을 수정하지 마십시오"
  else
    warn "현재 브랜치: ${CURRENT_BRANCH:-확인 불가}; 예상: $EXPECTED_BRANCH"
  fi

  if [ -n "$(git status --porcelain)" ]; then
    warn "commit되지 않은 변경이 있습니다"
    git status -sb
  else
    pass "Git 작업 트리 clean"
  fi
else
  fail "저장소를 찾지 못했습니다: $REPO_DIR"
fi

printf '\n'
if [ "$FAILURES" -eq 0 ]; then
  pass "Ubuntu 사전 점검 완료"
  exit 0
fi

fail "사전 점검 실패 항목 수: $FAILURES"
exit 1
