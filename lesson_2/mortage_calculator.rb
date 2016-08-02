require "yaml"
MESSAGES = YAML.load_file('mortage_calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(n)
  /\d/.match(n) && /^\d*\.?\d*$/.match(n)
end

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

prompt(MESSAGES['greeting'] + "#{name.downcase.capitalize!}!")

numbers = {}
numbers["the loan amount, in dollars"] = nil
numbers["the Annual Percentage Rate (APR)? (eg 10 as in 10%)"] = nil
numbers["the loan duration, in years"] = nil
loop do # main loop
  numbers.each_key do |key|
    loop do
      prompt(MESSAGES['choose'] + "#{key}?")
      num = gets.chomp

      if valid_number?(num)
        numbers[key] = num.to_f
        break
      else
        prompt(MESSAGES['invalid'])
      end
    end
  end

  p = numbers["the loan amount, in dollars"]
  a = numbers["the Annual Percentage Rate (APR)? (eg 10 as in 10%)"]
  n_years = numbers["the loan duration, in years"]

  prompt(MESSAGES['operating'])

  j = ((a / 100 + 1)**(1.0 / 12.0) - 1)
  n = n_years * 12
  m = p * (j / (1 - (1 + j)**-n))

  result = m.round(2)

  prompt(MESSAGES['result'] + result.to_s + " dollars.")

  prompt(MESSAGES['another'])
  answer = gets.chomp
  break if answer == "no"
end

prompt MESSAGES['thank_you']
