# RPSLS winner_service

## Overview

The `winner_service` handles much of the "Rock Paper Scissors Lizard Spock"
game logic and data. It keeps track of the valid choices, checks if a choice is
valid, and resolves a winner per the "Rock Paper Scissors Lizard Spock" game
rules. All of this runs on an individual micro-service server, with the
following API endpoints.

## Setup

### Installation

Ruby Version: 2.6.3

You may want to use the [RVM Ruby Version Manager](https://rvm.io/rvm/install)
to install Ruby version 2.6.3.

- First, install bundler if you don't already have it:

```
gem install bundler
```

- Install Sinatra Dependencies:

If accessing a remote server instead of `localhost`, make sure port 4568 is open
to outside traffic as this service uses port 4568 by default.

When using rvm (Ruby Version Manager), you may need to use `rvmsudo` instead of
`sudo` when running `bundle install`.

```
bundle install
```

- Start Sinatra App

```
bundle exec ruby app.rb
```

## API

### `GET: /choices`

Returns an array of possible choice objects, their names, and id's.

Example JSON Response body:

```
[
  {
    "choice": {
      "id": 1,
      "name": "rock"
    }
  },
  {
    "choice": {
      "id": 2,
      "name": "paper"
    }
  },
  {
    "choice": {
      "id": 3,
      "name": "scissors"
    }
  },
  {
    "choice": {
      "id": 4,
      "name": "lizard"
    }
  },
  {
    "choice": {
      "id": 5,
      "name": "spock"
    }
  }
]
```

### `POST: /is_valid_choice`

Returns json with boolean value if the choice is valid. This helps prevent
attackers from sending unintented payloads.

Example JSON Response body:

```
{
  "is_valid": true
}
```

### `POST: /compute_winner`

Accepts JSON with two named players as keys, and their choice id as values.

Returns JSON array of an object for each player, with the status `win`, `lose`,
or `tie` for each player.

Example POST body:

```
{
  "player": choice_id[integer],
  "computer": choice_id[integer]
}
```

Example JSON Response body:

```
[
  {
    "choice": "spock",
    "choice_id": 5,
    "name": "player",
    "result": "lose"
  },
  {
    "choice": "lizard",
    "choice_id": 4,
    "name": "computer",
    "result": "win"
  }
]
```

## ToDo

- Impliment a test suite for all endpoints and functions.
- Refactor code to be cleaner, better DRY implimentations, etc.
- Include type checking for request sent to the API, for security.

