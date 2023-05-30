# frozen_string_literal: true

require_relative 'display/display_board'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

# Board class
class Board
  attr_accessor :active_piece, :available, :board, :captures, :check, :past_board, :rare

  include DisplayBoard

  def initialize(mode = 0)
    @board = mode.zero? ? Array.new(8) { Array.new(8, nil) } : initialise_board
    @available = []
    @captures = []
    @past_board = []
    @rare = { check: [], en_pass: [], move_number: 0, previous: [] }
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

  def board_string
    s = ''
    @board.each do |row|
      row.each do |element|
        s += element.nil? ? '_' : element.color.to_s + element.symbol.to_s
      end
    end
    s
  end
end
