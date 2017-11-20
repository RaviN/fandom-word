lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name        = 'fandom-word'
  spec.version     = FandomWord::VERSION
  spec.date        = Date.today.to_s
  spec.summary     = 'Fandom Word'
  spec.description = 'A fandom word generator that returns random words from various fandoms.'
  spec.authors     = ['Ravi Nath', 'Manni Reyes']
  spec.email       = %w[majindm24@gmail.com manni.reies@gmail.com]
  spec.files       = `git ls-files`
                     .split($RS)
                     .reject { |file| file.match(/^(spec|word-lists|build)/) }
  spec.homepage    = 'http://github.com/RaviN/fandom-word'
  spec.license     = 'Unlicense'
  spec.required_ruby_version = '>= 2.1.0'
end
