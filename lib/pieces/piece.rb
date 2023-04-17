# frozen_string_literal: true

# Abstract class for pieces
class Piece
  attr_reader :color, :symbol
  attr_accessor :location

  def initialize(args)
    @color = args[0]
    @location = args[1]
    @symbol = args[2]
  end
end
