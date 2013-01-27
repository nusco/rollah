require 'sinatra'
require_relative 'roll'

get '/' do
  erb :index
end

post '/' do
  @total = DiceRoller.parse(params[:dice]).total
  erb :result
end
