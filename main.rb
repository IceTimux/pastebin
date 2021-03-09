# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load'
require 'sequel'
require_relative 'helpers'

DB = Sequel.connect(ENV['DATABASE_URL'])

require_relative 'models/paste'

get '/' do
  protected!
  @pastes = Paste.all
  erb :index
end

get '/new' do
  protected!
  erb :new
end

get '/edit/:paste_id' do
  protected!
  @paste = Paste[params['paste_id']]

  erb :edit
end

post '/delete/:paste_id' do
  protected!
  @paste = Paste[params['paste_id']]

  # TODO: handle paste deletion
end

get '/:paste_id' do
  protected!
  @paste = Paste[params['paste_id']]
  erb :show
end

get '/logout' do
  halt 401, 'Logged out.'
end
