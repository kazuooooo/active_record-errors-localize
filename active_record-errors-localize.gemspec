
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_record/errors/localize/version"

Gem::Specification.new do |spec|
  spec.name          = "active_record-errors-localize"
  spec.version       = ActiveRecord::Errors::Localize::VERSION
  spec.authors       = ["kazuooooo"]
  spec.email         = ["matsumotokazuya7@gmail.com"]

  spec.summary       = %q{ Localize ActiveRecord::ActiveRecordError subclasses error message with I18n }
  spec.description   = %q{ Deafault ActiveRecord::Errors class doesn't localize erorr messages. In some cases, we need localized error message for user. With this gem you can localize these error messages using I18n. }
  spec.homepage      = "https://github.com/kazuooooo/active_record-errors-localize"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/kazuooooo/active_record-errors-localize"
    spec.metadata["changelog_uri"] = "https://github.com/kazuooooo/active_record-errors-localize/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 5"
  spec.add_dependency "i18n", "~> 1"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "activerecord-nulldb-adapter"
end
