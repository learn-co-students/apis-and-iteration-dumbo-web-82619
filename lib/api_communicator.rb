require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  response_hash = JSON.parse(RestClient.get('http://www.swapi.co/api/people/'))
  
  character_hash = response_hash["results"].find do |hash|
    hash["name"] == character
    hash
  end
  
  films = character_hash["films"].map do |film_link|
    JSON.parse(RestClient.get(film_link))
  end
  
  films
end


def print_movies(films)
  films.each do |film|
    puts " - Episode #{film["episode_id"]}: #{film["title"]}"
  end
end


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end




## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?


## NOTES

# for get_character_movies_from_api()
  # for response_hash
    # this places a web request to the API, parses the info into JSON, assigns to variable
  # for character_hash var
    # this iterates over the value of response_hash["results"] (an array of hashes) 
    # and selects the particular hash that matches the character name inputted
    # it then assigns this characer hash to a variable
  # for films variable
    # this sub-method needs to return an array of hashes assigned to var films 
    # which reflects the JSON parse of the film links from character_hash

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


# for print_movies()
  # some iteration magic and puts out the movies in a nice list