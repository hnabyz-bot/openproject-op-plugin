# 프로젝트 구조 — openproject-op-plugin

## 아키텍처 패턴

Rails Engine + Angular Module (OpenProject proto_plugin 패턴 기반)

## 디렉토리 구조

```
openproject-op-plugin/
├── app/
│   ├── controllers/
│   │   └── op_plugin/
│   │       └── entries_controller.rb     # 플러그인 컨트롤러
│   ├── models/
│   │   └── (커스텀 모델)
│   └── views/
│       └── op_plugin/
│           └── entries/
│               └── index.html.erb
├── config/
│   ├── locales/
│   │   ├── en.yml                        # 영어 번역
│   │   └── ko.yml                        # 한국어 번역
│   └── routes.rb                         # 플러그인 라우트
├── db/
│   └── migrate/                          # DB 마이그레이션 (Rails)
├── frontend/
│   └── module/
│       ├── main.ts                       # Angular 진입점 (심링크 타겟)
│       ├── op-plugin.module.ts           # Angular NgModule
│       ├── components/                   # Angular 컴포넌트
│       └── global_styles.scss            # 전역 스타일
├── lib/
│   └── open_project/
│       └── op_plugin/
│           ├── engine.rb                 # Rails Engine 등록
│           └── version.rb               # 버전
├── spec/
│   ├── spec_helper.rb
│   ├── rails_helper.rb
│   ├── controllers/
│   └── features/                        # Integration / E2E
├── .rspec
├── Gemfile
├── openproject-op-plugin.gemspec
├── package.json                          # npm (프론트엔드)
└── tsconfig.json                         # TypeScript 설정
```

## 핵심 파일

| 파일 | 역할 |
|---|---|
| `lib/open_project/op_plugin/engine.rb` | 플러그인 등록, 메뉴/권한/훅 정의 |
| `frontend/module/main.ts` | Angular 모듈 진입점 (OP 코어에 심링크) |
| `config/routes.rb` | 플러그인 URL 라우팅 |
| `openproject-op-plugin.gemspec` | gem 메타데이터 및 의존성 |

## OpenProject 코어 연동 방법

플러그인 프론트엔드는 `$OPENPROJECT_ROOT/frontend/src/app/features/plugins/linked/op-plugin/` 에 심링크됩니다. `./bin/setup_dev` 실행 시 자동 처리.
