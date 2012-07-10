$LOAD_PATH.unshift 'lib'
require 'trello'
require 'rubygems'
require 'simple_xlsx'
require 'yaml'
require_relative 'filewriter'

include Trello
include Trello::Authorization

Trello::Authorization.const_set :AuthPolicy, OAuthPolicy

CONFIG = YAML::load(File.open("config.yml")) unless defined? CONFIG

credential = OAuthCredential.new CONFIG['public_key'], CONFIG['private_key']
OAuthPolicy.consumer_credential = credential

OAuthPolicy.token = OAuthCredential.new CONFIG['access_token_key'], nil

me = Member.find("me")
boardarray = Array.new
optionnum = 1
me.boards.each do |board|
	boardarray << board
	puts "#{optionnum}: #{board.name} #{board.id}"
	optionnum += 1
end

puts "Which board would you like to backup?"
puts "0 - CANCEL"
board_to_archive = gets.to_i - 1

board = Board.find(boardarray[board_to_archive].id)

if board_to_archive != -1
	puts "Would you like to provide a filename? (y/n)"
	response = gets.downcase

	if response=="y"
		puts "Enter filename:"
		filename = gets
	else
		filename = board.name.parameterize
	end


	puts "Preparing to backup #{board.name}"
	lists = board.lists

  createspreadsheet(board, filename)
else
	puts "Cancelling"
end
