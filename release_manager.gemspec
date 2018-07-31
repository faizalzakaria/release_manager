# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'release_manager'
  spec.version       = '0.0.1'
  spec.authors       = ['Faizal Zakaria']
  spec.email         = ['fai@code3.io']

  spec.summary       = 'Release Manager.'
  spec.description   = 'Release Manager.'
  spec.homepage      = 'https://github.com/faizalzakaria'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'capistrano', '>= 0'
  spec.add_runtime_dependency 'jira-ruby', '>= 0'
  spec.add_runtime_dependency 'json', '>= 0'
  spec.add_runtime_dependency 'octokit', '>= 0'
  spec.add_runtime_dependency 'tty-prompt', '~> 0.16.1'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '>= 0.49.1'
  spec.add_development_dependency 'pry', '>= 0'
end
