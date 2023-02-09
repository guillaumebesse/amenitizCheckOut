# README

## Description

The main part of the application logic is in ```models```  directory.

At the top level, we have 2 important models:
- CartItems
- CartCheckoutItems

CartItems is a collection of CartItem (a product and a quantity). This is the shopping cart without special offers.

The user add products to a cartItems. 

We transform a CartItems in CartCheckoutItems using SpecialOfferHandler.

We have 3 subtypes of SpecialOfferHandler: CoffeeSpecialOfferHandler, GreenTeaSpecialOffer and StrawberriesSpecialOffer.

What the user see is the cartCheckoutItems.
We can explain him how special offers applied to the differents products he bought.


This is Rails application do not use database to store models data. All persistent data functions are centralized in product_service.rb file.



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
