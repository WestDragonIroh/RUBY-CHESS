# frozen_string_literal: true

require_relative 'game'

puts "\n\e[1;95mWelcome to Ruby chess ＜（＾－＾）＞ \n \e[0m"

loop do
  game = Game.new
  game.play
  break unless game.new_game?
end

puts "\n\e[1;95mThanks for playing （￣︶￣）↗　 \n \e[0m"
