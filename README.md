pinboard-cli
============

[Pinboard](https://pinboard.in/) on your command line.

## Usage

I had not time to package this as a GEM and I did not even release my version of the [pinboard ruby lib](https://github.com/badboy/pinboard) yet. But `pinboard-cli` is usable if you place the lib somewhere and adjust the paths in the script.

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

