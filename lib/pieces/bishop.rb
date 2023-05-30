# frozen_string_literal: true

require_relative 'piece'

# Class for Bishop piece.
class Bishop < Piece
  def available
    return [] if @location.nil?

    possible_moves
  end

  def captures
    available
  end

  def move(cord)
    @location = cord
  end

  private

  def possible_moves
    {
      continuous_moves?: 1,
      directions: [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    }
  end
end
