Gem::Specification.new do |s|
  s.name = %q{couchrest_model_cloudant}
  s.version = '0.1.0'
 
  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gabe Malicki"]
  s.date = '2013-10-10'
  s.description = %q{Extends couchrest_model to provide support for creating and querying Cloudant Search indexes.}
  s.email = %q{blah@foo.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.license = 'Apache'
  s.homepage = %q{http://github.com/gxbe/couchrest_model_cloudant}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Extends couchrest_model adding support for the Cloudant Search API}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency(%q<couchrest_model>, ">= 2.0.0")
end
