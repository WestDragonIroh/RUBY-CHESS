# frozen_string_literal: true

require 'yaml'

# Module to serialize game for saving and loading the state of game
module Serialize
  def save_game
    Dir.mkdir 'saved_games' unless Dir.exist?('saved_games')
    filename = make_filename
    File.open("saved_games/#{filename}", 'w') do |file|
      file.write(YAML.dump(self))
    end
    game_saved(filename)
  rescue StandardError => e
    error_file_write(filename, e)
  end

  def make_filename
    date = Time.now.strftime('%Y-%m-%d').to_s
    time = Time.now.strftime("%H'%M'%S").to_s
    # time = Time.now.to_i
    "#{date} at #{time} chess.yml"
  end

  def load_game
    unless Dir.exist?('saved_games') && !Dir.empty?('saved_games')
      error_open_file
      return start
    end

    file_name = find_saved_file
    safe_class = [Symbol, Game, Board, Engine, Player, Bishop, King, Knight, Pawn, Queen, Rook]
    File.open("saved_games/#{file_name}", 'r') do |file|
      att = YAML.safe_load(file, permitted_classes: safe_class, permitted_symbols: [], aliases: true)
      load_attributes(att)
    end
  end

  def load_attributes(game)
    game.instance_variables.each do |var|
      instance_variable_set(var, game.instance_variable_get(var))
    end
  end
end
