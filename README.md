# billups_rpsls_winner_service

## Overview

## Setup

### Ruby Version: 2.6.4

You may want to ues the [RVM Ruby Version Manager](https://rvm.io/rvm/install)

to install Ruby version 2.6.3.

### Installation

First, install bundler, if you haven’t:

```
gem install bundler
```

Install Sinatra and dependencies:

Note, when using rvm, you may need to ues `rvmsudo` instead of `sudo`
when running `bundle install`.

```
bundle install
```

If installing on remote server, make sure port the default port, 4567 is open.
(winner_server will require port 4568 to be open by default).

## API

### `POST: /compute_winner`

Expects JSON with two named players as keys, and their choice id as values.

Returns JSON with the status `win`, `lose`, or `tie` for each player.

Example POST body:

```
{
  "player": choice_id[integer],
  "computer": choice_id[integer]
}
```

Example JSON Response body:

```
{
  "player": (win, loose, tie)[string],
  "computer": (win, loose, tie)[string]
}
```

### `GET: /choices`

Get all the choices that are usable for the frontend. Returns json array of
possible choices.

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
