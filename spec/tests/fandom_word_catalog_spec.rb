module FandomWordSpecs
  # Holds tests for FandomWord class
  module FandomWordCatalogSpec
    describe FandomWord::FandomWordCatalog do
      it('#add_word') { subject.add_word (_new_word = 'wubalubadubdub'), (_categories = %w[rick_and_morty]) }
    end
  end
end
