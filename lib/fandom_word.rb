# Holds all classes and methods for Fandom Word
module FandomWord
  require 'singleton'

  class << self
    # Returns random word from any fandom in catalog. Fandom category can be specified.
    #
    # @param [String, Array] fandom_name_or_names Fandom category or array of categories
    # @return [String] Random word
    def random_word(fandom_name_or_names = nil)
      if fandom_name_or_names
        FandomRandomizer.instance.random_word fandom_name_or_names
      else
        FandomRandomizer.instance.random_word
      end
    end

    # Returns the list of fandoms (categories)
    def fandoms
      FandomRandomizer.instance.available_fandoms
    end
  end

  # Provides singleton interface with fandom word catalog to allow retrieval of random words, random words based on
  # fandoms and list of all available fandoms
  class FandomRandomizer
    include Singleton
    require 'pathname'
    require 'securerandom'
    require_relative 'fandom_word_catalog'

    DATA_PATH = '../data/words.data'.freeze
    private_constant :DATA_PATH

    # Caches word catalog into memory for performance
    def initialize
      load_word_catalog
    end

    # Returns random word from any fandom in catalog. Fandom category can be specified.
    #
    # @param [String, Array] fandom_name_or_names Fandom category or array of categories
    # @return [String] Random word
    def random_word(fandom_name_or_names = random_fandom)
      fandom_name = case fandom_name_or_names
                    when Array
                      validate_fandom_list fandom_name_or_names
                      random_fandom_name_from fandom_name_or_names
                    when String
                      fandom_name_or_names
                    else
                      raise ArgumentError, "Argument must be [Array, String] not #{fandom_name_or_names.class}"
                    end

      fetch_fandom fandom_name
    end

    # Returns the list of fandoms (categories)
    def available_fandoms
      @catalog.fandoms
    end

    private

    def fetch_fandom(fandom_name)
      validate_fandom fandom_name
      category = @catalog.fetch_fandom fandom_name
      category[SecureRandom.random_number category.size]
    end

    def random_fandom
      random_fandom_name_from available_fandoms
    end

    def random_fandom_name_from(fandom_list)
      fandom_list[SecureRandom.random_number fandom_list.size]
    end

    def load_word_catalog
      file_path = Pathname(File.dirname(__FILE__)) + DATA_PATH
      source = File.read(file_path, mode: 'rb')
      # rubocop:disable Security/MarshalLoad
      @catalog = Marshal.load(source) if @catalog.nil?
    end

    def validate_fandom(fandom_name)
      return if available_fandoms.include? fandom_name
      raise ArgumentError, "Invalid #{fandom_name}, Valid fandoms #{available_fandoms}"
    end

    # Raises if fandom_list is using a fandom not in available fandoms
    def validate_fandom_list(fandom_list)
      return if (fandom_list & available_fandoms).size == fandom_list.size
      raise ArgumentError, "Explicit List: #{fandom_list} \n Available Fandoms: #{available_fandoms}"
    end
  end
end
