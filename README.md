# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby/Rails version
  Using ruby 3.2.2 and rails 7.1.5.1
* Database Connection
  * I have used system user to connect to postgres, so username/password is not enabled for development/test
* Using rspec to run unit test

Setup local database
* Seed
  Run `rails db:seed` to seed default users with wallet (balance as ZERO)
* Run rails application by using `rails s`, and you can start accessing the API's
* Pass HTTP_AUTHORIZATION value as `YYYY-MM-DD`
* Check the routes by visiting the url `/rails/info/routes`
* Test transactions like deposit/withdraw for the seeded users
