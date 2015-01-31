class LoremIpsumWordSource
  def initialize(args)
    @word_source = args.fetch(:word_source).strip.split(",")
    @callback    = args.fetch(:callback) { Object.new }
    initialize_counters
  end

  def next_word
    take_next_word { |word|
      increment_counters(word)
      callback.run if special_word?(word)
    }
  end

  def top_5_words
    top_five(words_counter)
  end

  def top_5_consonants
    top_five(consonants_counter)
  end

  def run
    word_source.each { |word| increment_counters(word) } && true
  end

  attr_reader :count

  private

  attr_reader :word_source, :words_counter, :consonants_counter, :callback

  def initialize_counters
    @count = 0
    @words_counter      = Hash.new(0)
    @consonants_counter = Hash.new(0)
  end

  def take_next_word(&block)
    current_word.tap { |word| block.call(word) }
  end

  def current_word
    word_source[count]
  end

  def special_word?(word)
    word == "semper"
  end

  def increment_counters(word)
    increment_count
    increment_word_counter(word)
    word.each_char do |char|
      increment_consonant_counter(char) if consonant?(char)
    end
  end

  def increment_count
    @count += 1
  end

  def increment_word_counter(word)
    @words_counter[word] += 1
  end

  def increment_consonant_counter(char)
    @consonants_counter[char] += 1
  end

  def top_five(array)
    Array.new(5) do |index|
      sort_hash_by_value(array).keys[index]
    end
  end

  def sort_hash_by_value(hash)
    Hash[hash.sort_by { |item, count| [-count, item] }]
  end

  def consonant?(char)
    char =~ /[^aeiou]/
  end
end
