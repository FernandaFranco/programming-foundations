require "yaml"
MESSAGES = YAML.load_file('calculator_messages.yml')
puts MESSAGES

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(n)
  /\d/.match(n) && /^\d*\.?\d*$/.match(n)
end

def operation_to_message(operation)
  result = case operation
  when "add"
    "Adding"
  when "subtract"
    "Subtracting"
  when "multiply"
    "Multiplying"
  when "divide"
    "Dividing"
  end

  return result
end



numbers = {}
numbers["first"] = nil
numbers["second"] = nil

prompt(MESSAGES["welcome"])
name = nil
loop do
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['invalid'])
  else
    break
  end
end

prompt(MESSAGES['nice'])

loop do # main loop
  numbers.each_key do |key|
    loop do
      prompt(MESSAGES['choose'])
      num = gets.chomp

      if valid_number?(num)
        numbers[key] = num.to_f
        break
      else
        prompt(MESSAGES['invalid'])
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
      prompt(MESSAGES['invalid'])
    end
  end

  prompt(MESSAGES['operating'])

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

  prompt(MESSAGES['result'])

  prompt(MESSAGES['another'])
  answer = gets.chomp
  break if answer == "no"
end

prompt MESSAGES['thank_you']
