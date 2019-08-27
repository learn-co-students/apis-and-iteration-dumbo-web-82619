require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)




  # The below is the part that does not work

  # puts response_hash
  # (2...9).each do |page|
  #   page_hash = JSON.parse(RestClient.get("http://www.swapi.co/api/people/?page=#{page}"))
  #   puts page
  #   response_hash["results"] << page_hash["results"]
  #   # puts response_hash
  # end
  # puts response_hash["results"]




  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  character_hash = response_hash["results"].find do |character|
    character["name"] == character_name
  end

  films = character_hash["films"]

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film

  films_hash =[]
  films.each do |film|
    films_hash <<  JSON.parse(RestClient.get(film))
  end

  print_movies(films_hash)

  binding.pry
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list

  puts "*" * 25
  puts ""
  films.each_with_index do |film, index|
    # puts "#{index + 1}) #{film["title"]}\n   #{film["opening_crawl"]}"
    puts "#{index + 1}) #{film["title"]}"
    puts "   Director: #{film["director"]}" 
    puts "   Producer: #{film["producer"]}" 
    puts "   Release Date: #{film["release_date"]}" 
    puts "👩‍💻👩‍🏭🌚\n\n"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
