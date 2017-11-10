require 'ostruct'
require_relative 'lib/fandom_word'

task :default do
  puts "RANDOM MECHA WORD: #{FandomWord.random_word_from_fandom 'mecha'}"
  puts "RANDOM ANIME WORD: #{FandomWord.random_word_from_fandom 'anime'}"
  puts "RANDOM CATEGORY WORD: #{FandomWord.random_word}"
end

task :build_data do
  require 'erb'

  require 'yaml'
  require_relative 'lib/fandom_word_catalog'

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
