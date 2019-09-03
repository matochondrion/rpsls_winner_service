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

def compute_winner(players_choices)
  winner_resolve = R_P_S_L_S.new
  winner_resolve.compute_winner players_choices
  {}
end

def valid_choice? choice
  valid_ids = CHOICES.reduce [] do |memo, choice|
    memo.push(choice[:choice][:id])
  end

  valid_ids.include? choice
end

get '/' do
  'winner_service'
end

namespace '/api' do
  post '/compute_winner' do
    content_type :json

    request.body.rewind  # in case someone already read it
    data = JSON.parse request.body.read

    # convertIdToChoice data['player']
    # convertIdToChoice data['computer']

    players_choices = [
      { id: 1, name: 'player', choice: 'rock' },
      { id: 2, name: 'computer', choice: 'rock' }
    ]

    compute_winner(players_choices).to_json

    # {
    #   'player_choice_id': "#{data['player']}",
    #   'computer_choiece_id': "#{data['computer']}",
    #   'player': 'win',
    #   'computer': 'loose'
    # }.to_json

    # {
    #   'test': 'test'
    # }.to_json
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
end
