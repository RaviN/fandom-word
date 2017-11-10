module FandomWord
  # FandomWordCatalog class
  class FandomWordCatalog
    def initialize
      @fandoms = {}
    end

    def fetch_fandom(fandom)
      # grab the category if it exists, if not make it empty array
      @fandoms.keys.include?(fandom) ? @fandoms[fandom] : @fandoms[fandom] = []
    end

    def add_word(new_word, categories)
      categories.each do |category|
        fandom = fetch_fandom(category)
        fandom << new_word unless fandom.include? new_word
      end
    end

    def fandoms
      @fandoms.keys
    end
  end
end
