INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system "clear"
  puts "You're a #{PLAYER_MARKER}."
  puts "Computer is a #{COMPUTER_MARKER}."
  puts ""
  puts "      |     |"
  puts "   #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "      |     |"
  puts " -----+-----+-----"
  puts "      |     |"
  puts "   #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "      |     |"
  puts " -----+-----+-----"
  puts "      |     |"
  puts "   #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "      |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    break if brd[square] == INITIAL_MARKER
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  false
end

def tie?(brd)
  empty_squares(brd) == []
end

def valid_answer?(ans)
  ans.downcase.start_with?("y", "n")
end

loop do
  board = initialize_board

  loop do # main loop
    display_board(board)

    player_places_piece!(board)
    break if winner?(board) || tie?(board)

    computer_places_piece!(board)
    break if winner?(board) || tie?(board)
  end

  display_board(board)

  if winner?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  answer = ''
  loop do
    prompt "Do you want to play again? (Y/N)"
    answer = gets.chomp
    if valid_answer?(answer)
      break
    else
      prompt "Invalid answer."
    end
  end

  if answer.downcase.start_with?("n")
    prompt "Thanks for playing!"
    break
  end
end
