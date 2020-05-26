# Tennis-Racquet-Store-CLI-App

## Objectives

1. Use Nokogiri to scrape a tennis racquet marketplace page
2. Use the scraped data to create CLI for user to pick from racquet brands
3. Allow user to see all available racqets by brand
4. Allow user to input selection to receieve a brief overview of selected racquet

## Overview

This project will scrape the Dicks Sporting Goods tennis racquets page. When the CLI begins, it will prompt the user to select a specific brand of racquet based on all available brands for them to view. After user selects brand, it will display a list of all available racquets for that brand, including the name, price and rating if one exists. If a user would like a brief overview on one of the racquets in the list, they can select the corrisponding number racquet. They also have the ability to return to all the racquets after an overview or return to all the brands or exit the CLI which displays goodbye message.

## Navigation

1. Type in ruby `bin/run.rb` to run the CLI
2. After deciding on a brand, make a selection by corrisponding number to print out available racquets for brand.
3. If all racquets for brand is out of stock, select another brand
4. Select a racquet by corrisponding number to read brief overview or type `back` to select another brand.
5. To quit, return to brand list and enter `exit` to quit.

