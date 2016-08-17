### question 1

if false
  greeting = “hello world”
end

greeting
# => nil because the if block will never execute
# still, a variable initialized inside a if block 
# will "exist" as nil even if the block doesn't get executed.

### question 2

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings
# => { a: 'hi there' } because informal_greeting was pointing 
# to the same object as greetings, and << mutates the object that called it.

greetings = { a: 'hi' }
informal_greeting = greetings[:a].clone
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

### question 3

# A)
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
# the method does not reassign values to the outside variables

#B)
def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
# same thing

# C)
def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
# now, this version does mutates the objects that the outside variables are associated!
### question 4

require 'securerandom'
UUID = SecureRandom.hex

# or
def generate_UUID
  hexadecimal_characters = ('a'..'f').to_a + (0..9).to_a
  uuid = (0...32).map { hexadecimal_characters[rand(16)]}.join
  uuid.insert(8, '-').insert(13,'-').insert(18, '-').insert(23, '-')
end

### question 5

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.length == 4 && input_string.count(".") == 3
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_a_number?(word)
  end
  
  true
end
