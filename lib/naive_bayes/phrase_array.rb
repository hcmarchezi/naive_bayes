module NaiveBayes
  class PhraseArray
    def initialize
      @phrase_array = []
    end
    def <<(phrase)
      @phrase_array << break_phrase_in_word_array(phrase)
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
    private
    def break_phrase_in_word_array(phrase)
      [",", ":", "?", "!", ";", ".", "/", "|"].each do |elem|
        phrase = phrase.gsub(elem,"")
      end
      phrase.split
    end
  end
end
