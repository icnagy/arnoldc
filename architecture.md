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

config.action_controller.perform_caching = true