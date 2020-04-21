#!/bin/sh

# Set up the Rails app from nothing

bundle install
bin/rails yarn:install
bin/rails tmp:create
bin/rails log:clear
bin/rails db:create db:migrate db:seed
