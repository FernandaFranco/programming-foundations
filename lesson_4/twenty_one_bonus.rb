MAX_NUMBER = 21
DEALER_STOPS = 17

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9',\
          '10', 'J', 'Q', 'K', 'A'].freeze

def initialize_deck
  VALUES.product(SUITS).shuffle
end

def prompt(message)
  puts "=> #{message}"
end

def cards_description(cards)
  cards_strings = []
  cards.each do |card|
    cards_strings << "#{card[0]} of #{card[1]}"
  end
  last_card = cards_strings.pop
  if !cards_strings.empty?
    "#{cards_strings.join(', ')} and #{last_card}"
  else
    last_card
  end
end

def total(cards)
  values = cards.map { |card| card[0] }

  total = 0
  values.each do |value|
    total += if value == "J" || value == "Q" || value == "K"
               10
             elsif value == "A"
               11
             else
               value.to_i
             end
  end

  values.count("A").times do
    total -= 10 if total > MAX_NUMBER
  end

  total
end

def busted?(cards)
  total(cards) > MAX_NUMBER
end

def calculate_result(p_cards, d_cards)
  p_total = total(p_cards)
  d_total = total(d_cards)

  if busted?(p_cards)
    :player_busted
  elsif busted?(d_cards)
    :dealer_busted
  elsif p_total > d_total
    :player
  elsif d_total > p_total
    :dealer
  else
    :tie
  end
end

def display_result(p_cards, d_cards)
  result = calculate_result(p_cards, d_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def play_again?
  answer = nil
  loop do
    prompt "Do you want to play again? (Yes/No)"
    answer = gets.chomp.downcase
    break if ['yes', 'no'].include?(answer)
    prompt "Sorry, must enter 'yes' or 'no'."
  end
  answer == 'yes'
end

def display_end_of_round(p_cards, d_cards)
  puts "=============="
  prompt "Dealer has #{cards_description(d_cards)}, " \
         "for a total of: #{total(d_cards)}."
  prompt "Player has #{cards_description(p_cards)}, " \
         "for a total of: #{total(p_cards)}."
  puts "=============="

  display_result(p_cards, d_cards)
end

def big_winner?(p_wins, d_wins)
  [p_wins, d_wins].include?(5)
end

def end_game?(p_wins, d_wins)
  big_winner?(p_wins, d_wins) || !play_again?
end

def display_final_score(p_wins, d_wins)
  prompt "Player: #{p_wins} X Dealer: #{d_wins}."

  if p_wins > d_wins
    prompt "Player is the big winner!"
  elsif d_wins > p_wins
    prompt "Dealer is the big winner!"
  else
    prompt "Nobody wins!"
  end
end

player_wins = 0
dealer_wins = 0

system "clear"
system 'cls'

prompt "Welcome to Twenty-One!"
loop do
  deck = initialize_deck
  player_cards = deck.shift(2)
  dealer_cards = deck.shift(2)

  prompt "Dealer has #{cards_description([dealer_cards[0]])} and unknown card."
  prompt "You have: #{cards_description(player_cards)}, " \
         "for a total of #{total(player_cards)}."

  loop do
    player_turn = nil
    loop do
      prompt "Do you want to hit or stay? (Hit/Stay)"
      player_turn = gets.chomp.downcase
      break if ['hit', 'stay'].include?(player_turn)
      prompt "Sorry, must enter 'hit' or 'stay'."
    end

    if player_turn == 'hit'
      player_cards << deck.shift
      prompt "You chose to hit!"
      prompt "Your cards are now: #{cards_description(player_cards)}."
      prompt "Your total is now: #{total(player_cards)}."
    end

    break if player_turn == 'stay' || busted?(player_cards)
  end

  if busted?(player_cards)
    display_end_of_round(player_cards, dealer_cards)
    dealer_wins += 1

    end_game?(player_wins, dealer_wins) ? break : next
  else
    prompt "You chose to stay at #{total(player_cards)}."
  end

  loop do
    break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_STOPS

    prompt "Dealer hits!"
    dealer_cards << deck.shift
    prompt "Dealer's cards are now: #{cards_description(dealer_cards)}."
  end

  if busted?(dealer_cards)
    display_end_of_round(player_cards, dealer_cards)
    player_wins += 1

    end_game?(player_wins, dealer_wins) ? break : next
  else
    prompt "Dealer stays at #{total(dealer_cards)}."
  end

  # both player and dealer stays
  display_end_of_round(player_cards, dealer_cards)
  result = calculate_result(player_cards, dealer_cards)
  case result
  when :dealer
    dealer_wins += 1
  when :player
    player_wins += 1
  end

  break if end_game?(player_wins, dealer_wins)
end

display_final_score(player_wins, dealer_wins)

prompt "Thank you for playing Twenty-One. Good-bye!"
