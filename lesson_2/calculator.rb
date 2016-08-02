def prompt(message)
  puts "=> #{message}"
end

def valid_number?(n)
  n.to_i.nonzero?
end

def operation_to_message(operation)
  case operation
  when "add"
    "Adding"
  when "subtract"
    "Subtracting"
  when "multiply"
    "Multiplying"
  when "divide"
    "Dividing"
  end
end

numbers = {}
numbers["first"] = nil
numbers["second"] = nil

prompt("Hello and welcome to the calculator! Please enter your name:")
name = nil
loop do
  name = gets.chomp
  if name.empty?
    prompt("Oops, invalid name! Try it again:")
  else
    break
  end
end

prompt("Nice to meet you, #{name.capitalize!}!")

loop do # main loop
  numbers.each_key do |key|
    loop do
      prompt("Choose the #{key} number:")
      num = gets.chomp.to_f

      if valid_number?(num)
        numbers[key] = num
        break
      else
        prompt("Sorry, invalid number.")
      end
    end
  end

  number_1 = numbers["first"]
  number_2 = numbers["second"]

  operation_prompt = <<-MSG
    What type of operation?
    Choose between
    add,
    subtract,
    multiply, and
    divide
  MSG
  prompt(operation_prompt)

  options = %w(add subtract multiply divide)
  operation = nil
  loop do
    operation = gets.chomp
    if options.include?(operation)
      break
    else
      prompt("Oops wrong operator, try again.")
    end
  end

  prompt("#{operation_to_message(operation)} the two numbers...")

  result = case operation
           when "add"
             number_1 + number_2
           when "subtract"
             number_1 - number_2
           when "multiply"
             number_1 * number_2
           when "divide"
             number_1 / number_2
           end

  prompt("Result is #{result}.")

  prompt("Do you want to perform another calculation?")
  answer = gets.chomp
  break if answer == "no"
end

prompt "Thank you for calculating with us #{name}, see ya!"
