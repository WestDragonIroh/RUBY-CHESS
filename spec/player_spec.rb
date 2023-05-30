# frozen_string_literal: true

require_relative '../lib/display/display_prompts'
require_relative '../lib/movements/movement'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/rook'
require_relative '../lib/board'
require_relative '../lib/engine'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/serialize'

describe Player do
  describe '#initial_pieces' do
    let(:board) { Board.new }
    subject(:player) { Player.new(board.board, 1, 0) }

    # _____ _____ _____ _____ bking _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ wpawn _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ bpawn _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ wrook _____ _____ _____

    before do
      board.set_square([0, 4], King.new([1, [0, 4], 'K']))
      board.set_square([7, 4], Rook.new([0, [7, 4], 'R']))
      board.set_square([3, 1], Pawn.new([0, [3, 1], 'P']))
      board.set_square([4, 4], Pawn.new([1, [4, 4], 'P']))
    end

    context 'when king passed' do
      it 'has pawn at 4, 4' do
        expect(player.current_pieces).to include [4, 4]
      end

      it 'has no piece at 3, 1' do
        expect(player.current_pieces).not_to include [3, 1]
      end

      it 'has king at 0, 4' do
        expect(player.king.location).to eql [0, 4]
      end
    end
  end
end

describe Player do
  describe '#initial_pieces' do
    let(:board) { Board.new }
    subject(:player) { Player.new(board.board, 0, 0) }

    # _____ _____ _____ _____ bking _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ wpawn _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ bpawn _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ _____ _____ _____ _____
    # _____ _____ _____ _____ wrook _____ _____ _____

    before do
      board.set_square([0, 4], King.new([1, [0, 4], 'K']))
      board.set_square([7, 4], Rook.new([0, [7, 4], 'R']))
      board.set_square([3, 1], Pawn.new([0, [3, 1], 'P']))
      board.set_square([4, 4], Pawn.new([1, [4, 4], 'P']))
    end

    context 'when king not passes' do
      it 'has pawn at 3, 1' do
        expect(player.current_pieces).to include [3, 1]
      end

      it 'has no piece at 3, 4' do
        expect(player.current_pieces).not_to include [4, 4]
      end

      it 'has king at -1, -1' do
        expect(player.king.location).to eql [-1, -1]
      end
    end
  end
end
