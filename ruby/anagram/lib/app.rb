require "sinatra"
require "sinatra/json"
require_relative "anagram"

class App < Sinatra::Base
  helpers Sinatra::JSON

  get "/:words" do |words|
    json anagram.call(words.split(","))
  end

  private

  def anagram
    @anagram ||= Anagram.new(:wordlist => wordlist_from_file)
  end

  def wordlist_from_file
    File.readlines(File.expand_path("../../data/wordlist.txt", __FILE__)).map(&:chomp)
  end
end
