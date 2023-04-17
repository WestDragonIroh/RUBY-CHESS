# frozen_string_literal: true

# Module to handle main logic of movements of piece
module MainMove
  def check_available(color, cord, move_set, symbol)
    res = []
    res += castling_available(color, cord) if symbol == 'K'
    move_set[:directions].each do |move|
      x = get_available(move_set[:continuous_moves?], cord, move)
      res += x
    end
    safe_moves(color, cord, symbol, res)
  end

  def check_captures(color, cord, move_set, symbol, safe: true)
    res = []
    res += en_passant_capture(color, cord) if symbol == 'P'
    move_set[:directions].each do |move|
      x = get_captures(color, move_set[:continuous_moves?], cord, move)
      res += x
    end
    safe ? safe_moves(color, cord, symbol, res) : res
  end

  def shift_piece(active_piece, color, destination, location)
    @board.set_square(destination, active_piece)
    @board.set_square(location, nil)
    active_piece.move(destination)
    player = color.zero? ? @player0 : @player1
    player.current_pieces = (player.current_pieces + [destination]) - [location]
  end

  def capture_piece(active_piece, color, destination, location)
    shift_piece(active_piece, color, destination, location)
    opponent_player = color.zero? ? @player1 : @player0
    opponent_player.current_pieces -= [destination]
  end
end
