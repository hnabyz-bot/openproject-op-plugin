# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**openproject-op-plugin** is a full-stack OpenProject plugin (Rails Engine + Angular Module) targeting OpenProject 17.5.1+.

- gem: `openproject-op-plugin` | version: `0.1.0`
- Architecture: Rails Engine (Ruby 3.1+/Rails 7) + Angular Module (TypeScript 5/Angular 17)
- Methodology: TDD (RED-GREEN-REFACTOR)
- Reference: [openproject-proto_plugin](https://github.com/opf/openproject-proto_plugin)

---

## ⛔ CRITICAL: Deployment Safety Rule

**절대 금지 — 리얼 운영 OpenProject에 플러그인을 배포하지 말 것.**

- 모든 개발·검증·테스트는 **개발용 OP 인스턴스**에서만 수행한다.
- 운영 OP(`openproject-stack-openproject-1`)는 절대 재시작하거나 수정하지 않는다.
- 개발용 OP는 별도 Docker 컨테이너로 격리 운영한다.
- 이 규칙은 어떤 상황에서도 예외 없이 적용된다.

```
개발용 OP  →  플러그인 검증/테스트 허용
운영 OP    →  접근 금지 (읽기 포함 원칙적 금지)
```

---

## Prerequisites

A working OpenProject core development environment is required:

```bash
export OPENPROJECT_ROOT=/path/to/openproject   # OpenProject core directory
```

Register the plugin in `$OPENPROJECT_ROOT/Gemfile.plugins`:

```ruby
group :opf_plugins do
  gem "openproject-op-plugin", path: "/home/raspi5p/workspace/op-plugin"
end
```

Then link the frontend:

```bash
cd $OPENPROJECT_ROOT
bundle install
./bin/setup_dev          # symlinks frontend/module/ into OP core
```

---

## Build & Test Commands

### Ruby / RSpec (Backend TDD)

```bash
bundle install

# Run all unit specs (no $OPENPROJECT_ROOT needed)
bundle exec rspec spec/

# Run with coverage report
bundle exec rspec --format progress

# Run integration specs (requires $OPENPROJECT_ROOT)
OPENPROJECT_ROOT=$OPENPROJECT_ROOT bundle exec rspec spec/features/

# Run single spec file
bundle exec rspec spec/controllers/op_plugin/entries_controller_spec.rb
```

### TypeScript / Jest (Frontend TDD)

```bash
npm install

npm test                  # Run all Jest tests
npm run test:watch        # TDD watch mode
npm run test:coverage     # Coverage report (threshold: 80%)
npm run build             # Compile TypeScript
npm run watch             # TypeScript watch mode
npm run lint              # ESLint
```

### Angular (requires $OPENPROJECT_ROOT)

```bash
# Build frontend (in OP core directory)
cd $OPENPROJECT_ROOT
RECOMPILE_ANGULAR_ASSETS=true npm run build

# Development: watch mode with hot reload
npm run serve
```

---

## MoAI Workflow

```bash
/moai plan "feature description"   # Creates SPEC → .moai/specs/
/moai run SPEC-XXX                  # TDD implementation via manager-tdd
/moai sync SPEC-XXX                 # Docs + PR
/moai review                        # Code review with security check
/moai fix "bug description"         # Reproduction-first bug fix
```

---

## Plugin Architecture

### Engine Registration (`lib/open_project/op_plugin/engine.rb`)

- Menus: `project_menu`, `top_menu`, `admin_menu`
- Permissions: `project_module :op_plugin` block
- Hooks: `initializer`, `config.to_prepare`
- Events: `ActiveSupport::Notifications.subscribe`

### Frontend (`frontend/module/`)

- Entry point: `main.ts` → symlinked to `$OPENPROJECT_ROOT/frontend/src/app/features/plugins/linked/op-plugin/`
- Use `core-app/*` import prefix for OpenProject core modules
- Register hooks via `window.OpenProject.getPluginContext()`

### API (HAL+JSON)

OpenProject uses APIv3 HAL+JSON. Access via:

```typescript
// Frontend: use the HalResourceService or direct HTTP
// Backend: inherit from API::V3::Utilities::PathHelper
```

---

## MCP Servers

| Server | Purpose |
|--------|---------|
| `context7` | Library docs (Angular, Rails, RSpec) |
| `sequential-thinking` | Deep architectural analysis (`--deepthink`) |
| `moai-lsp` | LSP intelligence (goto definition, diagnostics) |

---

## Language Settings

- Conversation: **Korean (한국어)**
- Code comments: English
- Git commits: Korean
