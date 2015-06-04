# Architectural Decisions #

## TL;DR ##

Based on http://product.reverb.com/2015/05/09/documenting-architecture-decisions-the-reverb-way
This file contains the architectural/software-design decisions made along the development process.

## Day 1 ##

Tools:

* rubocop to enforce coding standards
* overcommit to run them before commit

Quick and dirty solution:

Without activerecord, scaffold a controller, so I can use form_for quickly in a view.
In the controller use a PORO to represent the obfuscation and candidate images.

## Day 2 ##

Add RSpec for testing.
Create tests for the Image PORO class, which represents the reference number and registration number transformation as
well as generating the candidate images

## Day 3 ##

### Part 1 ###

All working well, but: why do we reproduce the obfuscated stock reference and the candidate images for each request?
They could be cached, but thinking further, the whole response could be cached.

Several options to consider:
1. Current implementation uses UJS to render the results. We could cache the response.
2. Rewrite the controller to use SEO friendly urls like: http://example.com/registration/RK56YTD/reference/ARNFC-U-7276
 that can be cached

As of now I go with option 1.

### Part 2 ###

While testing caching I realized that the reference number is not really used by the vcache server. It only uses the
registration number from the obfuscated reference number.

Anyway, I was not really happy with the images controller design, so I changed it a bit:

* left only the index action in place
* changed strong parameter validation to handle two cases: js and html
* added a new option to the parameter whitelisting
* mapped a new route ':registration/:reference' to images#index action
* added window.history.pushStat to the ajax response, so the urlbar gets updated on everey search

## Day 4 ##

Addign layout and design.