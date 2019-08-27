require 'rest-client'
require 'json'
require 'pry'


def get_character_films(hashes, character_name)
  hashes["results"].each do |result| 
    if character_name == result["name"]
      return result["films"] 
    end
  end
  return nil
end

def request_film_info(films_urls)
  films_urls.map do |url|
    JSON.parse(RestClient.get(url))
  end
end

def get_character_movies_from_api(character_name)
  api_url = "http://www.swapi.co/api/people/"
  response_hash = JSON.parse(RestClient.get(api_url))
  while get_character_films(response_hash, character_name) == nil do
    if response_hash["next"]
      response_hash = JSON.parse(RestClient.get(response_hash["next"]))
    elsif response_hash["next"] == nil
      puts "Character not found."
      return nil
    end
  end
  films = get_character_films(response_hash, character_name)
  info = request_film_info(films)
  return info
end

def print_movies(films)
    films.each do |movie|
    puts "-" * "Star Wars - Episode #{movie["episode_id"]}: #{movie["title"]}".length
    puts " "
    puts "Star Wars - Episode #{movie["episode_id"]}: #{movie["title"]}"
    puts "-" * "Star Wars - Episode #{movie["episode_id"]}: #{movie["title"]}".length
    puts " "
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  if films
    puts " "
    puts "#{character} appears in the following #{films.length} movies:"
    print_movies(films)
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

