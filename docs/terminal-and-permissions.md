# 터미널·권한 실습 기록

## 1. 터미널 기본 조작

### 실행 명령

```bash
pwd
ls
ls -la
mkdir
cd
touch
echo
cat
cp
mv
rm
rmdir
```

### 실제 실행 결과

```text
본인의 실제 출력 기록
```

### 설명

- 절대 경로와 상대 경로:
- `.`과 `..`:
- `cp`와 `mv`의 차이:
- `rm` 사용 시 주의점:

## 2. 파일 권한

### 변경 전

```text
ls -l 출력
```

### 실행 명령

```bash
chmod 644 permission-file.txt
chmod 600 permission-file.txt
```

### 변경 후

```text
ls -l 출력
```

## 3. 디렉터리 권한

### 실행 명령

```bash
chmod 755 permission-dir
chmod 700 permission-dir
```

### 결과

```text
ls -ld 출력
```

## 4. 이해 점검

- `755` 계산:
- `644` 계산:
- 파일의 실행 권한 `x`:
- 디렉터리의 실행 권한 `x`:
- `644 → 600` 변경이 Git diff에 나타나지 않을 수 있는 이유:

## 5. 증거

- 스크린샷 경로:
- 관련 commit:
- 관련 PR:
