# Arnold Clark Technical Test #

## Preface ##

Arnold Clark's coding challenge done by Csaba Nagy (@icnagy).

## The task ##

The task is to write a small utility site that will get a vehicle’s registration plate and stock reference from the user
and then display all the images available for a vehicle.

## Expectations ##

* A website written using Ruby on Rails
* Test Driven Development
* No bugs
* A good user experience
* Clean code and good engineering practices throughout

## Initial thougths ##

The task is to create a site where by entering registration numnber and a reference number we would get back the images
from the cache for the car represented by the registration and reference number.
To accomplish this, we do not need to store any kind of data, the site will be a kind of "through-and-through" site,
where the user enters two ids and gets back the result from a different server.

USER <==> RAILS APP <==> [http://vcache.arnoldclark.com/imageserver]

The user should see a form with two inputs, registration and stock reference number. After sanitizing the user input,
using JQuery the server respond will populate the image area.

### Stock reference number ###

According to the documentation `stock-ref = "ARNFC-U-7276"`.

* Stock reference number is at least 9 characters long (the 9th character has to be used to create the obfuscated stock
reference number)
* Might have dashes
* Has numbers and letters
* Letters are uppercase

### Registration number ###

According to documentation `registration = “YT61BXJ"`.

* 7 character long
* Numbers and letters
* Uppercase letters

### RAILS APP ###

The Rails application should take the user input and show the user the photos of corresponding car.

### Image cache ###

The image cache takes an obfuscated stock reference number, a resolution/size and a camera id as parameter and returns
an image.
* A car can have 12 pictures. Usually it's less than that.
* Recently added cars usually don't have any images at all
* If an image is not available, a default image is sent back.

### Obfuscated stock reference ###

`The obfuscated stock reference is calculated by interleaving the stock reference with the reversal of the registration
plate and appending the 9th character of the stock reference and taking the shortest possible solution (i.e. ignore any
unused characters from the stock reference)`

## First steps ##

### Figure out obfuscated stock reference ###

Quick typing in irb yields the first approach:

`reference.chars.take(registration.length).zip(registration.reverse.chars).flatten.compact.join << reference.chars[8]`

or without compact

`reference.chars.take(registration.length).zip(registration.reverse.chars).flatten.join << reference.chars[8]`

Take the first 7 characters of stock reference, interleave it with the revers of the registartion, flatten the array of
two's, then join the array to a string, and add the 9th character of the reference number.

### Rails new ###

As presumed earlier, the Rails app does not need any database to store information. So I create a new Rails app without
ActiveRecord:

`rails new arnoldc -O`

I have ruby 2.2.0 and Rails 4.2.0 installed, so I will just use that. I use RVM, so I just let it install the .rvmrc,
.ruby-version and .version.conf files:

`
	$ rvm --rvmrc 2.2.0@arnoldc
	$ rvm --create --ruby-version use 2.2.0@arnoldc
	$ rvm --create --versions-conf use 2.2.0@arnoldc
`

### Git ###

Time to initialize git:

`git init`

I use IntelliJ's RubyMine for IDE so I update the .gitignore file.