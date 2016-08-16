### question 1
spaces = 0
while spaces < 10
  puts " "*spaces << "The Flintstones Rock!"
  spaces += 1
end

# one line:
(0...10).each {|spaces| puts " "*spaces << "The Flintstones Rock!"}
### question 2

statement = "The Flintstones Rock"
freq = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_count = statement.scan(letter).count
  freq[letter] = letter_count if letter_count > 0
end

### question 3

puts "the value of 40 + 2 is " + (40 + 2)
# it will result in an error because isn't converting 42 to
# string before concatenating.

puts "the value of 40 + 2 is #{(40 + 2)}"
puts "the value of 40 + 2 is " + (40 + 2).to_s


### question 4

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
# it'll only print 1 and 3 because the values are being rearranged
# new indexes are assigned

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
# it'll only print 1 and 2

### question 5

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

# bonus 1: a number is divisible by a dividend (has a divisor)
# if there is no remainder of the division
# bonus 2: the method returns the last evaluation it makes.

### question 6

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

# yes, the input array will still be the same after the second method executes
# while the first method mutates the input 

### question 7

LIMIT = 15

def fib(first_num, second_num)
  while second_num < LIMIT
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

### question 8

def titlelize(title)
  title.split(' ').map { | word | word.capitalize }.join(' ')
end

### question 9

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, hash|
  case hash["age"]
  when (0..17)
    hash["age_range"] = "kid"
  when (18..64)
    hash["age_range"] = "adult"
  else (65..1000)
    hash["age_range"] = "senior"
  end
end
