# 실행 환경

> 본인의 실제 명령 출력과 확인 날짜를 기록합니다. 예시 값을 그대로 제출하지 않습니다.

## macOS 호스트

- Mac 모델:
- CPU 아키텍처:
- macOS 버전:
- OrbStack 버전:
- Docker context:
- 확인 날짜:

### 확인 명령

```bash
sw_vers
uname -m
orb version
orb list
docker version
docker context show
```

## OrbStack Ubuntu

- machine 이름: `codyssey-training`
- 배포판: Ubuntu 24.04 LTS
- CPU 아키텍처:
- 사용자:
- Shell:
- Git 버전:
- GitHub CLI 버전:
- Docker 버전:
- 작업 경로:
- 확인 날짜:

### 확인 명령

```bash
cat /etc/os-release
uname -a
uname -m
whoami
printf '%s\n' "$SHELL"
git --version
gh --version | head -n 1
docker --version
docker version
docker info
pwd
```

## 검증 결과

- [ ] Ubuntu 24.04 또는 `VERSION_CODENAME=noble`
- [ ] `docker version` Client·Server 확인
- [ ] `docker info` 성공
- [ ] `docker run --rm hello-world` 성공
- [ ] Docker build path test 성공
- [ ] Docker bind mount path test 성공
