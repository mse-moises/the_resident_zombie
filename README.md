# The residente zombie

This is a project made by Moises Alonso Prestes for the Codeminer's coding test.

## About
This project use Clean Architeture principles and a Test-Driven Development approach.
For the development, it was identifies three principals actors: **users**, **items** and **location**.A
The entire project was designed around these three.

## Features

### Users

The user is the most important actor of the project, is his feature that has most of the usecases of all project.

#### Entities

##### UserEntity

The entitie that represent the users of the system.

#### Usecases

##### Create User
Responsable for the registration of the new survivor.
If the registration is succefull, it saves it, using the user info in the cache.

#### Get Local User
It is responsable for get the local infos of the saved user in the cache and update it with the api infos about that user.

##### SaveContactUsecase 
Is responsable for save in cache an String correspondent to a id, if thers other id's already it separetes by a ';' character.

##### Get User By Id UseCase 
Is responsable for get the UserEntity from the api that corresponds to a provide id.

##### Get All Contacts Usecase
Get saved ids and request, using the 'Get User By Id UseCase' use case, the User Entity correspondent to them.

##### Trade With User UseCase 
Proccess and request the trade items request between users.

##### Flag user as infected
Report to the api that determinated id is infected

##### Update user location
Responsable to report the current user's location 

### Items

#### Entities

##### ItemEntity

The entitie that represent the items of the system.

##### BackpackEntity

Is a collecion of items.

#### Usecases

##### Compare back pack

Responsable for compare the backpack and return if they have the same value.

##### Return back pack from numbers

Return a backpack entity when given an array of ints that represents the quantity of it.

##### Get items type

Return a array of ItemsEntity that represent the possibles items

### Location

#### Entities

##### LocationEntity

he entitie that represent the geographic position of the user.

#### Usecases

##### Compare Location

Compares between two locations and return if it is near or not.

##### Get location from id

Gets the location of a user by the user id.

##### Get location

Gets the current location using the device GPS




