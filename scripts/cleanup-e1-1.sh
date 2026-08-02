#!/usr/bin/env bash

# E1-1 전용 Docker 자원 정리
# 제출·스크린샷·평가 확인이 끝난 뒤에만 실행합니다.
# 실행: bash scripts/cleanup-e1-1.sh
# 이미지까지 지우려면: bash scripts/cleanup-e1-1.sh --images

set -u

REMOVE_IMAGES=0
if [ "${1:-}" = "--images" ]; then
  REMOVE_IMAGES=1
fi

CONTAINERS=(
  e1-1-hello
  e1-1-ubuntu
  e1-1-web
  e1-1-bind
  e1-1-volume-1
  e1-1-volume-2
  e1-1-retest
  e1-1-final
)

IMAGES=(
  codyssey-e1-1-web:1.0
  codyssey-e1-1-web:retest
  codyssey-e1-1-web:final
  codyssey-e1-1-web:final-check
  orb-path-test
)

printf '이 스크립트는 E1-1 이름을 가진 자원만 정리합니다.\n'
printf 'docker system prune은 실행하지 않습니다.\n'
read -r -p '제출과 증거 확인이 끝났습니까? 계속하려면 CLEANUP 입력: ' ANSWER

if [ "$ANSWER" != "CLEANUP" ]; then
  printf '정리를 취소했습니다.\n'
  exit 0
fi

for container_name in "${CONTAINERS[@]}"; do
  if docker container inspect "$container_name" >/dev/null 2>&1; then
    docker rm -f "$container_name"
  fi
done

if docker volume inspect e1-1-data >/dev/null 2>&1; then
  docker volume rm e1-1-data
fi

if [ "$REMOVE_IMAGES" -eq 1 ]; then
  for image_name in "${IMAGES[@]}"; do
    if docker image inspect "$image_name" >/dev/null 2>&1; then
      docker image rm "$image_name" || true
    fi
  done
fi

printf '[PASS] E1-1 범위의 Docker 자원 정리 완료\n'
