# Workshops application

Modified and fixed application with passed tests for **Netguru workshops**. It's also available on [heroku](http://workshops-0920.herokuapp.com/).

### Setup

**Database**

Copy the database config file (and edit if needed):
` cp config/database.yml.sample config/database.yml`

Make sure the user you've listed in `database.yml` is created for postgres:
`createuser -s -r workshops`

Setup the database for your application (development and test environments):
`bin/rake db:setup`
`bin/rake db:test:prepare`

(taken from [here](https://github.com/netguru-training/workshops))
