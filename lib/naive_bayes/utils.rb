module NaiveBayes
  class Utils
    def self.break_phrase_in_word_array(phrase)
      [",", ":", "?", "!", ";", ".", "/", "|"].each do |elem|
        phrase = phrase.gsub(elem,"")
      end
      phrase.split
    end
  end
end
