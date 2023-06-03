# frozen_string_literal: true

# Module to display board
module DisplayBoard
  SYMBOLS = [
    { 'B' => "\u2657", 'K' => "\u2654", 'N' => "\u2658", 'P' => "\u2659", 'Q' => "\u2655", 'R' => "\u2656" },
    { 'B' => "\u265D", 'K' => "\u265A", 'N' => "\u265E", 'P' => "\u265F", 'Q' => "\u265B", 'R' => "\u265C" }
  ].freeze

  def show_board
    # print "\e[2J\e[f"
    puts "\e[1;97m   a  b  c  d  e  f  g  h\e[0m"
    print_board
    puts "\e[1;97m   a  b  c  d  e  f  g  h\e[0m"
    puts ''
  end

  def print_board
    @board.each_with_index do |row, index|
      print "\e[1;97m#{8 - index} \e[0m"
      print_row(row, index)
      print "\e[1;97m #{8 - index} \e[0m\n"
    end
  end

  def print_row(row, row_index)
    row.each_with_index do |square, index|
      background = select_background(index, row_index)
      print_square(background, index, row_index, square)
    end
  end

  def select_background(col_index, row_index)
    if (@captures + @rare[:check]).include?([row_index, col_index])
      41
    elsif @active_piece && @active_piece.location == [row_index, col_index]
      42 # 102
    elsif @rare[:previous].include?([row_index, col_index])
      43 # 103
    elsif (row_index + col_index).even? then 106 # 104
    else
      44
    end
  end

  def print_square(background, col_index, row_index, square)
    if square
      font = square.color.zero? ? 97 : 30
      colour_square(background, font, SYMBOLS[square.color][square.symbol])
    elsif (@available + @captures).include?([row_index, col_index])
      colour_square(background, 90, "\u25cf")
    else
      colour_square(background, 37, ' ')
    end
  end

  def colour_square(background, font, text)
    print "\e[1;#{font};#{background}m #{text} \e[0m"
  end
end
