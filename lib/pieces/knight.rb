# frozen_string_literal: true

require_relative 'piece'

# Class for Knight piece.
class Knight < Piece
  # attr_accessor :available_moves

  # def initialize(args)
  #   super(args)
  # end

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
      continuous_moves?: 0,
      directions: [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    }
  end
end
