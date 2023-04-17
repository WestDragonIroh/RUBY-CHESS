# frozen_string_literal: true

require_relative './display/display_board'
require_relative './Pieces/bishop'
require_relative './Pieces/king'
require_relative './Pieces/knight'
require_relative './Pieces/pawn'
require_relative './Pieces/queen'
require_relative './Pieces/rook'

# Board class
class Board
  attr_accessor :active_piece, :available, :board, :captures, :check, :rare

  include DisplayBoard

  def initialize(mode)
    @board = initialise_board if mode != 1
    @available = []
    @captures = []
    @rare = { check: [], en_pass: [], previous: [] }

    # custom
  end

  def custom
    # @board[1][6] = Pawn.new([0, [1, 6], 'P'])
    # @board[6][4] = nil
    # @board[7][5] = nil
    # @board[7][6] = nil
    # @board[4][7] = Bishop.new([1, [4, 7], 'B'])
    # @board[4][2] = Bishop.new([1, [4, 2], 'B'])
    # @board[3][2] = Bishop.new([1, [3, 2], 'B'])
    # @board[4][7] = Queen.new([1, [4, 7], 'Q'])
  end

  def initialise_board
    board = Array.new(8) { Array.new(8, nil) }
    board[0] = initial_pieces(1, 0)
    board[1] = initial_pawns(1, 1)
    board[6] = initial_pawns(0, 6)
    board[7] = initial_pieces(0, 7)
    board
  end

  def initial_pieces(color, number)
    [
      Rook.new([color, [number, 0], 'R']),
      Knight.new([color, [number, 1], 'N']),
      Bishop.new([color, [number, 2], 'B']),
      Queen.new([color, [number, 3], 'Q']),
      King.new([color, [number, 4], 'K']),
      Bishop.new([color, [number, 5], 'B']),
      Knight.new([color, [number, 6], 'N']),
      Rook.new([color, [number, 7], 'R'])
    ]
  end

  def initial_pawns(color, number)
    row = Array.new(8)
    8.times do |index|
      row[index] = Pawn.new([color, [number, index], 'P'])
    end
    row
  end

  def get_square(cord)
    x, y = cord
    @board[x][y]
  end

  def set_square(cord, value)
    x, y = cord
    @board[x][y] = value
  end
end
