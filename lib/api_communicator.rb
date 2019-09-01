require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  movies_array = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  find_character = response_hash["results"].find do |character_hash|
   character_hash["name"] == character_name
  end
  movies_array = find_character["films"].map do |film_url|
    resp = RestClient.get(film_url)
    JSON.parse(resp)
  end












  # if character_name
  #   response_hash.map do |name|
  #     ["films"]
  #   end
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end



def print_movies(films_array)
  puts films_array
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  films_array = films.map do |film_name|
    film_name["title"] 
  end
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
