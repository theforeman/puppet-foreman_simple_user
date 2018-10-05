require 'puppetlabs_spec_helper/rake_tasks'

# blacksmith isn't always present, e.g. on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
  Blacksmith::RakeTask.new do |t|
    t.tag_pattern = "%s"
  end
rescue LoadError
end

require 'puppet-lint-param-docs/tasks'
PuppetLintParamDocs.define_selective do |config|
  config.pattern = ["manifests/init.pp", "manifests/user.pp"]
end

require 'kafo_module_lint/tasks'
KafoModuleLint::RakeTask.new do |config|
  config.pattern = ["manifests/init.pp", "manifests/user.pp"]
end

task :default => [:release_checks]
