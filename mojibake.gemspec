$:.unshift File.expand_path('../lib', __FILE__)
require 'mojibake/base'

Gem::Specification.new do |s|
  s.name = 'mojibake'
  s.summary = 'Recover mojibake text using a reverse-mapping table'
  s.version = MojiBake::VERSION
  s.authors  = ['David Kellum']
  s.email    = ['dek-oss@gravitext.com']
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test`.split("\n")

  s.add_dependency 'json', '>= 1.7.5'
  s.add_development_dependency 'minitest', '~> 4.7.4'
end
