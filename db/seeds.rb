# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'net/http'
require 'uri'
require 'json'

puts "clearing database..."
Item.destroy_all

DICTIONARY = ENV['DICTIONARY_API_KEY']


words = ["apple", "tree", "sun", "cat", "blue", "happy"]

puts "seeding database..."

def get_definition(word, api_key)
  uri = URI("https://api.dictionaryapi.dev/api/v2/entries/en_US/#{word}")
  uri.query = URI.encode_www_form({ :api_key => api_key })
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)
  data[0]['meanings'][0]['definitions'][0]['definition']
end

words.each do |word|

  definition = get_definition(word, DICTIONARY)
  puts "#{word}: #{definition}"

  Item.create(word: word, description: definition)
end

puts "done! #{Item.count} items created."
