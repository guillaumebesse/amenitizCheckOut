# README

## Description

The main part of the application logic is in ```models```  directory.

We add to this assignment another goal: to be able to explain the user how special offers applying to the products in the shopping cart.

This is a simple Rails application do not use database to store models data. All persistent data functions in centralized in product_service.rb file.


## Requirements
- Ruby 3.2.1


## Installation

- Checkout the repository
- Install the gems


    bundle install

- Compile css


    rails tailwindcss:build


## Start the server

    rails server

## Launch tests
All Tests are in test/models. To run them, use the following command:
    
    rails test
