# FandomWord module
module FandomWord
  require 'singleton'

  class << self
    def random_word
      FandomWord::FandomRandomizer.instance.random_word
    end

    def random_word_from_fandom(fandom_name)
      FandomWord::FandomRandomizer.instance.random_word_from_fandom(fandom_name)
    end
  end

  # FandomRandomizer class - randomly selects Fandom Words
  class FandomRandomizer
    include Singleton
    require 'pathname'
    require 'securerandom'
    require_relative 'fandom_word_catalog'

    attr_accessor :catalog

    DATA_PATH = '../data/words.data'.freeze

    def initialize
      load_word_catalog
    end

    def random_word
      fandoms = @catalog.fandoms
      random_index = SecureRandom.random_number(fandoms.size)
      random_fandom = @catalog.fetch_fandom(fandoms[random_index])
      random_fandom[SecureRandom.random_number random_fandom.size]
    end

    def random_word_from_fandom(fandom_name)
      category = @catalog.get_category fandom_name
      category[SecureRandom.random_number category.size]
    end

    def available_fandoms
      @catalog.fandoms
    end

    def load_word_catalog
      file_path = Pathname(File.dirname(__FILE__)) + DATA_PATH
      source = File.read(file_path, mode: 'rb')
      # rubocop:disable Security/MarshalLoad
      @catalog = Marshal.load(source) if @catalog.nil?
    end
  end
end
