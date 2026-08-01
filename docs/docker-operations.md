# Docker 기본 운영 기록

## 1. 버전과 Engine

```bash
docker --version
docker version
docker info
```

### 실제 결과

```text
본인의 실제 출력 기록
```

## 2. 이미지와 컨테이너 상태

```bash
docker images
docker ps
docker ps -a
docker stats --no-stream
```

## 3. hello-world

```bash
docker run --name e1-1-hello hello-world
docker logs e1-1-hello
```

- 실행 결과:
- 이미지와 컨테이너 차이:

## 4. Ubuntu 컨테이너

```bash
docker run -d \
  --name e1-1-ubuntu \
  ubuntu:24.04 \
  bash -lc 'echo "e1-1-ubuntu started"; sleep infinity'

docker logs e1-1-ubuntu
docker exec -it e1-1-ubuntu bash
```

- `sleep infinity`를 사용한 이유:
- `docker run`과 `docker start` 차이:
- `docker exec` 사용 목적:

## 5. Dockerfile 빌드

```bash
docker build -t codyssey-e1-1-web:1.0 .
docker image inspect codyssey-e1-1-web:1.0
```

- 빌드 결과:
- `FROM`:
- `COPY`:
- `EXPOSE`:
- `.dockerignore`:

## 6. 증거

- 스크린샷 경로:
- 관련 commit:
- 관련 PR:
