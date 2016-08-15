### question 1

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

### question 2

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"

### question 3

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push("Dino", "Hoppy")

### question 4

advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice(0, advice.index("house"))
# returns everything until "house" but does not mutates advice
advice.slice!(0, advice.index("house"))
# returns the same result but does modifies advice to everything starting at "house"

### question 5

statement = "The Flintstones Rock!"
statement.count("t")
statement.scan("t").count
statement.scan("t").length

### question 6

title = "Flintstone Family Members"
title.center(50)