# frozen_string_literal: true

require_relative 'piece'

# Class for Rook piece.
class Rook < Piece
  attr_accessor :has_moved

  def initialize(args)
    super(args)

    @has_moved = false
  end

  def available
    return [] if @location.nil?

    possible_moves
  end

  def captures
    available
  end

  def move(cord)
    @location = cord
    @has_moved = true
  end

  private

  def possible_moves
    {
      continuous_moves?: 1,
      directions: [[-1, 0], [1, 0], [0, -1], [0, 1]]
    }
  end
end
