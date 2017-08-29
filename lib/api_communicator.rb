require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  results = RestClient.get('http://www.swapi.co/api/people/')
  results_hash = JSON.parse(results)
  char_arr = results_hash["results"]
  tester = false
  char_arr.each do |character_hash|
    if character_hash["name"] == character
      tester = true
      character_hash["films"].each do |website|
        film_site = RestClient.get(website)
        film_hash = JSON.parse(film_site)
        puts "Episode #{film_hash["episode_id"]}: " + film_hash["title"]
      end
    else
      if results_hash["next"]
        results = RestClient.get(results_hash["next"])
        results_hash = JSON.parse(results)
        char_arr = results_hash["results"]
        char_arr.each do |character_hash|
          if character_hash["name"] == character
            tester = true
            character_hash["films"].each do |website|
              film_site = RestClient.get(website)
              film_hash = JSON.parse(film_site)
              puts "Episode #{film_hash["episode_id"]}: " + film_hash["title"]
            end
          end
        end
      end
    end
  end
  if tester == false
    puts "Character does not exist."
  end
end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
