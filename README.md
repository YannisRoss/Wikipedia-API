# rails_wiki_project

## Getting started

Make sure you have Redis installed, as it is needed for Sidekiq to live-update stats.

To install Redis:
```
sudo apt install redis-server
```

Once you do that, clone the repo, cd into its directory and run:
```
bundle install
```
to install the necessary gems. 

To run the necessary migrations, run 
```
rails db:migrate
```

Once that's done, run:
```
bundle exec sidekiq start
```
and, on another terminal window, run:
```
rails s
```
The second terminal window should show the URL your server is listening on. Visit it to see the project.



