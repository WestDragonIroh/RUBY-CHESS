# frozen_string_literal: true

require_relative 'basic_move'
require_relative 'castling_move'
require_relative 'en_passant_move'
require_relative 'main_move'
require_relative 'pawn_promotion_move'
require_relative 'valid_move'

# Module to handle all the available movements and captures.
module Movement
  include BasicMove
  include CastlingMove
  include EnPassantMove
  include MainMove
  include PawnPromotionMove
  include ValidMove

  def choose_piece(player)
    piece = player.is_computer ? @engine.choose(player) : select_piece(player)
    return piece if %w[q s].include?(piece)

    state = state_piece(piece)
    if state[1].empty? && state[2].empty?
      error_movable_piece
      choose_piece(player)
    else
      setting_state_piece(state)
    end
  end

  def state_piece(cord)
    piece = @board.get_square(cord)
    [
      piece,
      check_available(piece.color, cord, piece.available, piece.symbol),
      check_captures(piece.color, cord, piece.captures, piece.symbol)
    ]
  end

  def setting_state_piece(state)
    @board.active_piece = state[0]
    @board.available = state[1]
    @board.captures = state[2]
  end

  def move_piece(player)
    destination = player.is_computer ? @engine.move(@board) : select_move(@board)
    return destination if %w[q s].include?(destination)

    active_piece = @board.active_piece
    location = active_piece.location
    move_type(active_piece, player.color, destination, location)
    move_effects(active_piece, destination, location, player)
  end

  def move_type(active_piece, color, destination, location)
    if @board.available.include?(destination)
      shift_piece(active_piece, color, destination, location)
    else
      capture_piece(active_piece, color, destination, location)
    end
  end

  def move_effects(active_piece, destination, location, player)
    castling_move(active_piece.symbol, destination, location, player)
    en_passant_state(active_piece.symbol, player.color, destination, location)
    move_number_state(destination)
    reset_state_piece(destination, location)
    check_pawn_promotion(active_piece, destination, player)
    player_state(player.color.zero? ? @player1 : @player0)
  end

  def reset_state_piece(destination, location)
    @board.active_piece = nil
    @board.available = []
    @board.captures = []
    @board.rare[:previous] = [destination, location]
  end

  def move_number_state(destination)
    piece = @board.get_square(destination)
    if @board.captures.include?(destination) || piece.symbol == 'P'
      @board.rare[:move_number] = 0
    else
      @board.rare[:move_number] += 1
    end
  end
end
