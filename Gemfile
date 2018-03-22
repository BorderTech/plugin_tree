source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 3.3']
gem 'metadata-json-lint'
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 1.0.0'
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '>= 1.7.0'
gem 'rspec-puppet'
gem 'zip', '>= 1.2.0'
gem 'serverspec'
gem 'infrataster'
gem 'rspec_junit_formatter'

# for addtional testing and linting
# needs to be checked hat is working with Ruby 2.0.0
# and if we need all of it.
# gem 'semantic_puppet'
# gem 'rspec_junit_formatter'
# gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
# gem 'puppet-lint-explicit_hiera_class_param_lookup-check'
# gem 'puppet-lint-security-plugins'
# # gem 'puppet-lint-indent-check' # caused error with puppet-lint
# gem 'puppet-lint-absolute_classname-check'
# gem 'puppet-lint-leading_zero-check'
# gem 'puppet-lint-unquoted_string-check'
# gem 'puppet-lint-variable_contains_upcase'
# gem 'puppet-lint-numericvariable'
# gem 'puppet-lint-param-docs'
# # gem 'puppet-retrospec'

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
  gem 'rake', '~> 10.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop'
end
