require 'ostruct'

# Require relative all library files. No require relatives should be necessary below the next couple lines
source_files_to_require = Dir['lib/**/*.rb']
source_files_to_require.each { |file_path| require_relative file_path }

task :default do
  Rake::Task['pre_flight'].invoke
  Rake::Task['demo'].invoke
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
    puts "Adding to words.data: #{file_path}"
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
  puts "RANDOM MECHA WORD: #{FandomWord.random_word 'mecha'}"
  puts "RANDOM ANIME WORD: #{FandomWord.random_word 'anime'}"
  puts "RANDOM ANIME OR MECHA WORD: #{FandomWord.random_word %w[anime mecha]}"
  puts "RANDOM WORD: #{FandomWord.random_word}"
end

desc 'Performs common checks / house keeping as a prerequisite before submitting a pull request'
task :pre_flight do
  def system_helper(command)
    raise "One of the pre flight steps failed! #{command}" unless system command
  end

  # Validate style is up to standards
  system_helper 'bundle exec rubocop -DES'

  # Validate all tests pass
  system 'bundle exec rspec'

  # Sort original word list alphabetically
  Rake::Task['sort_word_lists'].invoke

  # Build word data
  Rake::Task['build_data'].invoke

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

desc 'Sort word list fandoms and words in alphabetical order'
task :sort_word_lists do
  require 'yaml'
  WORD_LIST_GLOB = 'word-lists/**/*.yml'.freeze
  Dir.glob(WORD_LIST_GLOB) do |file_path|
    puts "Sorting word list alphabetically: #{file_path}"
    word_list = YAML.load_file file_path
    word_list.each_value(&:sort!)
    File.open(file_path, 'w') { |file| file.write word_list.to_yaml }
  end
end
