require 'sinatra'
require 'shotgun'
require 'sinatra/activerecord'
require 'pg'
require'rake'
require 'pry'
require "./app"
require "sinatra/activerecord/rake"

require_relative 'models/contact'




get '/' do
  @page = params[:page].to_i

  @contacts = Contact.limit(3).offset(3 * @page)

  erb :index
end

get '/contacts/:id' do
  @contact =  Contact.find(params[:id])

  erb :show
end
