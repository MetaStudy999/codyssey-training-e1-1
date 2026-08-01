# 바인드 마운트 검증 기록

## 1. 사용 경로

- 호스트 디렉터리: `bind-test/`
- 컨테이너 디렉터리: `/usr/share/nginx/html`
- 선택 포트:
- 읽기 전용 옵션: `:ro`

## 2. 실행 명령

```bash
source .env.local

docker run -d \
  --name e1-1-bind \
  -p "${HOST_PORT}:80" \
  -v "$PWD/bind-test:/usr/share/nginx/html:ro" \
  nginx:alpine
```

## 3. 변경 전

- 파일 내용:
- `curl` 결과:
- 브라우저 화면:

## 4. 변경 후

- 수정한 파일:
- `curl` 결과:
- 브라우저 화면:

## 5. 설명

- 이미지를 다시 빌드하지 않아도 반영된 이유:
- `:ro`의 의미:
- 바인드 마운트가 호스트 경로에 의존하는 이유:

## 6. 증거

- 스크린샷 경로:
- 관련 commit:
- 관련 PR:
