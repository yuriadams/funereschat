# Funeres Chat

A simple chat using Rails 5(ActionCable + ActiveJob)

## Dependencies

* Postgres
* Redis

## Setup

```shell
$ gem install bundler
$ cd $PROJECT_PATH
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

## Running
```shell
$ redis-server
$ bundle exec sidekiq --logfile log/sidekiq.log
$ rails server
```

## Tests

The app uses **RSpec** to run the automated tests. Run the following command:

```shell
$ cd $PROJECT_PATH && rspec
```
