class Anagram
  def initialize(args)
    @wordlist = args.fetch(:wordlist)
  end

  def call(words)
    words.inject({}) do |results, word|
      results.tap { |results| results[word] = find_anagrams(word) }
    end
  end

  private

  attr_reader :wordlist

  def find_anagrams(word)
    sorted_word = sort_word(word)

    wordlist.inject([]) do |anagrams, word_from_list|
      anagrams.tap do |anagrams|
        anagrams << word_from_list if sorted_word == sort_word(word_from_list)
      end
    end
  end

  def sort_word(word)
    word.chars.sort
  end
end
