# Daoutech View Custom Plugin

다우기술 레드마인 환경을 위한 뷰 커스텀 플러그인입니다. 초기화면 대시보드 시각화, 일감 상세 페이지 확장, 프로젝트별 필수 항목 관리 등의 기능을 제공하여 협업 효율성을 높입니다.

---

## 📋 주요 기능

### 1. 프로젝트별 이슈 현황 대시보드
- **시각화**: 레드마인 접속 시 첫 화면(Welcome index)에 프로젝트별 이슈 처리 현황을 Pie Chart로 제공합니다.
- **기간 필터링**: 시작일과 종료일을 설정하여 특정 기간(최대 365일) 동안 생성된 일감의 현황을 조회할 수 있습니다.
- **빠른 이동**: 차트의 각 상태 영역을 클릭하면 해당 프로젝트의 필터링된 이슈 목록으로 즉시 이동합니다.
- **Chart.js v4**: 최신 Chart.js 라이브러리를 내장하여 깔끔하고 반응성 있는 차트를 제공합니다.

### 2. 일감 상세 페이지 확장
일감 상세 페이지(`issues/show`) 하단에 주요 타임스탬프 정보를 명확하게 표시합니다:
- **등록자**: 일감을 생성한 사용자
- **생성일**: 최초 생성 일시
- **변경일**: 마지막 수정 일시
- **종료일**: 일감이 완료 상태로 변경된 일시

### 3. 프로젝트별 필수 항목 설정
- **프로젝트 설정 탭**에서 필수 항목을 유연하게 관리할 수 있습니다.
- **관리 가능한 필드**:
    - 기본 필드 (담당자, 범주 등)
    - 커스텀 필드 (사용자 정의 항목)
- 설정된 필드는 해당 프로젝트 내에서 일감 생성/수정 시 입력을 강제합니다.

### 4. 사용자 경험(UX) 개선
- **프로젝트 링크**: 프로젝트 이름 클릭 시 '개요' 페이지 대신 실무 중심의 **'이슈 목록'** 페이지로 바로 이동합니다.
- **커스텀 스타일**: 플러그인 전용 CSS를 통해 가독성 높은 대시보드와 UI를 제공합니다.

---

## 🛠 환경 구성

본 플러그인은 아래 환경에서 개발 및 테스트되었습니다.

- **OS**: Windows (Docker Desktop)
- **Docker Compose**: 2.40.3
- **Redmine**: 6.0.6
- **Ruby**: 3.2.9
- **Puma**: 7.0.1
- **Rails**: 7.2.2.1

---

## 📦 설치 방법

### 1. 플러그인 다운로드
레드마인의 `plugins` 디렉토리로 이동하여 저장소를 복제합니다.  
⚠️ **폴더명은 반드시 `daou_view_custom`이어야 합니다.**

```bash
cd {REDMINE_ROOT}/plugins
git clone [repository_url] daou_view_custom
```

### 2. 의존성 설치
레드마인 루트 디렉토리에서 번들러를 실행합니다.

```bash
cd {REDMINE_ROOT}
bundle install --without development test
```

### 3. 데이터베이스 마이그레이션 (필수)
플러그인 전용 테이블(`project_required_fields`)을 생성합니다.

```bash
bundle exec rake redmine:plugins:migrate NAME=daou_view_custom RAILS_ENV=production
```

### 4. 서버 재시작
변경 사항 적용을 위해 레드마인 서버를 재시작합니다.

```bash
# Apache/Passenger의 경우
touch tmp/restart.txt

# Puma/Unicorn의 경우
sudo systemctl restart redmine

# Docker의 경우
docker-compose restart redmine
```

---

## ⚙️ 사용 방법

### 프로젝트별 필수 항목 설정

1. **프로젝트 설정 접속**
   - 프로젝트 페이지로 이동
   - **설정(Settings)** 탭 클릭

2. **필수 필드 선택**
   - 좌측 메뉴에서 **필수 필드 설정** 클릭
   - 일감 생성 시 필수로 입력받을 필드 선택
   - 기본 필드와 커스텀 필드 중 선택 가능

3. **저장**
   - **저장** 버튼 클릭

### 대시보드 사용

1. **레드마인 홈 접속**
   - 레드마인 메인 페이지(Welcome) 접속

2. **프로젝트별 차트 확인**
   - 각 프로젝트의 이슈 현황이 Pie Chart로 표시됨
   - 차트 위의 기간 필터를 조정하여 원하는 기간의 데이터 확인

3. **차트 클릭**
   - 차트의 각 영역을 클릭하면 해당 상태의 이슈 목록으로 이동

---

## 🗑 삭제 방법

### 1. 데이터베이스 롤백
플러그인 제거 전, 생성된 테이블을 삭제하기 위해 마이그레이션을 롤백합니다.

```bash
cd {REDMINE_ROOT}
bundle exec rake redmine:plugins:migrate NAME=daou_view_custom VERSION=0 RAILS_ENV=production
```

### 2. 디렉토리 삭제
플러그인 디렉토리를 제거합니다.

```bash
rm -rf plugins/daou_view_custom
```

### 3. 서버 재시작
서버를 재시작하여 플러그인을 완전히 제거합니다.

```bash
# Apache/Passenger의 경우
touch tmp/restart.txt

# Puma/Unicorn의 경우
sudo systemctl restart redmine

# Docker의 경우
docker-compose restart redmine
```

---

## 📌 버전 정보

- **플러그인 버전**: 0.0.3
- **지원 Redmine 버전**: 6.0 이상 (Redmine 6.X 테스트 완료)

---

## 📝 라이선스

Daoutech 내부 사용 전용

