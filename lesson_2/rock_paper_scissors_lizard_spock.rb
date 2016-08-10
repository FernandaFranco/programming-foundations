VALID_CHOICES = {
  "r" => "rock",
  "p" => "paper",
  "sc" => "scissors",
  "sp" => "spock",
  "l" => "lizard"
}

WINNING_CONDITIONS = {
  "rock" => %w(scissors lizard),
  "scissors" => %w(paper lizard),
  "paper" => %w(rock spock),
  "lizard" => %w(spock paper),
  "spock" => %w(scissors rock)
}

def win?(first, second)
  WINNING_CONDITIONS[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt "You win!"
  elsif win?(computer, player)
    prompt "Computer wins!"
  else
    prompt "It's a tie!"
  end
end

def prompt(message)
  puts "=> #{message}"
end

player_score = 0
computer_score = 0
loop do # main loop
  player_choice = ""
  loop do
    prompt("Choose between #{VALID_CHOICES.values.join(', ')}")
    prompt("(Please type only initials: #{VALID_CHOICES.keys.join(', ')})")
    player_choice_initials = gets.chomp.downcase

    if VALID_CHOICES.key?(player_choice_initials)
      player_choice = VALID_CHOICES[player_choice_initials]
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.values.sample
  prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")

  display_results(player_choice, computer_choice)

  if win?(player_choice, computer_choice)
    player_score += 1
  elsif win?(computer_choice, player_choice)
    computer_score += 1
  end

  if player_score == 5
    prompt "You've won the game, good job!"
    break
  elsif computer_score == 5
    prompt "Computer has won the game, better luck next time!"
    break
  end

  prompt "Do you want to play again? Enter y or n:"
  answer = gets.chomp.downcase

  break unless answer.start_with?("y")
end

prompt "Thank you for playing."
