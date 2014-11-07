##Sparkle Pony##
MySQL UI and Dashboards

### Why? ###
Build Dashboards quickly in minutes from the browser

Stores query history, share queries, profit!

### Installation ###
Fill in fields in config/dashdata.yml and config/query_database.yml

    $ bundle install
    $ rake db:migrate
    $ rake assets:precompile
    $ rails s
### Usage ####
Login using your mysql credentials.

### Query ###
![Image of query_view]
(readme_docs/query_view.png)

### Make Dashboards ###
![Image of db_create]
(readme_docs/db_create.png)

### View Dashboards ###
Doesn't require mysql credentials
![Image of db_view]
(readme_docs/db_view.png)
