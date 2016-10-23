# About

Malaysia's ATM location scraper, written in Elixir and Phoenix. [WIP].

# Installation

1. Install [PhantomJS](http://phantomjs.org/download.html).

2. Create the database and run the migrations:

```
$ mix ecto.create
$ mix ecto.migrate
```

# Scraping ATM Locations

### Maybank

```
$ mix scrape.maybank branch
$ mix scrape.maybank offsite
```

### CIMB Bank

```
$ mix scrape.cimb
```

# TODOs
- Scrape Public Bank ATM locations
- Add routes
