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
  @query = params[:query]

  if @query
    @results = Contact.where('first_name = ? OR last_name = ?',@query,@query)
  end

  @contacts = Contact.limit(3).offset(3 * @page)


  erb :index
end

get '/contacts/:id' do
  @contact =  Contact.find(params[:id])

  erb :show
end

get '/add' do

  erb :add
end

post '/add' do
  first_name = params['add-first']
  last_name = params['add-last']
  phone_number = params['add-number']
  Contact.find_or_create_by(first_name: first_name,last_name: last_name,phone_number: phone_number)

  redirect '/'
end
