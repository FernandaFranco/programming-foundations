require "yaml"
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(n, i = 1)
  case i
  when 0, 2
    /^\d+$/.match(n) && n.to_i > 0
  when 1
    /\d/.match(n) && /^\d*\.?\d*$/.match(n) && n.to_f.ceil > 0
  end
end

prompt(MESSAGES['welcome'])

questions = ["the loan amount (in dollars)",
             "the APR (in %)",
             "the loan duration (in years)"]

loop do # main loop
  answers = []
  questions.each_with_index do |string, index|
    loop do
      prompt(MESSAGES['choose'] + "#{string}?")
      num = gets.chomp

      if valid_number?(num, index)
        answers.push(num)
        break
      else
        prompt(MESSAGES['invalid'])
      end
    end
  end

  loan = answers[0].to_i
  annual_rate = answers[1].to_f
  n_years = answers[2].to_i

  prompt(MESSAGES['operating'])

  monthly_rate = (annual_rate / 12) / 100
  n_months = n_years * 12
  monthly_pay = loan * (monthly_rate / (1 - (1 + monthly_rate)**-n_months))

  unless valid_number?(monthly_pay.to_s)
    prompt(MESSAGES['error'])
    next
  end

  result = monthly_pay
  total_cost = result.round(2) * n_months

  prompt(MESSAGES['result'] + "#{format('%02.2f', result)} dollars.")
  prompt(MESSAGES['total'] + "#{format('%02.2f', total_cost)} dollars.")

  prompt(MESSAGES['another'])
  answer = gets.chomp
  break if answer == "no"
end

prompt(MESSAGES['thank_you'])
