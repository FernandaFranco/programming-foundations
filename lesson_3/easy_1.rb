### question 1

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# the method uniq does not mutate the caller.
# numbers still points to the array [1, 2, 2, 3].

### question 2

# it is recommended to name a method with an ? at the end
# if it outputs a boolean, and with an ! if it's a destructive
# method.

# ! before an object means the boolean opposite of that object;
# therefore, !! means the boolean of the object.

# an ? (complemented by an :) is used in ruby sintax as the 
# tenary operator for if...else

### question 3

advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!("important", "urgent")

### question 4

numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1)
# returns value at index 1
# deletes in place value at index 1

numbers = [1, 2, 3, 4, 5]
numbers.delete(1)
# returns value 1
# deletes in place all values 1

### question 5

(10..100).include?(42)

### question 6

famous_words = "seven years ago..."

puts "four score and " << famous_words

puts "four score and " + famous_words

### question 7

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

eval(how_deep)
# 42

### question 8

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!

### question 9

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones.assoc("Barney")

### question 10

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}
flintstones.each_with_index do |value, index|
  flintstones_hash[value] = index
end
