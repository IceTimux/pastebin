# frozen_string_literal: true

require 'sinatra'
require 'dotenv/load'
require 'sequel'
require 'date'
require 'redcarpet'
require_relative 'helpers'
Sequel.connect(ENV['DATABASE_URL'])
require_relative 'models/paste'

APP_NAME = ENV['NAME'] || 'PasteBin'

get '/' do
  @name = APP_NAME
  protected!
  @pastes = Paste.reverse_order(:created_at).all
  erb :index
end

get '/new' do
  @name = APP_NAME
  protected!
  erb :new
end

post '/create' do
  protected!
  title = params['title']
  body =  params['body']
  created_at = db_format(Time.now)
  updated_at = created_at
  paste = {
    title: title,
    body: body,
    created_at: created_at,
    updated_at: updated_at
  }
  Paste.insert(paste)
  paste = Paste.last
  redirect "/#{paste.id}"
end

post '/update/:paste_id' do
  protected!
  @paste = Paste[params['paste_id']]
  title = params['title']
  body =  params['body']
  @paste.title = title
  @paste.body = body
  @paste.updated_at = db_format(Time.now)
  @paste.save
  redirect "/edit/#{@paste.id}"
end

get '/edit/:paste_id' do
  @name = APP_NAME
  protected!
  @paste = Paste[params['paste_id']]
  erb :edit
end

get '/raw/:paste_id' do
  @name = APP_NAME
  protected!
  @paste = Paste[params['paste_id']]
  "<pre>#{@paste.body}</pre>"
end

get '/markdown/:paste_id' do
  @name = APP_NAME
  protected!
  @paste = Paste[params['paste_id']]
  settings = {
    autolink: true,
    tables: true,
    fenced_code_blocks: true,
    strikethrough: true,
    superscript: true,
    underline: true,
    highlight: true,
    footnotes: true
  }
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, settings)
  @paste.body = markdown.render(@paste.body)
  erb :markdown
end

post '/delete/:paste_id' do
  protected!
  @paste = Paste[params['paste_id']]
  @paste.delete
  redirect '/'
end

get '/logout' do
  halt 401, 'Logged out.'
end

get '/:paste_id' do
  @name = APP_NAME
  protected!
  @paste = Paste[params['paste_id']]
  erb :show
end
