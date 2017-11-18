require 'ostruct'

# Require relative all library files. No require relatives should be necessary below the next couple lines
source_files_to_require = Dir['lib/**/*.rb']
source_files_to_require.each { |file_path| require_relative file_path }

task :default do
  Rake::Task["demo"].invoke
end

desc 'Collects all word lists and compiles into words.data'
task :build_data do
  require 'erb'

  require 'yaml'

  DATA_FILE = 'data/words.data'.freeze
  WORD_LIST_GLOB = 'word-lists/**/*.yml'.freeze

  File.delete(DATA_FILE) if File.exist? DATA_FILE

  catalog = FandomWord::FandomWordCatalog.new

  Dir.glob(WORD_LIST_GLOB) do |file_path|
    puts "Processing: #{file_path}"
    word_list = YAML.load_file(file_path)
    word_list[:words].each do |word|
      catalog.add_word(word, word_list[:categories])
    end
  end

  File.open(DATA_FILE, 'wb') do |file|
    file.write(Marshal.dump(catalog))
  end

  # used for binding when rendering ERB template
  class Dummy < OpenStruct
    def render(template)
      ERB.new(template, nil, '-').result(binding)
    end
  end

  erb = Dummy.new(fandoms: catalog.fandoms)
  File.write('lib/fandoms.rb', erb.render(File.read('build/fandoms.rb.erb')))
end

desc 'Perform a couple demonstrations of FandomWord'
task :demo do
  puts "RANDOM MECHA WORD: #{FandomWord.random_word_from_fandom 'mecha'}"
  puts "RANDOM ANIME WORD: #{FandomWord.random_word_from_fandom 'anime'}"
  puts "RANDOM ANIME OR MECHA WORD: #{FandomWord.random_word_from_fandom %w[anime mecha]}"
  puts "RANDOM WORD: #{FandomWord.random_word}"
end

desc 'Performs common checks / house keeping as a prerequisite before submitting a pull request'
task :preflight do
  # Validate style is up to standards
  system 'bundle exec rubocop'

  # Validate all tests pass
  system 'bundle exec rspec'

  # Document code
  system 'bundle exec yard'
end

desc 'Get benchmark'
task :determine_benchmark_ips do
  require 'benchmark/ips'

  Benchmark.ips do |x|
    x.config time: 5, warmup: 2
    x.report('Get Random Word') { FandomWord.random_word }
    x.compare!
  end
end