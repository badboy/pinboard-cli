pinboard-cli
============

[Pinboard](https://pinboard.in/) on your command line.

## Install

    gem install pinboard-cli

## Usage

Get your API key from <https://pinboard.in/settings/password> and place it in `~/.pinboard-token`.
Then just run the client:

    $ pinboard -h
    Usage: pinboard [options] [keywords...]

    Configuration:
      Put your Pinboard API key into ~/.pinboard-token
      You can find that key here: https://pinboard.in/settings/password

        -a, --all                        Search everything (href, description, extended, tags)
        -d, --description                Search only description (default)
        -e, --extended                   Search only extended
        -t, --tags                       Search only tags
        -o, --or                         OR keywords
        -u, --update                     Update if neccessary
        -n, --[no-]color                 Suppress color output

