# The residente zombie

This is a project made by Moises Alonso Prestes for the Codeminer's coding test.

## About
This project uses Clean Architecture principles and a Test-Driven Development approach.
For the development, it was identifies three principals actors: **users**, **items** and **location**.A
The entire project was designed around these three.

## Features

### Users

The user is the most important actor of the project, it is his feature that has most of the usecases of all project.

#### Entities

##### UserEntity

The entity that represent the users of the system.

#### Usecases

##### Create User
Responsible for the registration of the new survivor.
If the registration is successful, it saves it, using the user info in the cache.

#### Get Local User
It is responsible for get the local infos of the saved user in the cache and update it with the api infos about that user.

##### SaveContactUsecase 
Is responsible for save in cache an String correspondent to a id, if thers other id's already it separates by a ';' character.

##### Get User By Id UseCase 
Is responsible for get the UserEntity from the api that corresponds to a provide id.

##### Get All Contacts Usecase
Get saved ids and request, using the 'Get User By Id UseCase' use case, the User Entity correspondent to them.

##### Trade With User UseCase 
Process and request the trade items request between users.

##### Flag user as infected
Report to the api that determinated id is infected

##### Update user location
Responsible to report the current user's location 

### Items

#### Entities

##### ItemEntity

The entity that represents the items of the system.

##### BackpackEntity

Is a collection of items.

#### Usecases

##### Compare back pack

Responsable for comparing the backpack and return if they have the same value.

##### Return back pack from numbers

Return a backpack entity when given an array of ints that represents the quantity of it.

##### Get items type

Return a array of ItemsEntity that represent the possibles items

### Location

#### Entities

##### LocationEntity

The entity that represents the geographic position of the user.

#### Usecases

##### Compare Location

Compare between two locations and return if it is near or not.

##### Get location from id

Gets the location of a user by the user id.

##### Get location

Gets the current location using the device GPS

## Test

The project was made by using TDD principles, most of the things that have logic have a unit test for it (usecases, blocs, repositories, datasources, etc). There's some exceptions, like the methods inside the views.

## Commits

The commits were made following the conventional commits principles.

## Save contacts

To save other people contact you have to read the QRCode that they show you in their app.

## Something is missing?

The user, by app, can't manage how many items they have. While this isn't implemented in the next version, they should look in their physical bag and count it manually.


