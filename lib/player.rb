# frozen_string_literal: true

# Player class for white and black sides
class Player
  attr_accessor :active_pieces, :color, :current_pieces, :king

  def initialize(board, color)
    @active_pieces = []
    @color = color
    @current_pieces = initial_pieces(board)
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
