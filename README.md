# CLI tools for getting info for MTG cards

## Architecture design

In this task I meet few major problems:

#### Project start, file structure, and initial setup

Firstly I thought about a simple ruby file with manual configuration. But after some investigation move to `bundler gem name`. This command automatically built the default gem structure with gem dependencies, rubocop, gemfile.  And add a potential possibility to distribute the app as a gem.

#### Getting data from MTG API

In API we have a lot of pages (500+) and loading them synchronously takes too much time. So parallel upload can make this process a few times faster.
Full data load from MTG API takes a lot of time, even in parallel mode. So I added a local cache. It is implemented in simple JSON files with simple protection on existence.

#### Returning data according to a user request

This part was designed with extension possibility. Type1 and Type2 return a huge amount of data. Perhaps I don't understand correctly and I need to return card names instead of full card data.
## Technical choices

As I was limited by ruby-standard-library I was forced to reimplement some staff (or use a simple standard version):
- manual threads with a queue (in a real app, I would use something like celluloid)
- manual cli interface (instead of dry-cli, thor, etc)
- ruby net-http (instead of parallel typhoeus)
- file-based cache (instead of database-like solution)

## Limitations
- parallel run not allowed
- some filesystem errors (like read-only fs, not space, etc) can cause crash
- cache directory hardcoded (to simplify manual cli parser)
- simple ruby-puts instead of logger
- url and json-prefix hardcoded

## Installation

```bash
# install ruby 2.6 by self
git clone git@github.com:lingokids/lk-coding-exercise-senior-backend-engineer-alexander-randa.git magicard
```

## Usage

```bash
$ bin/magicards help
CLI tools for getting info for MTG cards

Usage:
  bin/magicard load 1           load data from MTG-API to local. With maximum number of parallel downloads. The default is 1
  bin/magicard forceload 1      load data from MTG-API to local. With cache clean
  bin/magicard get type1        return a list of Cards grouped by `set`
  bin/magicard get type2        return a list of Cards grouped by `set` and within each `set` grouped by `rarity`
  bin/magicard get type3        return a list of cards from the `Khans of Tarkir` set that ONLY have the colours `red` AND `blue`
  bin/magicard -v/--version     print tool version
  bin/magicard -h/--help/help   print this help
```

## Development and testing

Installation:
```bash
gem install bundler
bundle install
```

Rubocop:
```bash
$ bundle exec rubocop
...
Inspecting 20 files
....................

20 files inspected, no offenses detected

```

Rspec:
```bash
$ bundle exec rspec
.........................

Finished in 0.04329 seconds (files took 0.66972 seconds to load)
25 examples, 0 failures

Coverage report generated for RSpec to /Users/ori/Work/mtg/coverage. 232 / 232 LOC (100.0%) covered.
```

---

# Backend coding exercise

For this coding exercise you will use the public API provided by https://magicthegathering.io to build a command line tool that can query and filter Magic The Gathering cards.

## The exercise

Using **only** the https://api.magicthegathering.io/v1/cards endpoint and **without using any query parameters for filtering**, create a command-line tool that:

* Returns a list of **Cards** grouped by **`set`**.
* Returns a list of **Cards** grouped by **`set`** and within each **`set`** grouped by **`rarity`**.
* Returns a list of cards from the  **Khans of Tarkir (KTK)** set that ONLY have the colours `red` **AND** `blue`

## Environment

* You can use any one of the following programming languages: Ruby, Elixir, JavaScript, Crystal, Python, Go.

## Limitations

* You are **not** allowed to use a third-party library that wraps the MTG API.
* You can only use the https://api.magicthegathering.io/v1/cards endpoint for fetching all the cards. You **can't use query parameters** to filter the cards.

## What we look for

* Organise your code with low coupling and high cohesion.
* Avoid unnecessary abstractions. Make it readable, not vague.
* Name things well. We know _naming things_ is one of the two hardest problems in programming, so try to not make your solution too cryptic or too clever.
* Adhere to your language/framework conventions. No need to get _too_ creative.
* Take a pragmatic approach to testing. Just make sure the basics are covered.
* Take your time. We set no time limit, so simply let us know roughly how much time you spent. By our estimate, it should take roughly 4 hours.

## Bonus points for...

* Adding a section to this README explaining how you approached the problem: initial analysis, technical choices, trade-offs, etc.
* Using only the programming language's standard library.
* **Parallelising** the retrieval of all the **Cards** to speed up things.
* Respecting the API's Rate Limiting facilities.


















# Magicard

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/magicard`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'magicard'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install magicard

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/magicard.
