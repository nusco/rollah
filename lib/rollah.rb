require 'sinatra'
require_relative 'roll'

get '/' do
  erb :index
end

post '/' do
  roll = Rollah::Roll.new(params[:dice])
  if roll.valid?
    roll.roll!
    redirect to("/rolls/#{roll.id}")
  else
    halt 400, erb(:wrong_roll)
  end
end

get "/rolls/:roll_id" do
  @roll = Rollah.find(params[:roll_id])
  return 404 if !@roll
  erb :roll
end

not_found do
  erb :roll_not_found
end
