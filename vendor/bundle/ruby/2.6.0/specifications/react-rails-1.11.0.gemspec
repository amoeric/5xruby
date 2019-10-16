# -*- encoding: utf-8 -*-
# stub: react-rails 1.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "react-rails".freeze
  s.version = "1.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Paul O\u2019Shannessy".freeze]
  s.date = "2017-04-04"
  s.description = "Compile your JSX on demand or precompile for production.".freeze
  s.email = ["paul@oshannessy.com".freeze]
  s.homepage = "https://github.com/reactjs/react-rails".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.0.1".freeze
  s.summary = "React/JSX adapter for the Ruby on Rails asset pipeline.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.2.2"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, [">= 0"])
      s.add_development_dependency(%q<coffee-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<es5-shim-rails>.freeze, [">= 2.0.5"])
      s.add_development_dependency(%q<guard>.freeze, [">= 0"])
      s.add_development_dependency(%q<guard-minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<jbuilder>.freeze, [">= 0"])
      s.add_development_dependency(%q<listen>.freeze, ["~> 3.0.0"])
      s.add_development_dependency(%q<poltergeist>.freeze, [">= 0.3.3"])
      s.add_development_dependency(%q<test-unit>.freeze, ["~> 2.5"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<connection_pool>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<execjs>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<tilt>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<babel-transpiler>.freeze, [">= 0.7.0"])
    else
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.2.2"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, [">= 0"])
      s.add_dependency(%q<coffee-rails>.freeze, [">= 0"])
      s.add_dependency(%q<es5-shim-rails>.freeze, [">= 2.0.5"])
      s.add_dependency(%q<guard>.freeze, [">= 0"])
      s.add_dependency(%q<guard-minitest>.freeze, [">= 0"])
      s.add_dependency(%q<jbuilder>.freeze, [">= 0"])
      s.add_dependency(%q<listen>.freeze, ["~> 3.0.0"])
      s.add_dependency(%q<poltergeist>.freeze, [">= 0.3.3"])
      s.add_dependency(%q<test-unit>.freeze, ["~> 2.5"])
      s.add_dependency(%q<rails>.freeze, [">= 3.2"])
      s.add_dependency(%q<connection_pool>.freeze, [">= 0"])
      s.add_dependency(%q<execjs>.freeze, [">= 0"])
      s.add_dependency(%q<railties>.freeze, [">= 3.2"])
      s.add_dependency(%q<tilt>.freeze, [">= 0"])
      s.add_dependency(%q<babel-transpiler>.freeze, [">= 0.7.0"])
    end
  else
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.2.2"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, [">= 0"])
    s.add_dependency(%q<coffee-rails>.freeze, [">= 0"])
    s.add_dependency(%q<es5-shim-rails>.freeze, [">= 2.0.5"])
    s.add_dependency(%q<guard>.freeze, [">= 0"])
    s.add_dependency(%q<guard-minitest>.freeze, [">= 0"])
    s.add_dependency(%q<jbuilder>.freeze, [">= 0"])
    s.add_dependency(%q<listen>.freeze, ["~> 3.0.0"])
    s.add_dependency(%q<poltergeist>.freeze, [">= 0.3.3"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 2.5"])
    s.add_dependency(%q<rails>.freeze, [">= 3.2"])
    s.add_dependency(%q<connection_pool>.freeze, [">= 0"])
    s.add_dependency(%q<execjs>.freeze, [">= 0"])
    s.add_dependency(%q<railties>.freeze, [">= 3.2"])
    s.add_dependency(%q<tilt>.freeze, [">= 0"])
    s.add_dependency(%q<babel-transpiler>.freeze, [">= 0.7.0"])
  end
end
