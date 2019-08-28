require 'pry'

def welcome
  puts "-" * 34
  puts " "
  puts "Welcome to the Star Wars Database!"
  puts "-" * 34
end

def get_character_from_user
  puts " "
  puts "Please enter a character name:"
  puts " "
  character = gets.chomp
end
