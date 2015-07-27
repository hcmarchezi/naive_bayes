require 'spec_helper'
require 'naive_bayes/utils'

describe NaiveBayes::Utils do
  context 'string break in words' do
    it 'should be brokwn in array of words and remove punctuation marks' do
      phrase = "word1, word2? word3! word4: word5; word6. word7 word8/ word9|"
      expected_array = ["word1", "word2", "word3", "word4", "word5", "word6", "word7", "word8", "word9"]
      actual_array = NaiveBayes::Utils.break_phrase_in_word_array(phrase)
      expect(actual_array).to be_eql(expected_array)
    end
  end
end
