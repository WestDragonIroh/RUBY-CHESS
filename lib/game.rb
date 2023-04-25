# frozen_string_literal: true

require_relative './display/display_prompts'
require_relative './movements/movement'
require_relative 'board'
require_relative 'engine'
require_relative 'player'

# Class to handle game functions
class Game
  attr_accessor :board, :engine, :player0, :player1, :turn

  include DisplayPrompts
  include Movement

  def initialize
    case game_mode
    when 0 then basic_game
    when 1 then engine_game
    end
  end

  def basic_game
    @board = Board.new(0)
    @player0 = Player.new(@board.board, 0, false)
    @player1 = Player.new(@board.board, 1, false)
    player_state(@player0)
    @turn = false
  end

  def engine_game
    @board = Board.new(0)
    player = mode_player
    p player
    @player0 = Player.new(@board.board, 0, player.zero?)
    @player1 = Player.new(@board.board, 1, !player.zero?)
    @engine = Engine.new(player.zero? ? @player0 : @player1)
    player_state(@player0)
    @turn = false
  end

  def play
    @board.show_board

    loop do
      win = @turn ? player_turn(@player1) : player_turn(@player0)
      return if win

      @turn = !@turn
    end
  end

  def player_turn(player)
    status = choose_piece(player)
    return game_status(player, status) if %w[q].include?(status)

    @board.show_board
    status = move_piece(player)
    return game_status(player, status) if %w[q].include?(status)

    @board.show_board
    game_state(player.color.zero? ? @player1 : @player0) || board_state
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

  def board_state
    current_board = @board.board_string
    @board.past_board << current_board
    if @board.past_board.count(current_board) >= 3 || @board.rare[:move_number] == 100
      game_draw
      true
    else
      false
    end
  end
end
