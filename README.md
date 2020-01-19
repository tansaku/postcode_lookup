# PostCode Lookup

PostCode lookup is a simple web application to work out if a given postcode is whitelisted given a list of LSOA (Lower Super Output Area - UK postal service area) areas and an additional postcode specific whitelist particular service area.

It is a single page app with a form where the input is a UK postcode. Submitting the form gives a response as to whether the postcode is whitelisted or not.

## Whitelisting rules

The system uses the Postcodes.io REST API as a data source. The service area is described by the following rules:

1. Postcodes are grouped into larger blocks called LSOAs. This is returned from the API when we query a postcode. By default we whitelist any postcode in an LSOA starting "Southwark" or "Lambeth". Example postcodes for these LSOAs are SE1 7QD and SE1 7QA respectively.  This is the "LSOA whitelist".
2. Some postcodes are unknown by the API or may be served despite being outside of the whitelisted LSOAs. We whitelist these anyway, even though the API does not recognise them. SH24 1AA and SH24 1AB are both examples of unknown postcodes that we serve.  This is the "Postcode whitelist".
3. Any postcode not in the LSOA whitelist or the Postcode whitelist is not servable.

## Requirements

The code is written and tested against:

* [Ruby](https://www.ruby-lang.org/) 2.6.5
* [Rails](https://rubyonrails.org/) 6.0.2

## Installation

1. Clone the repository

```sh
$ git clone https://github.co/tansaku/postcode_lookup
```

2. Move into directory and install dependencies

```sh
$ cd postcode_lookup
$ bundle
```

3. Start the server

```sh
$ bundle exec rails server
```

4. View the site:

http://localhost:3000

include an animated gif of the system in operation?



* System dependencies

Postcodes API provided by https://postcodes.io and ruby gem https://github.com/jamesruston/postcodes_io.  See Gemfile for other dependencies

* Configuration

none at present

* Database creation?

* Database initialization?

* Run the test suite (and linting via rubocop) by the following command

```sh
$ bundle exec ./bin/rails default
```

which should produce output like the following:

```
Running RuboCop...
Inspecting 17 files
.................

17 files inspected, no offenses detected
/Users/tansaku/.rvm/rubies/ruby-2.6.5/bin/ruby -I/Users/tansaku/.rvm/gems/ruby-2.6.5/gems/rspec-core-3.9.1/lib:/Users/tansaku/.rvm/gems/ruby-2.6.5/gems/rspec-support-3.9.2/lib /Users/tansaku/.rvm/gems/ruby-2.6.5/gems/rspec-core-3.9.1/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/\*_spec.rb

lookup postcode
  check a non whitelisted postcode
  check a Southwark postcode is whitelisted
  check a Lambeth postcode is whitelisted
  check an unknown postcode is whitelisted
  check an API unknown postcode is whitelisted when specified
  check an API unknown postcode is not whitelisted
  handle error from WhitelistChecker

WhitelistChecker
  Lambeth postcode
    is whitelisted
  Southwark postcode
    is whitelisted
  specifically whitelisted API unknown postcode
    is whitelisted, e.g. 'SH24 1AA'
    is whitelisted, e.g. 'SH24 1AB'
  Harrow postcode
    is not whitelisted
  API unknown postcodes that are not on the whitelist
    is not whitelisted
  Errors
    lsoa is empty string
      postcode is not whitelisted

Finished in 4.98 seconds (files took 7.6 seconds to load)
14 examples, 0 failures


COVERAGE: 100.00% -- 77/77 lines in 19 files
```

* Deployment instructions

To deploy to heroku web hosting (assuming [heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) is installed), ensure you are in the project directory and run the following commands:

```sh
$ heroku create postcode-checker
$ git push heroku master
```

The app can then be accessed on heroku, e.g. 

https://postcode-checker.herokuapp.com/

## TODO

* [ ] extract the actual whitelists
  - [ ] static files?
  - [ ] stick them in the database?
  - [ ] show the whitelists on the main page?
* [x] error cases
* [ ] checking input format
* [ ] refactoring?
* [x] test coverage
* [ ] stubbing test calls to postcodes.io? 
  - [x] unit tests
     - [ ] mockwreck issue? don't stub what you don't own?
  - [ ] acceptance tests
* [x] deploy to heroku
* [ ] Should the form use an ajax request?
