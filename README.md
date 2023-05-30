# Ruby Chess

This project is from Ruby curriculum at
[The Odin Project](https://www.theodinproject.com/lessons/ruby-connect-four).

## Description

Welcome to Ruby Chess! This project is a command-line implementation of the
classic game of chess, written in Ruby. It offers a simple yet engaging gameplay
experience where you can play against a computer opponent or against another
human player. I wanted to create UI similar to
[chess.com](https://www.chess.com/) so I split each turn in 2 parts. You can
quit or save game at any point.

## Project Requirements

### Objectives

- 2-player game with legal moves.
- Save and Load game.
- Testing of important methods.
- Computer player

### Rules implemented

- King cannot move into or ignore check
- Castling is only legal if:
  - King is not in check
  - Neither piece has moved
  - King will not move into check along the path to its destination square
- En passant is only legal immediately following opponent's two-square pawn move
- Checkmate if player to move has no legal moves and their King is in check
- Stalemate if player to move has no legal moves and their King is not in check
- Resignation if player decides to quit the game
- Threefold repetition if position has occured three times, including the
  following considerations:
  - Same player to move
  - Same castling rights
  - Same en passant rights
- Draw if during the last 50 moves no capture or pawn move has occurred

## How to play

### Play Online

If you want to play this game without installing it on your computer, you can
play it [online](https://replit.com/@AkshatJaiswal/RUBY-CHESS). Just click the
`run` button at the top of the page. It will take a few seconds to load the
dependencies and then the game menu will appear.

### Play offline

#### Prerequisites

- ruby >= 3.0
- vs code or windows terminal have font set that supports chess symbols(like
  DejaVu Sans Mono)

#### Installation

- Clone this repo
  ([steps](https://support.atlassian.com/bitbucket-cloud/docs/clone-a-git-repository/))
- Navigate into this project's directory `cd ruby_chess`

#### Play

- Run `ruby lib/main.rb` , to start game.
- Select mode of playing from 1-player , 2-player or one of the game saved
  before.
- Each turn have two steps.
- First to select coordinates of piece and Second to select coordinatesof legal
  move or capture.

## Technologies used

<p align="left">

<a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/>
</a> <a href="https://rspec.info/" target="_blank" rel="noreferrer">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/rspec/rspec-original.svg" alt="rspec" width="40" height="40"/>
</a> </p>
