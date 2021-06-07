# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]

* Rails version

Rails 5.2.3

* Configuration

rm Kittens_market/Gemfile.lock

$ gem uninstall rails
(=> 3. All versions)

$ gem uninstall railties
(=> 3. All versions => y, then Y)

$ cd Kittens_market

Kittens_market$ bundle install

Kittens_market$ rails -v
(=> Rails 5.2.3)

1. En ce qui concerne l'environnement de développement :

* Database creation

Kittens_market$ RUBYOPT='-W:no-deprecated -W:no-experimental' rails db:create

Kittens_market$ RUBYOPT='-W:no-deprecated -W:no-experimental' rails db:migrate

* Database initialization

Kittens_market$ RUBYOPT='-W:no-deprecated -W:no-experimental' rails db:seed

* How to run the test suite

Kittens_market$ RUBYOPT='-W:no-deprecated -W:no-experimental' rails console

... :001 > require 'bcrypt'
... :002 > ln = User.new(first_name: "LN", last_name: "Anonymous", description: "LN Anonymous/ln@yopmail.com - Tototo", email: "ln@yopmail.com", encrypted_password: BCrypt::Password.create("Tototo"))
... :003 > ln.save!(:validate => false)

Kittens_market$ RUBYOPT='-W:no-deprecated -W:no-experimental' rails server (=> http://localhost:3000 )

2. En ce qui concerne l'environnement de production :

Kittens_market$ heroku run rails db:migrate

* Deployment instructions

Kittens_market$ heroku ps:scale web=1

* Database initialization

Kittens_market$ heroku run rails db:seed

* How to run the test suite

Kittens_market$ heroku open (=> https://ln-thp-ln-test-kittens-market.herokuapp.com )

Kittens_market$ heroku run rails console

... :001 > require 'bcrypt'
... :002 > ln = User.create(first_name: "LN", last_name: "Anonymous", description: "LN Anonymous/ln@yopmail.com - Tototo", email: "ln@yopmail.com", encrypted_password: BCrypt::Password.create("Tototo"))

* Services (job queues, cache servers, search engines, etc.)

http://www.yopmail.com/

https://app.sendgrid.com/email_activity
