# openproject-op-plugin

OpenProject 17.x+ 용 풀스택 플러그인 (Rails Engine + Angular Module).

## 사전 요구사항

- OpenProject 코어 개발 환경 설정 완료
- Ruby 3.1+, Bundler 2.x
- Node.js 20+, npm 10+

상세 가이드: [OpenProject 개발 환경 설정](https://www.openproject.org/docs/development/)

## 설치 (개발용)

**1. `$OPENPROJECT_ROOT/Gemfile.plugins` 에 추가:**

```ruby
group :opf_plugins do
  gem "openproject-op-plugin", path: "/path/to/op-plugin"
end
```

**2. OpenProject 코어 디렉토리에서:**

```bash
bundle install
./bin/setup_dev
```

**3. 서버 시작:**

```bash
RAILS_ENV=development ./bin/rails server
RAILS_ENV=development npm run serve   # Angular 개발 서버
```

관리자 플러그인 페이지(`/admin/plugins`)에서 플러그인 확인.

## 테스트

```bash
# Ruby (단위 테스트)
bundle exec rspec spec/

# TypeScript (프론트엔드)
npm test
npm run test:coverage
```

## 라이선스

GPL-3.0 — [OpenProject](https://www.openproject.org/) 와 동일한 라이선스.
