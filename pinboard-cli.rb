#!/usr/bin/env ruby
# encoding: utf-8

require 'time'
require 'yajl/json_gem'
require 'ostruct'

CACHE_FILE = File.expand_path("~/.pinboard-cache.json")
TOKEN_FILE = File.expand_path("~/.pinboard-token")

Color = OpenStruct.new
if $stdout.tty?
  COLORS = {
    clear:   "\033[0m",
    red:     "\033[31m",
    green:   "\033[32m",
    yellow:  "\033[33m",
    cyan:    "\033[36m",
    grey:    "\033[1;30m",
    purple:  "\033[35m"
  }
else
  COLORS = {}
end

def usage
  puts <<-EOF
usage: #{File.basename $0} [options] [keywords...]

  options:
  -a      Search everything (href, title, description, tags)
  -d      Search only description (default)
  -e      Search only extended
  -t      Search only tags
  -c      Search with OR, not AND (AND is default)
  -u      Fetch updates.
  EOF
  exit
end

def colorize color, word
  "#{COLORS[color]}#{word}#{COLORS[:clear]}"
end

def save_cache file, cache
  File.open(file, "w") { |f|
    f.write cache.to_json
  }
end

if ARGV.any?{|arg| arg == '-h' || arg == '--help' }
  usage
end

$:.unshift "/home/badboy/projects/pinboard/lib"
require_relative "../pinboard/lib/pinboard"

cached = JSON.parse(IO.read(CACHE_FILE)) rescue {}

token = IO.read(TOKEN_FILE).chomp

need_update = ARGV.any? {|arg| arg == '-u' } || cached.empty?

if need_update
  print "Checking for an update... "
  pin = Pinboard::Client.new token: token
  last_check = DateTime.parse(cached['time'] || "01.01.1970").to_time
  last_update = pin.update

  if last_update > last_check
    puts colorize(:red, 'Data outdated. Start with -u to update.')
    puts colorize(:green, 'Oh, you did. Updating now.')
    cached['time'] = last_update

    posts = pin.posts
    cached['posts'] = JSON.parse(posts.to_json)
  else
    puts colorize(:green, "not needed")
  end
  puts
end

save_cache(CACHE_FILE, cached)

$what_to_search = :description
$combined       = true

def all args, post, regex
  description(args, post, regex) ||
    extended(args, post, regex) ||
    post.href =~ regex
end

def description args, post, regex
  if $combined
    args.all? { |arg|
      post.description =~ /#{arg}/i
    }
  else
    post.description =~ regex
  end
end

def extended args, post, regex
  if $combined
    args.all? { |arg|
      post.extended =~ /#{arg}/i
    }
  else
    post.extended =~ regex
  end
end

def tag args, post, regex
  if $combined
    args.all? { |arg|
      post.tag.any? { |tag|
        tag =~ /#{arg}/
      }
    }
  else
    post.tag.any? { |tag|
      tag =~ regex
    }
  end
end

def build_regex args
  regex = ARGV.map { |arg| Regexp.escape arg }.join("|")
  regex = /#{regex}/i
end

while ARGV[0] && ARGV[0].start_with?("-")
  arg = ARGV.shift
  case arg
  when "-a"
    $what_to_search = :all
  when "-d"
    $what_to_search = :description
  when "-e"
    $what_to_search = :extended
  when "-t"
    $what_to_search = :tag
  when "-c"
    $combined = false
  end
end

unless ARGV.empty?
  regex = build_regex(ARGV)

  cached['posts'].each do |args|
    args = Pinboard::Util.symbolize_keys(args)
    args[:tag] = args[:tag].join(" ")
    post = Pinboard::Post.new args

    if send($what_to_search, ARGV, post, regex)
      puts "#{colorize :green, post.description}:\n\t#{post.href}"
    end
  end
end
