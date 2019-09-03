VALID_CHOICES = %w(rock paper scissors lizard spock)

WINNER = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['spock', 'paper'],
  'spock' => ['scissors', 'rock']
}

score = { player: 0, computer: 0 }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_results(player, computer, winner)
  if winner[player].include? computer
    prompt("You won!")
  elsif winner[computer].include? player
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def update_score(player, computer, winner, score)
  if winner[player].include? computer
    score[:player] += 1
  elsif winner[computer].include? player
    score[:computer] += 1
  end
end

def display_score(score)
  score = '|' + "PLAYER: #{score[:player]}".center(18) +
          '|' + "COMPUTER: #{score[:computer]}".center(18) + '|'
  prompt "---------------------------------------"
  prompt score
  prompt "---------------------------------------"
end

def prompt_player_choice
  prompt("Choose your weapon! Or type 'q' to quit:")
  prompt(VALID_CHOICES.join('  ').to_s)
  Kernel.gets().chomp().downcase
end

def validated_choices(choice)
  validated_choices = []

  VALID_CHOICES.each do |word|
    if word.start_with? choice
      validated_choices << word
    end
  end
  validated_choices
end

def player_choice
  validated_choices = []
  choice = ''

  until validated_choices.length == 1
    choice = prompt_player_choice()

    return choice if choice == 'q'

    validated_choices = validated_choices(choice)
    prompt("That's not a valid choice.") unless validated_choices.length == 1
    prompt("Please be more specific") if validated_choices.length > 1
    prompt('')
  end

  validated_choices[0]
end

while score[:player] < 5 && score[:computer] < 5
  choice = player_choice()

  break if choice == 'q'

  computer_choice = VALID_CHOICES.sample()

  display_results(choice, computer_choice, WINNER)
  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")
  update_score(choice, computer_choice, WINNER, score)
  prompt('')
  display_score(score)
  prompt('')

end

if score[:player] > score[:computer]
  prompt "PLAYER WINS!!!"
elsif score[:computer] > score[:player]
  prompt "COMPUTER WINS!!!"
else
  prompt "No one wins. Goodbye."
end