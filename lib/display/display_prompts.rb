# frozen_string_literal: true

# Module for Instructions and commands
module DisplayPrompts
  def new_game?
    puts "\n\e[1;97mWould you like to play another game?\e[0m"
    puts "\e[1;91m  [Y]\e[97m => Yes \n\e[1;91m  [N]\e[97m => No\e[0m"
    gets.chomp.downcase == 'y'
  end

  def game_mode
    puts "\e[1;97mSelect the mode of game\e[0m"
    puts "\e[1;91m  [1]\e[97m => Player vs Player \n\e[1;91m  [2]\e[97m => Player vs Computer\e[0m", ''
    inp = gets.chomp
    return inp.to_i - 1 if %w[2].include?(inp)

    0
  end

  def mode_player
    puts "\e[1;97mTo play with White enter \e[91m[1]\e[97m and for Black \e[91m[2]\e[0m"
    %w[2].include?(gets.chomp) ? 0 : 1
  end

  def clear_screen
    print "\e[2J\e[f"
  end

  def select_piece(player)
    loop do
      print "\e[1;93m#{player.color.zero? ? 'White' : 'Black'}'s turn\nEnter the piece to move. "
      inp = take_input
      return inp if %w[q].include?(inp)

      if inp.length == 2 && inp.match?(/[a-h][1-8]/)
        cord = change_notation(inp)
        return cord if player.active_pieces.include?(cord)
      end
      error_wrong_piece
    end
  end

  def change_notation(move)
    [(8 - move[1].to_i), (move[0].ord - 97)]
  end

  def take_input
    puts "Enter q to quit game\e[0m"
    gets.chomp.downcase
  end

  def select_move(board)
    loop do
      print "\e[1;33mEnter the available move. "
      inp = take_input
      return inp if %w[q].include?(inp)

      if inp.length == 2 && inp.match?(/[a-h][1-8]/)
        cord = change_notation(inp)
        return cord if board.available.include?(cord) || board.captures.include?(cord)
      end
      error_wrong_move
    end
  end

  def select_promotion
    loop do
      puts "\e[1;33mEnter one of the following to promote your pawn to that piece"
      puts "B => Bishop | N => Knight | Q => Queen | R => Rook\e[0m"
      inp = gets.chomp.downcase

      return inp if inp.length == 1 && inp.match?(/[bnqr]/)

      error_wrong_piece
    end
  end

  def game_checkmate(player)
    puts ''
    print "\e[1;94m#{player.color.zero? ? 'Black' : 'White'} "
    puts "checkmates to #{player.color.zero? ? 'white' : 'black'}!\e[0m"
  end

  def game_stalemate
    puts ''
    puts "\e[1;94mGame is draw by stalemate.\e[0m"
  end

  def game_resignation(player)
    puts ''
    print "\e[1;94m#{player.color.zero? ? 'White' : 'Black'} resigns the game. "
    puts "#{player.color.zero? ? 'Black' : 'White'} wins!\e[0m"
  end

  def game_draw
    puts ''
    puts "\e[1;94mGame is draw by repetation of moves or by 50 moves rule.\e[0m"
  end

  # Errors

  def error_wrong_piece
    puts "\e[1;31mWrong piece enter\e[0m"
  end

  def error_movable_piece
    puts "\e[1;31mPiece cannot move\e[0m"
  end

  def error_wrong_move
    puts "\e[1;31mSelect from available moves\e[0m"
  end
end
