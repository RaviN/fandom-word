module FandomWord
  # FandomWordCatalog is a catalog holding all words in groups of fandoms.
  class FandomWordCatalog
    def initialize
      @fandoms = {}
    end

    # Returns an array of words associated with the specified fandom. Initializes fandom in catalog if not present.
    def fetch_fandom(fandom)
      # grab the category if it exists, if not make it empty array
      @fandoms.keys.include?(fandom) ? @fandoms[fandom] : @fandoms[fandom] = []
    end

    # Adds a word to a fandom
    def add_word(new_word, categories)
      categories.each do |category|
        fandom = fetch_fandom(category)
        fandom << new_word unless fandom.include? new_word
      end
    end

    # Returns the list of fandoms (categories)
    def fandoms
      @fandoms.keys
    end
  end
end
