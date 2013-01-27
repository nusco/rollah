require 'sinatra'
require_relative 'roll'

get '/' do
  erb :index
end

post '/' do
  roll = Rollah.parse(params[:dice])
  redirect "/rolls/#{roll.id}"
end

get "/rolls/:roll_id" do
  @roll = Rollah.find(params[:roll_id].to_i)
  erb :roll
end
