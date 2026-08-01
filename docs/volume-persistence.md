# Docker 볼륨 영속성 검증 기록

## 1. 볼륨

- 볼륨 이름: `e1-1-data`
- 생성 명령:

```bash
docker volume create e1-1-data
docker volume ls
```

## 2. 첫 번째 컨테이너

```bash
docker run -d \
  --name e1-1-volume-1 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity
```

- 데이터 작성 명령:
- 작성 결과:

## 3. 컨테이너 삭제

```bash
docker rm -f e1-1-volume-1
```

- 삭제 확인:

## 4. 두 번째 컨테이너

```bash
docker run -d \
  --name e1-1-volume-2 \
  -v e1-1-data:/data \
  ubuntu:24.04 \
  sleep infinity

docker exec e1-1-volume-2 cat /data/result.txt
```

- 실제 출력:
- `persistent data` 확인 여부:

## 5. 설명

- 컨테이너를 삭제해도 데이터가 남은 이유:
- 바인드 마운트와 볼륨의 관리 주체 차이:
- 소스코드와 장기 데이터에 적합한 저장 방식:

## 6. 증거

- 스크린샷 경로:
- 관련 commit:
- 관련 PR:
