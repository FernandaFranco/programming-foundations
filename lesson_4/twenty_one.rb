cards = [
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
cards.shuffle!
  
player_cards = cards.shift(2)
dealer_cards = cards.shift(2)
puts dealer_cards[0]
puts player_cards

player_values = player_cards.map {|card| card[0]}
total = 0
player_values.map { |value|  
  case value
  when "Jack", "Queen", "King"
    total += 10
    next
  when "Ace"
    if total + 11 <= 21
      total += 11
    else
      total += 1
    end
    next
  else
    total += value.to_i
  end
}

dealer_values = dealer_cards.map {|card| card[0]}
total = 0
dealer_values.map { |value|  
  case value
  when "Jack", "Queen", "King"
    total += 10
    next
  when "Ace"
    if total + 11 <= 21
      total += 11
    else
      total += 1
    end
    next
  else
    total += value.to_i
  end
}