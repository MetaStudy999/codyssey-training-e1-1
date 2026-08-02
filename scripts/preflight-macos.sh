#!/usr/bin/env bash

# E1-1 macOS 사전 점검
# 실행: bash scripts/preflight-macos.sh
# 이 스크립트는 설치·삭제·설정 변경을 수행하지 않습니다.

set -u

FAILURES=0
CODE_BIN=""
REMOTE_HOST="codyssey-training@orb"
REMOTE_REPO='${HOME}/codyssey-training/codyssey-training-e1-1'

pass() { printf '[PASS] %s\n' "$*"; }
fail() { printf '[FAIL] %s\n' "$*" >&2; FAILURES=$((FAILURES + 1)); }
info() { printf '[INFO] %s\n' "$*"; }

printf '=== E1-1 macOS 사전 점검 ===\n'

if [ "$(uname -s 2>/dev/null || true)" = "Darwin" ]; then
  pass "macOS에서 실행 중"
else
  fail "이 스크립트는 Mac 터미널에서 실행해야 합니다"
fi

for command_name in orb ssh; do
  if command -v "$command_name" >/dev/null 2>&1; then
    pass "$command_name 명령 확인: $(command -v "$command_name")"
  else
    fail "$command_name 명령을 찾지 못했습니다"
  fi
done

if command -v code >/dev/null 2>&1; then
  CODE_BIN="$(command -v code)"
else
  for candidate in \
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
    "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
  do
    if [ -x "$candidate" ]; then
      CODE_BIN="$candidate"
      break
    fi
  done
fi

if [ -n "$CODE_BIN" ]; then
  pass "VS Code CLI 확인: $CODE_BIN"
  "$CODE_BIN" --version | head -n 1 || fail "VS Code 버전을 확인하지 못했습니다"

  if "$CODE_BIN" --help 2>/dev/null | grep -q -- '--remote'; then
    pass "VS Code CLI --remote 옵션 확인"
  else
    fail "현재 VS Code CLI에서 --remote 옵션을 확인하지 못했습니다"
  fi

  if "$CODE_BIN" --list-extensions 2>/dev/null \
    | grep -Fxq 'ms-vscode-remote.remote-ssh'; then
    pass "Remote - SSH 확장 설치 확인"
  else
    fail "Remote - SSH 확장이 없습니다"
    info "설치 명령: \"$CODE_BIN\" --install-extension ms-vscode-remote.remote-ssh"
  fi
else
  fail "VS Code CLI를 찾지 못했습니다"
  info "VS Code 명령 팔레트에서 Shell Command: Install 'code' command in PATH를 실행하십시오"
  info "관리자 권한이 없다면 /Applications 또는 ~/Applications의 VS Code 앱 내부 CLI를 직접 사용합니다"
fi

if command -v orb >/dev/null 2>&1; then
  if orb status >/dev/null 2>&1; then
    pass "OrbStack 실행 상태"
  else
    fail "OrbStack이 실행 중이 아니거나 상태 확인에 실패했습니다"
  fi

  if orb info codyssey-training >/dev/null 2>&1; then
    pass "codyssey-training machine 확인"
  else
    fail "codyssey-training machine을 찾지 못했습니다"
  fi
fi

if command -v ssh >/dev/null 2>&1; then
  if ssh -o BatchMode=yes -o ConnectTimeout=10 "$REMOTE_HOST" \
    'test -r /etc/os-release && grep -q "VERSION_CODENAME=noble" /etc/os-release' \
    >/dev/null 2>&1; then
    pass "OrbStack 내장 SSH 및 Ubuntu 24.04 확인"
  else
    fail "SSH 자동 확인에 실패했습니다"
    info "먼저 직접 실행: ssh $REMOTE_HOST"
  fi

  if ssh -o BatchMode=yes -o ConnectTimeout=10 "$REMOTE_HOST" \
    'command -v bash >/dev/null && command -v tar >/dev/null && { command -v curl >/dev/null || command -v wget >/dev/null; } && test -w "$HOME"' \
    >/dev/null 2>&1; then
    pass "VS Code Server 원격 요구사항 확인: bash, tar, curl/wget, HOME 쓰기"
  else
    fail "원격 요구사항 중 하나 이상을 충족하지 못했습니다"
  fi

  if ssh -o BatchMode=yes -o ConnectTimeout=10 "$REMOTE_HOST" \
    "test -d \"$REMOTE_REPO\"" >/dev/null 2>&1; then
    pass "원격 저장소 디렉터리 확인"
  else
    fail "원격 저장소 디렉터리가 없습니다: $REMOTE_REPO"
  fi
fi

if [ -n "$CODE_BIN" ]; then
  info "현재 세션에서 사용할 VS Code CLI: $CODE_BIN"
  info "REMOTE_DIR는 E1-1-training.md 10.6의 명령으로 계산하십시오"
fi

printf '\n'
if [ "$FAILURES" -eq 0 ]; then
  pass "macOS 사전 점검 완료"
  exit 0
fi

fail "사전 점검 실패 항목 수: $FAILURES"
exit 1
