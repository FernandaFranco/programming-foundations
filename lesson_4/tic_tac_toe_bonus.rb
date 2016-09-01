FIRST = "choose".freeze

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

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(options, delimiter = ", ", joining_word = "or")
  last_option = options.pop.to_s
  if !options.empty?
    "#{options.join(delimiter)} #{joining_word} #{last_option}"
  else
    last_option
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if brd[square] == INITIAL_MARKER
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_strategic_square(brd, line, marker)
  if brd.values_at(*line).count(marker) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1
    line[brd.values_at(*line).index(INITIAL_MARKER)]
  end
end

def computer_places_piece!(brd)
  square = nil

  # offensive strategy
  WINNING_LINES.each do |line|
    square = computer_strategic_square(brd, line, COMPUTER_MARKER)
    break if square
  end

  # defensive strategy
  WINNING_LINES.each do |line|
    square ||= computer_strategic_square(brd, line, PLAYER_MARKER)
    break if square
  end

  # at five
  square ||= 5 if empty_squares(brd).include?(5)

  # at random
  square ||= empty_squares(brd).sample

  # result
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, current)
  if current == "player"
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player(current)
  if current == "player"
    current.gsub("player", "computer")
  else
    current.gsub("computer", "player")
  end
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

def valid_answer?(ans, accepted_arr)
  accepted_arr.include?(ans)
end

def display_final_msgs(player_final, computer_final)
  prompt "Player: #{player_final} X Computer: #{computer_final}"
  prompt "Thanks for playing!"
end

player_victories = 0
computer_victories = 0

loop do # outer loop
  board = initialize_board
  display_board(board)
  if FIRST == "choose"
    current_player = ''
    loop do
      prompt "Please choose who will start the game: (Player/Computer)"
      current_player = gets.chomp.downcase
      break if valid_answer?(current_player, ['player', 'computer'])
      prompt "Invalid choice."
    end
  else
    current_player = FIRST
  end

  loop do # main loop
    place_piece!(board, current_player)
    display_board(board)
    current_player = alternate_player(current_player)
    break if winner?(board) || tie?(board)
  end

  display_board(board)

  if winner?(board)
    prompt "#{detect_winner(board)} won!"
    if detect_winner(board) == "Player"
      player_victories += 1
    else
      computer_victories += 1
    end
  else
    prompt "It's a tie!"
  end

  if player_victories == 5 || computer_victories == 5
    display_final_msgs(player_victories, computer_victories)
    break
  end

  answer = ''
  loop do
    prompt "Do you want to play again? (Y/N)"
    answer = gets.chomp.downcase
    break if valid_answer?(answer, ['y', 'n'])
    prompt "Invalid answer."
  end

  next if answer == 'y'

  display_final_msgs(player_victories, computer_victories)
  break
end
