def welcome
  puts "✨ Welcome To the Star Wars Encyclopedia! ✨"
end

def get_character_from_user
  puts "Please enter a character name:"
  input = gets.chomp.strip
  input.downcase
end
# use gets to capture the user's input. This method should return that input, downcased.