# frozen_string_literal: true

require_relative './display/display_prompts'
require_relative './movements/movement'
require_relative 'board'
require_relative 'player'

# Class to handle game functions
class Game
  attr_accessor :board, :player0, :player1, :turn

  include DisplayPrompts
  include Movement

  def initialize
    selection(0)
  end

  def play
    @board.show_board

    loop do
      win = @turn ? player_turn(@player1) : player_turn(@player0)
      return if win

      @turn = !@turn
    end
  end

  def selection(mode)
    return unless mode.zero?

    @board = Board.new(0)
    @player0 = Player.new(@board.board, 0)
    @player1 = Player.new(@board.board, 1)
    player_state(@player0)
    @turn = false
  end

  def player_turn(player)
    status = choose_piece(player)
    return game_status(player, status) if %w[q].include?(status)

    @board.show_board
    status = move_piece(player)
    return game_status(player, status) if %w[q].include?(status)

    @board.show_board
    game_state(player.color.zero? ? @player1 : @player0)
  end

  def game_state(player)
    if player.active_pieces.empty?
      if @board.rare[:check] == [player.king.location]
        game_checkmate(player)
      else
        game_stalemate
      end
      true
    else
      false
    end
  end

  def game_status(player, status)
    game_resignation(player) if status == 'q'
    true
  end
end
