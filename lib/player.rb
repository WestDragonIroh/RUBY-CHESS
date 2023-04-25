# frozen_string_literal: true

# Player class for white and black sides
class Player
  attr_reader :color, :is_computer, :king

  attr_accessor :active_pieces, :current_pieces

  def initialize(board, color, is_computer)
    @active_pieces = []
    @color = color
    @current_pieces = initial_pieces(board)
    @is_computer = is_computer
  end

  def initial_pieces(board)
    pieces = []
    board.each do |row|
      row.each do |piece|
        next unless !piece.nil? && piece.color == @color

        pieces += [piece.location]
        @king = piece if piece.symbol == 'K'
      end
    end
    pieces
  end
end
