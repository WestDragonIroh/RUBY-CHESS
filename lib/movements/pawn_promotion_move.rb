# frozen_string_literal: true

# Module to handle pawn promotion
module PawnPromotionMove
  def check_pawn_promotion(active_piece, destination, player)
    return unless active_piece.symbol == 'P' && destination[0] == (7 * (active_piece.color ^ 0))

    @board.show_board
    inp = player.is_computer ? @engine.promote : select_promotion
    arg = [active_piece.color, destination]
    @board.set_square(destination, promotion_initialize(arg, inp))
  end

  def promotion_initialize(arg, inp)
    case inp
    when 'b' then piece = Bishop.new(arg + ['B'])
    when 'n' then piece = Knight.new(arg + ['N'])
    when 'q' then piece = Queen.new(arg + ['Q'])
    when 'r'
      piece = Rook.new(arg + ['R'])
      piece.has_moved = true
    end
    piece
  end
end
