pinboard-cli
============

[Pinboard](https://pinboard.in/) on your command line.

## Usage

I had not time to package this as a GEM and it currently only works with my own fork of the pinboard ruby lib.
It's available in the [more-methods branch.](https://github.com/badboy/pinboard/tree/more-methods).

I'm working with @ryw, the original maintainer to get my code upstream. I hope we get a new gem version released soon.
Once that's done this will be a Gem too.

But `pinboard-cli` is usable if you place the lib somewhere and adjust the paths in the script.

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

