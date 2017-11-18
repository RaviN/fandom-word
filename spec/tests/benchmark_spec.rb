module FandomWordSpecs
  # Benchmark tests
  # words.data can be huge. To ensure proper function, including some performance tests to ensure loading of word list
  # and usage of FandomWord is within reasonable thresholds.
  module FandomWordBenchmarkSpec
    require 'rspec-benchmark'

    describe 'performance tests' do
      include ::RSpec::Benchmark::Matchers

      subject do
        FandomWord
      end

      it 'retrieve 10,000 random words under 1 second' do
        # As a singleton, list should be loaded once which should be the longest operation
        # After that, words retrieval should have a time complexity O(1) for access
        expect { 10_000.times { subject.random_word } }.to perform_under(1.00).sec
      end
    end
  end
end