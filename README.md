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

* How to run the test suite (and linting via rubocop)

```sh
$ ./bin/rails default
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
* [x] error cases
* [ ] checking input format
* [ ] refactoring?
* [ ] stubbing test calls to postcodes.io? 
  - [x] unit tests
  - [ ] acceptance tests
* [ ] deploy to heroku?
* [ ] ajax request?
