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

  def compute_winner(players_data)
    player1 = players_data[0]
    player2 = players_data[1]

    # TODO: Test that objects and values are truly clones and
    # immutable.
    results = players_data.clone

    if WINNER[player1['choice']].include? player2['choice']
      results[0][:result] = 'win'
      results[1][:result] = 'lose'
    elsif WINNER[player2['choice']].include? player1['choice']
      results[0][:result] = 'lose'
      results[1][:result] = 'win'
    else
      results[0][:result] = 'tie'
      results[1][:result] = 'tie'
    end

    results
  end
end
