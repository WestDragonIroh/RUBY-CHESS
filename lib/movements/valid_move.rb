# frozen_string_literal: true

# Module checking for Checks and seeing if move will be valid
module ValidMove
  def square_under_attack?(location, player)
    @board.set_square(location, Piece.new([player.color ^ 1, location, 'D'])) if @board.get_square(location).nil?

    res = check_all_pieces(location, player)

    @board.set_square(location, nil) if @board.get_square(location).symbol == 'D'

    res
  end

  def check_all_pieces(location, player)
    res = false
    player.current_pieces.each do |cord|
      piece = @board.get_square(cord)
      if check_captures(piece.color, cord, piece.captures, piece.symbol, safe: false).include?(location)
        res = true
        break
      end
    end
    res
  end

  def safe_moves(color, cord, symbol, res)
    opponent_player, current_player = color.zero? ? [@player1, @player0] : [@player0, @player1]

    piece_current = @board.get_square(cord)
    has_moved = piece_current.has_moved if %w[K R].include?(symbol)
    result = []
    res.each do |destination|
      result += check_safe_move(current_player, destination, opponent_player, piece_current)
    end
    piece_current.has_moved = has_moved if %w[K R].include?(symbol)
    result
  end

  def check_safe_move(current_player, destination, opponent_player, piece_current)
    res = []
    color = piece_current.color
    cord = piece_current.location
    piece_dest = @board.get_square(destination)
    capture_piece(piece_current, color, destination, cord)

    res += [destination] unless square_under_attack?(current_player.king.location, opponent_player)

    capture_piece(piece_current, color, cord, destination)
    @board.set_square(destination, piece_dest)
    opponent_player.current_pieces += [destination] unless piece_dest.nil?
    res
  end

  def player_state(player)
    @board.rare[:check] = if square_under_attack?(player.king.location, player.color.zero? ? @player1 : @player0)
                            [player.king.location]
                          else
                            []
                          end
    player.active_pieces = get_active_pieces(player)
  end

  def get_active_pieces(player)
    active_pieces = []
    player.current_pieces.each do |cord|
      piece = @board.get_square(cord)
      available = check_available(piece.color, cord, piece.available, piece.symbol)
      capture = check_captures(piece.color, cord, piece.captures, piece.symbol)
      active_pieces += [cord] unless available.empty? && capture.empty?
    end
    active_pieces
  end
end
