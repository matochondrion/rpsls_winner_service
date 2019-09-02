require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/json"
require 'erubis'
require 'http'

CHOICES = [
  {
    'choice': {
      'id': 1,
      'name': 'rock'
    }
  },
  {
    'choice': {
      'id': 2,
      'name': 'paper'
    }
  },
  {
    'choice': {
      'id': 3,
      'name': 'scissors'
    }
  },
  {
    'choice': {
      'id': 4,
      'name': 'lizard'
    }
  },
  {
    'choice': {
      'id': 5,
      'name': 'spock'
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
  #
  response = HTTP.accept(:json).follow(max_hops: 3)
                 .get(RPSLS_WINNER_SERVER)
  computer_choice_id
  'win'
end

get '/' do
  'tie'
end

post '/' do
  'tie'
end
