# OpenProject op-plugin

## 프로젝트 개요

OpenProject 17.x+ 용 **풀스택 플러그인**. Rails Engine(백엔드 API/훅) + Angular Module(프론트엔드 UI)을 결합한 확장 플러그인.

- gem 이름: `openproject-op-plugin`
- 참조 구조: [openproject-proto_plugin](https://github.com/opf/openproject-proto_plugin)
- 개발 방법론: TDD (RED-GREEN-REFACTOR)

## 대상 사용자

OpenProject Community/Enterprise 인스턴스를 운영하는 팀 및 조직.

## 핵심 기능

> 플러그인 기능은 개발 과정에서 SPEC을 통해 정의됩니다. `/moai plan "기능 설명"` 으로 시작하세요.

기본 제공 확장 포인트:
- 프로젝트 메뉴 항목 등록
- 워크패키지 탭/패널 추가
- 커스텀 API 엔드포인트 (APIv3 HAL+JSON)
- 이벤트 훅 (project_created, work_package_updated 등)
- 관리자 설정 페이지
- DB 마이그레이션

## 전제 조건

- OpenProject 코어 개발 환경 (`$OPENPROJECT_ROOT` 설정 필요)
- Ruby 3.x, Rails 7.x
- Node.js 20+, Angular CLI

## 개발 환경 연결

```bash
# OpenProject 코어 Gemfile.plugins 에 추가:
group :opf_plugins do
  gem "openproject-op-plugin", path: "/path/to/op-plugin"
end

# 코어 디렉토리에서:
bundle install
./bin/setup_dev  # 프론트엔드 심링크 설정
```
