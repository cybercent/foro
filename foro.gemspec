# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "foro/version"

Gem::Specification.new do |s|
  s.name        = "foro"
  s.version     = Foro::VERSION
  s.authors     = ["DOPE"]
  s.email       = ["dope@gmail.co.jp"]
  s.homepage    = "https://github.com/slash7/foro"
  s.summary     = %q{フォロー A Rubygem to add Follow functionality for ActiveRecord models}
  s.description = %q{Forō is a Rubygem to allow any model to follow the same model. There is also built in support for blocking/un-blocking follow records. Main uses would be for Users to follow other Users.}
  s.license     = 'MIT'

  s.rubyforge_project = "foro"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "shoulda_create"
  s.add_development_dependency "shoulda", ">= 3.5.0"
  s.add_development_dependency "factory_girl", ">= 4.2.0"
end
