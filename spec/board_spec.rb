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

describe Board do
  subject(:board) { described_class.new(1) }

  describe '#initialise_board' do
    context 'checking rows' do
      it 'has top row of black game pieces' do
        expect(board.board[0].all? { |piece| piece.color == 1 }).to be true
      end

      it 'has second row of black game pieces' do
        expect(board.board[1].all? { |piece| piece.color == 1 }).to be true
      end

      it 'has sixth row of white game pieces' do
        expect(board.board[6].all? { |piece| piece.color == 0 }).to be true
      end

      it 'has bottom row of white game pieces' do
        expect(board.board[7].all? { |piece| piece.color == 0 }).to be true
      end
    end
  end
end

describe Board do
  subject(:board) { described_class.new(1) }

  describe '#initialize_board' do
    context 'checking top left' do
      it 'has top row first Rook' do
        expect(board.get_square([0, 0]).instance_of?(Rook)).to be true
      end

      it 'has top row first Knight' do
        expect(board.get_square([0, 1]).instance_of?(Knight)).to be true
      end

      it 'has top row first Bishop' do
        expect(board.get_square([0, 2]).instance_of?(Bishop)).to be true
      end

      it 'has top row Queen' do
        expect(board.get_square([0, 3]).instance_of?(Queen)).to be true
      end
    end
  end
end

describe Board do
  subject(:board) { described_class.new(1) }

  describe '#initialize_board' do
    context 'checking top right' do
      it 'has top row King' do
        expect(board.get_square([0, 4]).instance_of?(King)).to be true
      end

      it 'has top row second Bishop' do
        expect(board.get_square([0, 5]).instance_of?(Bishop)).to be true
      end

      it 'has top rowsecond Knight' do
        expect(board.get_square([0, 6]).instance_of?(Knight)).to be true
      end

      it 'has top row second Rook' do
        expect(board.get_square([0, 7]).instance_of?(Rook)).to be true
      end
    end
  end
end

describe Board do
  subject(:board) { described_class.new(1) }

  describe '#initialize_board' do
    it 'has second row of pawns' do
      expect(board.board[1].all? { |piece| piece.instance_of?(Pawn) }).to be true
    end

    it 'has sixth row of pawns' do
      expect(board.board[6].all? { |piece| piece.instance_of?(Pawn) }).to be true
    end
  end
end

describe Board do
  subject(:board) { described_class.new(1) }

  describe '#initialize_board' do
    context 'checking bottom left' do
      it 'has bottom row first Rook' do
        expect(board.get_square([7, 0]).instance_of?(Rook)).to be true
      end

      it 'has bottom row first Knight' do
        expect(board.get_square([7, 1]).instance_of?(Knight)).to be true
      end

      it 'has bottom row first Bishop' do
        expect(board.get_square([7, 2]).instance_of?(Bishop)).to be true
      end

      it 'has bottom row Queen' do
        expect(board.get_square([7, 3]).instance_of?(Queen)).to be true
      end
    end
  end
end

describe Board do
  subject(:board) { described_class.new(1) }

  describe '#initialize_board' do
    context 'checking bottom right' do
      it 'has bottom row King' do
        expect(board.get_square([7, 4]).instance_of?(King)).to be true
      end

      it 'has bottom row second Bishop' do
        expect(board.get_square([7, 5]).instance_of?(Bishop)).to be true
      end

      it 'has bottom row second Knight' do
        expect(board.get_square([7, 6]).instance_of?(Knight)).to be true
      end

      it 'has bottom row second Rook' do
        expect(board.get_square([7, 7]).instance_of?(Rook)).to be true
      end
    end
  end
end

describe Board do
  subject(:board) { described_class.new }
  context '#getter and setter' do
    it 'check at location 2, 4' do
      piece = Piece.new([1, [2, 4], 'D'])
      board.set_square([2, 4], piece)
      expect(board.get_square([2, 4])).to eql piece
    end

    it 'check at location 7, 1' do
      piece = Piece.new([0, [7, 1], 'D'])
      board.set_square([7, 1], piece)
      expect(board.get_square([7, 1])).to eql piece
    end
  end

  describe '#board_string' do
    it '35 position have piece' do
      board.set_square([4, 3], Piece.new([1, [4, 3], 'D']))
      expect(board.board_string[35, 2]).to eql '1D'
    end

    it '52 position have piece' do
      board.set_square([6, 4], Piece.new([1, [6, 4], 'D']))
      expect(board.board_string[52, 2]).to eql '1D'
    end
  end
end
