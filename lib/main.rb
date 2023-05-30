# frozen_string_literal: true

require_relative 'game'

puts "\n\e[1;95mWelcome to Chess ＜（＾－＾）＞ \n \e[0m"

puts "\e[1;97mEach player turn would be played in two steps."
puts "\n\e[95mStep One:-\e[97m\nEnter the coordinates of the piece you want to move."
print "\n\e[95mStep Two:-\e[97m\nEnter the coordinates of any legal move "
puts "\e[106m \u25cf \e[0m\e[1;97m or capture \e[41m \u2659 \e[0m\e[1;97m .\n \e[0m"

loop do
  game = Game.new
  game.play
  break unless game.new_game?
end

puts "\n\e[1;95mThanks for playing （￣︶￣）↗　 \n \e[0m"
