# openproject-op-plugin

OpenProject 17.5.1+ 플러그인 개발을 위한 Rails Engine + Angular Module 템플릿.

## 개요

이 레포지토리는 OpenProject 플러그인을 새로 만들 때 시작점으로 사용하는 **템플릿 레포**입니다.

- Rails Engine (Ruby 3.1+ / Rails 7) + Angular Module (TypeScript 5 / Angular 17) 풀스택 구조
- OpenProject 17.5.1+ 대상. 버전별 브랜치 전략(`release/17.x`, `release/18.x`)으로 장기 유지보수
- 개발 방법론: TDD (RED-GREEN-REFACTOR)
- 참고: [openproject-proto_plugin](https://github.com/opf/openproject-proto_plugin)

새 플러그인 시작 시 이 레포를 **Template repository**로 복제한 후, gem 이름·모듈명을 교체합니다.

---

## 사전 요구사항

| 항목 | 버전 |
|---|---|
| Ruby | 3.1+ |
| Bundler | 2.x |
| Node.js | 20+ |
| npm | 10+ |
| OpenProject core | 17.5.1+ (개발 환경 필요) |

```bash
export OPENPROJECT_ROOT=/path/to/openproject   # OpenProject 코어 디렉토리
```

---

## 설치 (개발용)

**1. `$OPENPROJECT_ROOT/Gemfile.plugins`에 등록:**

```ruby
group :opf_plugins do
  gem "openproject-op-plugin", path: "/home/raspi5p/workspace/op-plugin"
end
```

**2. OpenProject 코어에서 설치 및 프론트엔드 연결:**

```bash
cd $OPENPROJECT_ROOT
bundle install
./bin/setup_dev    # frontend/module/ symlink 생성
```

**3. 서버 시작:**

```bash
RAILS_ENV=development ./bin/rails server
RAILS_ENV=development npm run serve   # Angular 개발 서버 (hot reload)
```

관리자 플러그인 페이지(`/admin/plugins`)에서 플러그인 등록 확인.

---

## 플러그인 아키텍처

### Engine 등록 (`lib/open_project/op_plugin/engine.rb`)

```ruby
module OpenProject::OpPlugin
  class Engine < ::Rails::Engine
    engine_name :openproject_op_plugin

    include OpenProject::Plugins::ActsAsOpPlugin

    register 'openproject-op-plugin',
      author_url: 'https://github.com/hnabyz-bot',
      bundled: false do

      project_module :op_plugin do
        permission :view_op_plugin, {}
      end

      menu :project_menu, :op_plugin, { controller: '/op_plugin/entries', action: 'index' },
           caption: 'Op Plugin', icon: 'op-icon-...', last: true
    end
  end
end
```

주요 훅 포인트: `project_menu`, `top_menu`, `admin_menu`, `initializer`, `config.to_prepare`, `ActiveSupport::Notifications.subscribe`

### 프론트엔드 (`frontend/module/`)

- 진입점: `main.ts` → `$OPENPROJECT_ROOT/frontend/src/app/features/plugins/linked/op-plugin/`에 symlink
- OpenProject 코어 모듈 참조: `core-app/*` 임포트 프리픽스 사용
- 플러그인 훅 등록: `window.OpenProject.getPluginContext()`

### API (HAL+JSON)

OpenProject APIv3 HAL+JSON 규격을 따릅니다.

```ruby
# Backend: API::V3::Utilities::PathHelper 상속
# Frontend: HalResourceService 또는 직접 HTTP
```

---

## OpenProject 확장 메커니즘

플러그인이 OP 코어를 수정하는 8가지 공식 방법:

| 메커니즘 | 위치 | 용도 |
|---|---|---|
| `patches(:WorkPackage)` + `Module#prepend` | engine.rb | 모델·서비스 로직 주입 |
| `patch_with_namespace :API, :V3, ...` | engine.rb | API Representer/Contract 확장 |
| `extend_api_response(:v3, :work_packages, ...)` | engine.rb | API 응답 필드 추가 |
| `add_api_endpoint "API::V3::Root"` | engine.rb | Grape API 엔드포인트 마운트 |
| `Hook::ViewListener` | app/hooks/ | 지정 위치에 뷰 파셜 주입 |
| `add_tab_entry` | engine.rb | 탭 주입 |
| `pluginContext.hooks.*` / `pluginContext.services.*` | frontend/module/ | Angular 프론트엔드 훅 |
| `override_core_views!` | engine.rb | 뷰 전체 교체 (최후 수단) |

OP 버전 업그레이드 충돌 범위를 최소화하려면 `patches()` 단일 패치 파일 방식을 권장합니다.

---

## 빌드 & 테스트

### Ruby / RSpec

```bash
bundle install

# 단위 테스트 (OPENPROJECT_ROOT 불필요)
bundle exec rspec spec/

# 커버리지 리포트
bundle exec rspec --format progress

# 통합 테스트 (OPENPROJECT_ROOT 필요)
OPENPROJECT_ROOT=$OPENPROJECT_ROOT bundle exec rspec spec/features/

# 단일 파일
bundle exec rspec spec/controllers/op_plugin/entries_controller_spec.rb
```

### TypeScript / Jest

```bash
npm install

npm test                  # 전체 Jest 테스트
npm run test:watch        # TDD watch 모드
npm run test:coverage     # 커버리지 리포트 (임계값: 80%)
npm run build             # TypeScript 컴파일
npm run watch             # TypeScript watch 모드
npm run lint              # ESLint
```

### Angular (OPENPROJECT_ROOT 필요)

```bash
cd $OPENPROJECT_ROOT
RECOMPILE_ANGULAR_ASSETS=true npm run build   # 프로덕션 빌드
npm run serve                                  # 개발: hot reload
```

---

## MoAI 워크플로우

```bash
/moai plan "기능 설명"   # SPEC 문서 생성 → .moai/specs/
/moai run SPEC-XXX       # TDD 구현 (manager-tdd)
/moai sync SPEC-XXX      # 문서 동기화 + PR 생성
/moai review             # 코드 리뷰 + 보안 점검
/moai fix "버그 설명"    # 재현 테스트 우선 버그 수정
```

---

## MCP 서버

| 서버 | 용도 |
|---|---|
| `context7` | 라이브러리 문서 조회 (Angular, Rails, RSpec) |
| `sequential-thinking` | 심층 아키텍처 분석 (`--deepthink`) |
| `moai-lsp` | LSP 인텔리전스 (goto definition, diagnostics) |

---

## ⛔ 배포 안전 규칙

**절대 금지 — 리얼 운영 OpenProject에 플러그인을 배포하지 말 것.**

```
개발용 OP  →  플러그인 검증·테스트 허용  (별도 Docker 컨테이너)
운영 OP    →  접근 금지 (재시작·수정 포함)
```

- 운영 OP 컨테이너: `openproject-stack-openproject-1` — 절대 건드리지 않음
- 배포 명령 실행 전 반드시 대상 컨테이너 확인

---

## 라이선스

GPL-3.0 — [OpenProject](https://www.openproject.org/) 와 동일한 라이선스.
