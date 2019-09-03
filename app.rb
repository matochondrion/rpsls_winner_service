require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require_relative 'lib/rock_paper_scissors_lizard_spock.rb'

# TODO: add config for
#       - URLs
#       - ports
#       - fix rubocop complaints

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

def compute_winner(players_data)
  winner_resolve = R_P_S_L_S.new
  winner_resolve.compute_winner players_data
end

def valid_choice? choice
  valid_ids = CHOICES.reduce [] do |memo, choice|
    memo.push(choice[:choice][:id])
  end

  valid_ids.include? choice
end

def add_choices_to_players_data! players_data
  players_data.each { |data|
    data['choice'] = choiceIdToChoice data['choice_id']
  }
end

def choiceIdToChoice choice_id
  selected_choice = CHOICES.select do |choice|
    choice[:choice][:id] == choice_id
  end[0]

  selected_choice[:choice][:name]
end

get '/' do
  'winner_service'
end

namespace '/api' do
  post '/compute_winner' do
    content_type :json

    request.body.rewind  # in case someone already read it
    players_data = JSON.parse request.body.read

    add_choices_to_players_data! players_data

    compute_winner(players_data).to_json
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

    {
      is_valid: is_valid
    }.to_json
  end
end
