# MakersBnB
bundle install

SET_UP DATABASES

1) CREATE database makersbnb;
2) connect and use migrations files to create user, rooms and rented_rooms table
3) CREATE database makersbnb_test
4) repeat table creation above

MakersBnB specification

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

Headline specifications

Any signed-up user can list a new space.
Users can list multiple spaces.
Users should be able to name their space, provide a short description of the space, and a price per night.
Users should be able to offer a range of dates where their space is available.
Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
Nights for which a space has already been booked should not be available for users to book that space.
Until a user has confirmed a booking request, that space can still be booked for that night.
Nice-to-haves

Users should receive an email whenever one of the following happens:
They sign up
They create a space
They update a space
A user requests to book their space
They confirm a request
They request to book a space
Their request to book a space is confirmed
Their request to book a space is denied
Users should receive a text message to a provided number whenever one of the following happens:
A user requests to book their space
Their request to book a space is confirmed
Their request to book a space is denied
A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
Basic payment implementation though Stripe.
Mockups

Mockups for MakersBnB are available here.


USER STORIES (9)

As a user
So that I can use the site easily and securely
I'd like to be able to sign up to the site

As a customer
So that I can find somewhere to stay
I'd like to request to hire a space.

As a user booking a space
so that I can't book a space which is already booked
I'd like to only see spaces which aren't booked

As a user
So that I can rent my space
I'd like to be able to list a new space

As a user
So that I can rent all my property
I'd like to list multiple spaces

As a USER
So that people know what the space is like
I'd like to provide a description and price

As a user
So people can see when spaces are available
I'd like to offer a range of dates where my space is available

As a space owning user
So that I can control who stays in my room
I'd like to approve customers' requests for rooms

As a user who's posting a space
So that I can choose who's staying in my room
I'd like to still get bookings even if I have a pending request
