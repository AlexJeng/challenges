require_relative "lorem_ipsum_word_source"

class LoremIpsumWordFileSource < LoremIpsumWordSource
  def initialize(args)
    super(
      :word_source => read_file(args.fetch(:path))
    )
  end

  private

  def read_file(path)
    File.read(path)
  end
end
