# Amazon ASIN Product Finder

## Overview
A full-stack application build on rails that scrapes Amazon pages using an ASIN number and saves the relevant information to a database.

## To Run Locally
1. Ensure you have ruby 2.4 or higher installed on your machine and postgresql
2. Ensure you have chromedriver installed locally (if you are using brew, use the command `brew cask install chromedriver`)
3. Clone this repo to your machine
4. Install bundler 2.0.1
5. run `bundle install` via command line
6. Create the required database on postgres
7. run `rails s` via command line
8. visit `http://localhost:3000/products`
9. Uses ProxyCrawler for handling scraping on remote servers deployments(ElasticbeanStalk/Heroku). Visit https://proxycrawl.com/ for more details on how to setup.


## Development Considerations
* Utilizes Selenium Webdriver gem to overcome the delayed loading amazon page
* Nokogiri is used for parsing page contents, custom script build for scraping specefic attributes from page using xpath and css

