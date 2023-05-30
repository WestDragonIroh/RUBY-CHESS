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

describe Serialize do
  let(:dummy_class) { Game.new(Board.new, testing: true) }

  describe '#save_game' do
    before(:all) do
      @prev_num = Dir.exist?('saved_games') ? Dir['saved_games/*'].length : 0
    end

    after(:all) do
      n = Dir['saved_games/*'].length - @prev_num
      Dir.children('saved_games')[-n, n].each { |f| File.delete("saved_games/#{f}") }
      Dir.rmdir('saved_games') if @prev_num.zero?
    end

    before do
      allow(dummy_class).to receive(:puts)
      allow(YAML).to receive(:dump)
    end

    it 'opens a file' do
      expect(File).to receive(:open)
      dummy_class.save_game
    end

    it 'dumps the file' do
      expect(YAML).to receive(:dump)
      dummy_class.save_game
    end

    it 'does not raise an error' do
      expect { dummy_class.save_game }.not_to raise_error
    end
  end
end

describe Serialize do
  let(:dummy_class) { Game.new(Board.new, testing: true) }

  describe '#load_game' do
    before(:all) do
      Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
      File.open('saved_games/temp.yml', 'w') { |f| f.write(YAML.dump('')) }
    end

    after(:all) do
      File.delete('saved_games/temp.yml')
      Dir.rmdir('saved_games') if Dir.empty?('saved_games')
    end

    before do
      allow(dummy_class).to receive(:find_saved_file).and_return('temp.yml')
      allow(dummy_class).to receive(:load_attributes)
      allow(YAML).to receive(:safe_load)
    end

    it 'opens a file' do
      expect(File).to receive(:open)
      dummy_class.load_game
    end

    it 'loads the file' do
      expect(YAML).to receive(:safe_load)
      dummy_class.load_game
    end
  end
end
