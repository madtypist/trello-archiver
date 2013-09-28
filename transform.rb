# encoding: utf-8

$LOAD_PATH.unshift 'lib'
require 'trello'
require 'rubygems'
require 'simple_xlsx'
require 'yaml'
require_relative 'versionone'

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

puts "0 - CANCEL\n\n"
puts "Which board would you like to export?"
board_to_archive = gets.to_i - 1

board = Board.find(boardarray[board_to_archive].id)

if board_to_archive != -1
	puts "Would you like to provide a filename? (y/n)"
	response = gets.downcase.chomp

	if response.to_s =="y"
		puts "Enter filename:"
		filename = gets
	else
		filename = board.name.parameterize
	end


	puts "Preparing to backup #{board.name}"
	lists = board.lists

  versiononeformat(board, filename)
else
	puts "Cancelling"
end
