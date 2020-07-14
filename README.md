## Oystercard

### Specifications

In order to know where I have been
As a customer
I want to see all my previous trips



 Write up a plan for how you will interact with your code and manually test in IRB.

 Store the list of journeys as an instance variable and expose it with an attribute reader - you will need to refactor the touch_out method to accept an exit station

 Use a hash to store one journey (set of an entry and exit stations)

 Write a test that checks that the card has an empty list of journeys by default

 Write a test that checks that touching in and out creates one journey
 Keep all code including tests DRY

 journey = entry_station, exit_station -> hash key entry => entry_station, exit => exit_station
