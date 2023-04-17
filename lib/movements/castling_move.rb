# frozen_string_literal: true

# Module to handle catling moves
module CastlingMove
  def castling_available(color, cord)
    king = @board.get_square(cord)
    opponent_player = color.zero? ? @player1 : @player0
    return [] if king.has_moved || square_under_attack?(cord, opponent_player)

    check_castling_rook(cord, opponent_player, 0) + check_castling_rook(cord, opponent_player, 1)
  end

  def check_castling_rook(cord, opponent_player, side)
    rook = @board.get_square([cord[0], 7 * side])
    return [] if rook.nil? || rook.symbol != 'R' || rook.color == opponent_player.color || rook.has_moved

    side = (0 ^ side) - (1 ^ side)
    check_path_squares(cord, opponent_player, side)
  end

  def check_path_squares(cord, opponent_player, side)
    2.times do
      cord = [cord[0], cord[1] + side]
      return [] if !@board.get_square(cord).nil? || square_under_attack?(cord, opponent_player)
    end
    [cord]
  end

  def castling_move(active_piece_symbol, destination, location, player)
    return unless active_piece_symbol == 'K' && (destination[1] - location[1]).abs == 2

    destination = [destination[0], (location[1] + destination[1]) / 2]
    location = [location[0], destination[1] > location[1] ? 7 : 0]
    shift_piece(@board.get_square(location), player.color, destination, location)
  end
end
