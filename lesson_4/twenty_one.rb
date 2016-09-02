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
  ["Jack", "Hearts"], ["Jack", "Diamonds"], ["Jack", "Clubs"], ["Jack", "Spades"],
  ["Queen", "Hearts"], ["Queen", "Diamonds"], ["Queen", "Clubs"], ["Queen", "Spades"],
  ["King", "Hearts"], ["King", "Diamonds"], ["King", "Clubs"], ["King", "Spades"],
  ["Ace", "Hearts"], ["Ace", "Diamonds"], ["Ace", "Clubs"], ["Ace", "Spades"]
]

def initialize_deck
  DECK.shuffle
end

def prompt(message)
  puts "=> #{message}"
end

def total(cards)
  values = cards.map {|card| card[0]}
  
  total = 0
  values.each do |value|  
    case value
    when "Jack", "Queen", "King"
      total += 10
      next
    when "Ace"
      total += 11
      next
    else
      total += value.to_i
    end
  end

  values.count("Ace").times do
    total -= 10 if total > 21
  end

  total
end
  
def busted?(cards)
  total(cards) > 21
end

def calculate_result(p_cards, d_cards)
  player_total = total(p_cards)
  dealer_total = total(d_cards)

  if busted?(p_cards)
    :player_busted
  elsif busted?(d_cards)
    :dealer_busted
  elsif player_total > dealer_total
    :player
  elsif dealer_total > player_total
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
  answer.start_with?('y')
end

loop do
  prompt "Welcome to Twenty-One!"

  deck = initialize_deck
  player_cards = deck.shift(2)
  dealer_cards = deck.shift(2)
 
  prompt "Dealer has #{dealer_cards[0]} and unknown card."
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}, 
          for a total of #{total(player_cards)}."

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
  end

  if busted?(player_cards)
    #do something
  else 
    prompt "You chose to stay!"
  end

  loop do 
    break if total(dealer_cards) >= 17
    dealer_cards << deck.shift
  end

  puts player_cards
  puts total(player_cards)

  puts dealer_cards
  puts total(dealer_cards)

  display_result(player_cards, dealer_cards)
  winner(player_cards, dealer_cards)

end