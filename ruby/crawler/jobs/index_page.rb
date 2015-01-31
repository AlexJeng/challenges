require "resque"

class IndexPage
  @queue = :pages

  def self.enqueue(page)
    Resque.enqueue(self, page.to_utf8)
  end

  def self.perform(page)
    statistics_for_url(page)
  end

  private

  def self.statistics_for_url(page)
    {
      :links  => links(page),
      :assets => assets(page),
    }
  end

  def self.links(page)
    page.fetch(:links).fetch(:links)
  end

  def self.assets(page)
    Hash.new.tap do |assets|
      assets[:images]  = page.fetch(:links).fetch(:images)
      assets[:scripts] = page.fetch(:links).fetch(:scripts)
      assets[:styles]  = page.fetch(:links).fetch(:styles)
    end
  end
end

class Hash
  def to_utf8
    Hash[
      self.collect do |k, v|
        if (v.respond_to?(:to_utf8))
          [ k, v.to_utf8 ]
        elsif (v.respond_to?(:encoding))
          [ k, v.dup.force_encoding('UTF-8') ]
        else
          [ k, v ]
        end
      end
    ]
  end
end
