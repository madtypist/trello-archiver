$LOAD_PATH.unshift 'lib'
require 'trello'
require 'rubygems'
require 'simple_xlsx'
require_relative 'filewriter'
require 'yaml'

include Trello
include Trello::Authorization

Trello::Authorization.const_set :AuthPolicy, OAuthPolicy

CONFIG = YAML::load(File.open("config.yml")) unless defined? CONFIG

credential = OAuthCredential.new CONFIG['public_key'], CONFIG['private_key']
OAuthPolicy.consumer_credential = credential

OAuthPolicy.token = OAuthCredential.new CONFIG['access_token_key'], nil

ignore = CONFIG['ignore']

me = Member.find("me")
boardarray = Array.new
me.boards.each do |board|
  if ignore.include? board.id
	  puts "Skipping #{board.name}"
  else
    filename = board.name.parameterize
    puts "Preparing to backup #{board.name}"
    createspreadsheet(board, filename)
	end
end
