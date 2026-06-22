# 기술 스택 — openproject-op-plugin

## 백엔드

| 항목 | 기술 |
|---|---|
| 언어 | Ruby 3.1+ |
| 프레임워크 | Rails 7.x (Engine) |
| 데이터베이스 | PostgreSQL (OpenProject 코어 공유) |
| 테스트 | RSpec 6.x |
| 패키지 관리 | Bundler / RubyGems |
| API 형식 | HAL+JSON (APIv3) |

## 프론트엔드

| 항목 | 기술 |
|---|---|
| 언어 | TypeScript 5.x |
| 프레임워크 | Angular 17+ |
| 빌드 | Angular CLI (AOT), OpenProject 코어 webpack |
| 테스트 | Jest 29.x |
| 패키지 관리 | npm |

## OpenProject 버전

- 대상: **OpenProject 17.5.1+** (최신 안정 버전)
- 플러그인 gem 의존: `openproject-plugins >= 15.0.0`

## 개발 환경 요구사항

```bash
# 필수
ruby 3.1+
bundler 2.x
node 20+
npm 10+

# OpenProject 코어 (별도 설치 필요)
# https://www.openproject.org/docs/development/development-environment/
```

## 빌드 및 테스트 명령어

```bash
# Ruby / RSpec
bundle install
bundle exec rspec                      # 전체 테스트
bundle exec rspec spec/controllers/    # 컨트롤러 테스트만
bundle exec rspec spec/models/         # 모델 테스트만

# TypeScript / Jest
npm install
npm test                               # 전체 Jest 테스트
npm run test:watch                     # 감시 모드

# 빌드 (OpenProject 코어 디렉토리에서)
RECOMPILE_ANGULAR_ASSETS=true npm run build
```

## LSP 설정

- Ruby: `ruby-lsp` (`which ruby-lsp`)
- TypeScript: `typescript-language-server` (`which typescript-language-server`)
