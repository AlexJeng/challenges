class Prime
  class << self
    def take(n)
      eratosthenes_generator(n)
    end

    private

    def eratosthenes_generator(n)
      @primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101]
      # @max_checked must be an even number
      @max_checked = @primes.last + 1
      compute_primes while @primes.size <= n
      @primes.take(n)
    end

    def compute_primes
      # max_segment_size must be an even number
      max_segment_size = 1e6.to_i
      max_cached_prime = @primes.last
      # do not double count primes if #compute_primes is interrupted
      # by Timeout.timeout
      @max_checked = max_cached_prime + 1 if max_cached_prime > @max_checked

      segment_min = @max_checked
      segment_max = [segment_min + max_segment_size, max_cached_prime * 2].min
      root = Integer(Math.sqrt(segment_max).floor)

      sieving_primes = @primes[1 .. -1].take_while { |prime| prime <= root }
      offsets = Array.new(sieving_primes.size) do |i|
        (-(segment_min + 1 + sieving_primes[i]) / 2) % sieving_primes[i]
      end

      segment = ((segment_min + 1) .. segment_max).step(2).to_a
      sieving_primes.each_with_index do |prime, index|
        composite_index = offsets[index]
        while composite_index < segment.size do
          segment[composite_index] = nil
          composite_index += prime
        end
      end

      segment.each do |prime|
        @primes.push prime unless prime.nil?
      end
      @max_checked = segment_max
    end
  end
end
