# frozen_string_literal: true

# Class to handle Chess Engine decisions
class Engine
  def choose(player)
    puts "\e[1;93m#{player.color.zero? ? 'White' : 'Black'}'s turn\e[0m\n\n"
    sleep(1)
    player.active_pieces.sample
  end

  def move(board)
    sleep(1)
    (board.available + board.captures * 5).sample
  end

  def promote
    sleep(1)
    %w[n q].sample
  end
end
