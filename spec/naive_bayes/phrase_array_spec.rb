require 'spec_helper'
require 'naive_bayes/phrase_array'

describe NaiveBayes::PhraseArray do
  context 'phrase inclusion' do
    it 'should be done with operator <<' do
      phrase_array = NaiveBayes::PhraseArray.new
      phrase_array << "this is statement 1"
      phrase_array << "this is statement 2"
      phrase_array << "this is statement 3"
      expect(phrase_array.size).to be_eql(3)
    end
    it 'should break included phrase as an array of words' do
      phrase_array = NaiveBayes::PhraseArray.new
      phrase_array << "this is another phrase"
      expect(phrase_array.size).to be_eql(1)
      expect(phrase_array[0].size).to be_eql(4)
      expect(phrase_array[0][0]).to be_eql('this')
      expect(phrase_array[0][1]).to be_eql('is')
      expect(phrase_array[0][2]).to be_eql('another')
      expect(phrase_array[0][3]).to be_eql('phrase')
    end
  end
  context 'phrase and word access' do
    it 'should allow to interate through each phrase and word' do
      phrase_array = NaiveBayes::PhraseArray.new
      phrase_array << "statement 1"
      phrase_array << "statement 2"
      phrase_array << "statement 3"
      expected_values = [
        ["statement", "1"],
        ["statement", "2"],
        ["statement", "3"]
      ]
      i = 0
      j = 0
      phrase_array.each do |phrase|
        phrase.each do |word|
          expect(word).to be_eql(expected_values[i][j])
          j = j + 1
        end
        j = 0;
        i = i + 1
      end
    end
  end
end
