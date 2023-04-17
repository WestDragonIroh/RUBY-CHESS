# frozen_string_literal: true

require_relative 'piece'

# Class for Pawn piece.
class Pawn < Piece
  # attr_accessor :en_passent

  # def initialize(args)
  #   super(args)
  # end

  def available
    return [] if @location.nil?

    possible_available
  end

  def captures
    return [] if @location.nil?

    possible_captures
  end

  def move(cord)
    @location = cord
  end

  private

  def possible_available
    x = if @color.zero?
          @location[0] == 6 ? [[0, -1], [0, -2]] : [[0, -1]]
        else
          @location[0] == 1 ? [[0, 1], [0, 2]] : [[0, 1]]
        end
    {
      continuous_moves?: 0,
      directions: x
    }
  end

  def possible_captures
    x = if @color.zero?
          [[-1, -1], [1, -1]]
        else
          [[-1, 1], [1, 1]]
        end
    {
      continuous_moves?: 0,
      directions: x
    }
  end
end
