require 'naive_bayes/utils'

module NaiveBayes
  class PhraseArray
    def initialize
      @phrase_array = []
    end
    def <<(phrase)
      @phrase_array << Utils.break_phrase_in_word_array(phrase)
    end
    def size
      @phrase_array.size
    end
    def [](index)
      @phrase_array[index]
    end
    def each(&block)
      @phrase_array.each(&block)
    end
    def to_s
      @phrase_array.to_s
    end
  end
end
