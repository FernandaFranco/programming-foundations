### question 1

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}
sum = 0
munsters.each { |name, details| sum += details["age"] if details["gender"] == "male"}

### question 2

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
munsters.each { |name, details| puts "#{name} is a #{details['age']} year old #{details['gender']}"}

### question 3



### question 4



### question 5



### question 6



### question 7



### question 8


