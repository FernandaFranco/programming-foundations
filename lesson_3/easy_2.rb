### question 1

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.key?("Spot")
# or
ages.has_key?("Spot")
ages.include?("Spot")
ages.member?("Spot")

### question 2

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.values.reduce(:+)

### question 3

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.reject { |_, age| age >= 100 }

### question 4

munsters_description = "The Munsters are creepy in a good way."
munsters_description.capitalize
munsters_description.swapcase
munsters_description.downcase
munsters_description.upcase

### question 5

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)

### question 6

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
ages.min

### question 7

advice = "Few things in life are as important as house training your pet dinosaur."
advice.include?("Dino")
# although this works, if I tried "dino" it would return true;
# a better solution is:
advice.match("Dino")

### question 8

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.index { |name| name.start_with?("Be")}

### question 9

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name| name[0..2] }

### question 10

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones,map! { |name| name[0,3] }