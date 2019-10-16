# -*- encoding: utf-8 -*-
# stub: twsms2 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "twsms2".freeze
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Guanting Chen".freeze]
  s.bindir = "exe".freeze
  s.date = "2016-09-06"
  s.description = "2016 \u65B0\u7248 \u53F0\u7063\u7C21\u8A0A TwSMS API ( \u7D14 Ruby / Rails \u5C08\u6848\u9069\u7528 )".freeze
  s.email = ["cgt886@gmail.com".freeze]
  s.homepage = "https://github.com/guanting112/twsms2".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new("~> 2".freeze)
  s.rubygems_version = "3.0.1".freeze
  s.summary = "2016 \u65B0\u7248 \u53F0\u7063\u7C21\u8A0A TwSMS API ( \u7D14 Ruby / Rails \u5C08\u6848\u9069\u7528 )".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
  end
end
