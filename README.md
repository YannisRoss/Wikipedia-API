
# Contents  


- [Installation](#install)  
- [Running the project](#running)


<a name="install"/>

## Installation

Make sure you have Redis installed, as it is needed for Sidekiq to live-update stats.

To install Redis:
```
sudo apt install redis-server
```

Once you do that, clone the repo, cd into its directory and run:
```
bundle install
yarn install
```
to install the necessary gems and dependencies. 

To run the necessary migrations, run 
```
rails db:migrate
```

To launch the site, open a terminal window and run:
```
rails s
```
The terminal window should show the URL your server is listening on, which by default would be http://127.0.0.1:3000/. Visit it to see the project.


<a name="running"/>

## The welcome page

To use the project, create an account on the top right. Authentication is handled by the Devise gem.

Once you create an account, you should be able to view all the data on the main page.
By typing in a search term in the form on the top left, you
can import Wikipedia articles that correspond to it.

The project consumes Wikipedia's API data through the script located
in the /lib directory.
