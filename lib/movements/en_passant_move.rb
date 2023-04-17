# frozen_string_literal: true

# Module to handle french special move En Passant
module EnPassantMove
  def en_passant_capture(color, cord)
    x, y = cord
    z = [[x + (color ^ 0) - (color ^ 1), y - 1], [x + (color ^ 0) - (color ^ 1), y + 1]]

    en_pass = @board.rare[:en_pass]
    if z.include?(en_pass) && @board.get_square(en_pass).nil?
      [en_pass]
    else
      []
    end
  end

  def en_passant_state(active_piece_symbol, color, destination, location)
    en_passant_piece_remove(active_piece_symbol, color, destination)

    @board.rare[:en_pass] = if active_piece_symbol == 'P' && (destination[0] - location[0]).abs == 2
                              [((destination[0] + location[0]) / 2), location[1]]
                            else
                              []
                            end
  end

  def en_passant_piece_remove(active_piece_symbol, color, destination)
    return unless destination == @board.rare[:en_pass] && active_piece_symbol == 'P'

    destination = [destination[0] + ((color ^ 1) - (color ^ 0)), destination[1]]
    @board.set_square(destination, nil)
    opponent_player = color.zero? ? @player1 : @player0
    opponent_player.current_pieces -= [destination]
  end
end
