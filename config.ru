require 'rubygems'
require 'bundler'

Bundler.require

require "./app.rb"

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://database/chit_chat.db')

Sequel::Model.plugin(:validation_helpers)

Dir['./models/*.rb'].each {|file| require file }
Dir['./controllers/*.rb'].each {|file| require file}
Dir['./helpers/*.rb'].each {|file| require file}

run Chit_Chat
