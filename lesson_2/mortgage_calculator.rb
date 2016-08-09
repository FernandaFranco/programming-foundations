require "yaml"
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_integer?(number)
  /^\d+$/.match(number) && number.to_i > 0
end

def valid_float?(number)
  /^\d*\.?\d+$/.match(number) && number.to_f > 0
end

def valid_answer?(string)
  string.start_with?("y", "n")
end

prompt(MESSAGES['welcome'])

loop do # main loop
  loan_amount = nil
  loop do
    prompt(MESSAGES['choose'] + "the loan amount (in dollars)?")
    loan_amount = gets.chomp
    if valid_integer?(loan_amount)
      loan_amount = loan_amount.to_i
      break
    else
      prompt(MESSAGES['invalid'])
    end
  end

  annual_rate = nil
  loop do
    prompt(MESSAGES['choose'] + "the APR (in %)?")
    annual_rate = gets.chomp
    if valid_float?(annual_rate)
      annual_rate = annual_rate.to_f
      break
    else
      prompt(MESSAGES['invalid'])
    end
  end

  n_years = nil
  loop do
    prompt(MESSAGES['choose'] + "the loan duration (in years)?")
    n_years = gets.chomp
    if valid_integer?(n_years)
      n_years = n_years.to_i
      break
    else
      prompt(MESSAGES['invalid'])
    end
  end

  prompt(MESSAGES['operating'])
  monthly_rate = (annual_rate / 12) / 100
  n_months = n_years * 12
  monthly_pay = loan_amount *
                (monthly_rate / (1 - (1 + monthly_rate)**-n_months))

  unless valid_float?(monthly_pay.to_s)
    prompt(MESSAGES['error'])
    next
  end

  total_cost = monthly_pay.round(2) * n_months

  prompt(MESSAGES['result'] + "#{format('%02.2f', monthly_pay)} dollars.")
  prompt(MESSAGES['total'] + "#{format('%02.2f', total_cost)} dollars.")

  answer = nil
  loop do
    prompt(MESSAGES['another'])
    answer = gets.chomp.downcase
    if valid_answer?(answer)
      break
    else
      prompt(MESSAGES['invalid'])
    end
  end

  break if answer.start_with?("n")
end

prompt(MESSAGES['thank_you'])
