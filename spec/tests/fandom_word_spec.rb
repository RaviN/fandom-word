module FandomWordSpecs
  # Holds tests for FandomWord class
  module FandomWordSpec
    describe FandomWord do
      describe '#random_word' do
        context 'Happy Paths' do
          it('No category selected') { subject.random_word }

          context 'single category' do
            it('category bigo') { subject.random_word FandomWord::Fandoms::BIGO }
            it('category anime') { subject.random_word FandomWord::Fandoms::ANIME }
          end

          it('multiple categories') { subject.random_word %w(bigo anime) }
        end

        context 'Unhappy Paths' do
          it 'non existent fandom category' do
            expect { subject.random_word 'I_AM_AN_UNLIKELY_CATEGORY' }.to raise_exception ArgumentError
          end

          context 'multiple categories' do
            it 'non existent fandom categories' do
              expect { subject.random_word %w(I_AM_AN_UNLIKELY_CATEGORY so_am_i) }.to raise_exception ArgumentError
            end

            it 'at least one non existent category among valid categories' do
              expect { subject.random_word %w(I_AM_AN_UNLIKELY_CATEGORY anime) }.to raise_exception ArgumentError
            end
          end

          it 'Invalid input type' do
            expect { subject.random_word Set.new }.to raise_exception ArgumentError
          end
        end
      end

      it('#fandoms') { subject.fandoms }
    end

    describe FandomWord::FandomRandomizer do
      # This class is a singleton, should not be able to create instances with new.
      it('#new') do
        expect { subject }.to raise_exception NoMethodError
      end
    end
  end
end
