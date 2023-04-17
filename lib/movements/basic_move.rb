# frozen_string_literal: true

# Module to handle basic movement of pieces
module BasicMove
  def get_available(cont, cord, move)
    x, y = new_cord_with_move(cord, move)

    return [] unless x.between?(0, 7) && y.between?(0, 7) && @board.board[x][y].nil?

    return [[x, y]] if cont.zero?

    [[x, y]] + get_available(cont, [x, y], move)
  end

  def get_captures(color, cont, cord, move)
    x, y = new_cord_with_move(cord, move)

    return [] unless x.between?(0, 7) && y.between?(0, 7)

    piece = @board.board[x][y]
    if piece.nil?
      cont == 1 ? get_captures(color, cont, [x, y], move) : []
    else
      piece.color == color ? [] : [[x, y]]
    end
  end

  def new_cord_with_move(cord, move)
    x = cord[0] + move[1]
    y = cord[1] + move[0]
    [x, y]
  end
end
