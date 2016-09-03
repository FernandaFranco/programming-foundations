MAX_NUMBER = 21
DEALER_STOPS = 17

DECK = [
  ["2", "Hearts"], ["2", "Diamonds"], ["2", "Clubs"], ["2", "Spades"],
  ["3", "Hearts"], ["3", "Diamonds"], ["3", "Clubs"], ["3", "Spades"],
  ["4", "Hearts"], ["4", "Diamonds"], ["4", "Clubs"], ["4", "Spades"],
  ["5", "Hearts"], ["5", "Diamonds"], ["5", "Clubs"], ["5", "Spades"],
  ["6", "Hearts"], ["6", "Diamonds"], ["6", "Clubs"], ["6", "Spades"],
  ["7", "Hearts"], ["7", "Diamonds"], ["7", "Clubs"], ["7", "Spades"],
  ["8", "Hearts"], ["8", "Diamonds"], ["8", "Clubs"], ["8", "Spades"],
  ["9", "Hearts"], ["9", "Diamonds"], ["9", "Clubs"], ["9", "Spades"],
  ["10", "Hearts"], ["10", "Diamonds"], ["10", "Clubs"], ["10", "Spades"],
  ["J", "Hearts"], ["J", "Diamonds"], ["J", "Clubs"], ["J", "Spades"],
  ["Q", "Hearts"], ["Q", "Diamonds"], ["Q", "Clubs"], ["Q", "Spades"],
  ["K", "Hearts"], ["K", "Diamonds"], ["K", "Clubs"], ["K", "Spades"],
  ["A", "Hearts"], ["A", "Diamonds"], ["A", "Clubs"], ["A", "Spades"]
].freeze

def initialize_deck
  DECK.shuffle
end

def prompt(message)
  puts "=> #{message}"
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
  prompt "Do you want to play again? (Yes/No)"
  answer = gets.chomp.downcase
  answer == 'yes'
end

def display_end_of_round(p_cards, d_cards)
  puts "=============="
  prompt "Dealer has #{d_cards}, for a total of: #{total(d_cards)}"
  prompt "Player has #{p_cards}, for a total of: #{total(p_cards)}"
  puts "=============="

  display_result(p_cards, d_cards)
end

player_wins = 0
dealer_wins = 0

prompt "Welcome to Twenty-One!"
loop do
  deck = initialize_deck
  player_cards = deck.shift(2)
  dealer_cards = deck.shift(2)

  prompt "Dealer has #{dealer_cards[0]} and unknown card."
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}, " \
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
      prompt "Your cards are now: #{player_cards}"
      prompt "Your total is now: #{total(player_cards)}"
    end

    break if player_turn == 'stay' || busted?(player_cards)
  end

  if busted?(player_cards)
    display_end_of_round(player_cards, dealer_cards)
    dealer_wins += 1

    (player_wins == 5 || dealer_wins == 5) || !play_again? ? break : next
  else
    prompt "You chose to stay at #{total(player_cards)}."
  end

  loop do
    break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_STOPS

    prompt "Dealer hits!"
    dealer_cards << deck.shift
    prompt "Dealer's cards are now: #{dealer_cards}"
  end

  if busted?(dealer_cards)
    prompt "Dealer total is now: #{total(dealer_cards)}"
    display_end_of_round(player_cards, dealer_cards)
    player_wins += 1

    (player_wins == 5 || dealer_wins == 5) || !play_again? ? break : next
  else
    prompt "Dealer stays at #{total(dealer_cards)}"
  end

  # both player and dealer stays
  display_end_of_round(player_cards, dealer_cards)
  result = calculate_result(player_cards, dealer_cards)
  case result
  when :player_busted, :dealer
    dealer_wins += 1
  when :dealer_busted, :player
    player_wins += 1
  end

  break if (player_wins == 5 || dealer_wins == 5) || !play_again?
end

prompt "Player: #{player_wins} X Dealer: #{dealer_wins}."
prompt "Thank you for playing Twenty-One! Good bye!"
