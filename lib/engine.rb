# frozen_string_literal: true

# Class to handle Chess Engine decisions
class Engine
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def choose
    puts "\e[1;93m#{player.color.zero? ? 'White' : 'Black'}'s turn\e[0m\n\n"
    sleep(0.5)
    @player.active_pieces.sample
  end

  def move(board)
    sleep(0.5)
    (board.available + board.captures * 2).sample
  end

  def promote
    sleep(0.5)
    %w[n q].sample
  end
end
