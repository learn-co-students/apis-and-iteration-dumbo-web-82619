require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  # make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character_hash = nil

  while !character_hash
    # iterate over the response hash to find the collection of `films` for the given `character`
    # below will return nil or a hash for character_hash
    character_hash = response_hash["results"].find do |character|
      character["name"] == character_name
    end

    # collect those film API urls, make a web request to each URL to get the info
    #  for that film
    # return value of this method should be collection of info about each film.
    #  i.e. an array of hashes in which each hash reps a given film
    if character_hash
      films = character_hash["films"]
      films_hash =[]
      films.each do |film|
        films_hash <<  JSON.parse(RestClient.get(film))
      end

      return films_hash
    elsif response_hash["next"]
      response_hash = JSON.parse(RestClient.get(response_hash["next"]))
    else
      films_hash = nil
       return
    end
  end

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
  if films
    print_movies(films)
  else
    puts "*" * 25
    puts ""
    puts "No character found!"
  end
  binding.pry
  0
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
