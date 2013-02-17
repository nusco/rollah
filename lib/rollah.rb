require 'sinatra'
require 'mongoid'
require_relative 'roll'

configure do
  Mongoid.load!("mongoid.yml")
end

get '/' do
  erb :index
end

post '/' do
  roll = Roll.me_a params[:dice]
  if roll.valid_roll?
    roll.roll! if params[:roll_now]
    roll.save
    redirect to("/rolls/#{roll.id}")
  else
    halt 400, erb(:wrong_roll)
  end
end

get "/rolls/:roll_id" do
  begin
    @roll = Roll.find params[:roll_id]
    view = @roll.rolled? ? :roll_rolled : :roll_called
    erb view
  rescue
    status 404
    erb :roll_not_found
  end
end
