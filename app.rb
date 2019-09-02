require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/json"
require 'erubis'
require 'http'

CHOICES = [
  {
    choice: {
      id: 1,
      name: 'rock'
    }
  },
  {
    choice: {
      id: 2,
      name: 'paper'
    }
  },
  {
    choice: {
      id: 3,
      name: 'scissors'
    }
  },
  {
    choice: {
      id: 4,
      name: 'lizard'
    }
  },
  {
    choice: {
      id: 5,
      name: 'spock'
    }
  }
]

configure do
  set :bind, '0.0.0.0'
  set :port, '4568'
end

helpers do
end

def get_winner(player_choice_id, computer_choice_id)
end

def valid_choice? choice
  valid_ids = CHOICES.reduce [] do |memo, choice|
    memo.push(choice[:choice][:id])
  end

  valid_ids.include? choice
end

get '/' do
  'tie'
end

post '/' do
  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read
  "Hello player: #{data['player']}, computer: #{data['computer']}!"
end

get '/choices' do
  content_type :json
  CHOICES.to_json
end

post '/is_valid_choice' do
  content_type :json

  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read

  is_valid = valid_choice? data['choice_id'].to_i
  puts '=> choice_id: ' + data['choice_id'].to_s

  {
    is_valid: is_valid
  }.to_json
end
