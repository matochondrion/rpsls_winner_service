class R_P_S_L_S
# TODO: add config for
#       - add validation
#       - simplify data structures
#       - fix rubocop complaints
  VALID_CHOICES = %w(rock paper scissors lizard spock)

  WINNER = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper'],
    'spock' => ['scissors', 'rock']
  }

  def prompt(message)
    Kernel.puts("=> #{message}")
  end

  def compute_winner(players_choices)
    player1 = players_choices[0]
    player2 = players_choices[1]

    #TODO: Test that objects and values are truly clones and
    #immutable.
    results = [player1.clone, player2.clone]

    if WINNER[player1[:choice]].include? player2[:choice]
      results[0][:result] = 'win'
      results[1][:result] = 'lose'
    elsif WINNER[player2[:choice]].include? player1[:choice]
      results[0][:result] = 'lose'
      results[1][:result] = 'win'
    else
      results[0][:result] = 'tie'
      results[1][:result] = 'tie'
    end

    results
  end
end

players_choices = [
  { id: 1, name: 'player', choice: 'rock' },
  { id: 2, name: 'computer', choice: 'paper' }
]

resolver = R_P_S_L_S.new
puts resolver.compute_winner(players_choices)

# player1 = { name: 'player', choice: 'rock' }
# player2 = { name: 'computer', choice: 'scissors' }

# game = R_P_S_L_S.new({},{})

# puts game.compute_winner(player1, player2)

