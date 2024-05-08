## Database

### TODO
* Update bootstrap.sql and bootstrap.sh files to create all usernames and passwords
* Complete the sql scripts for creating the reader, scraper and cinema_admin roles
* Ensure the sql scripts are idempotent
* Create the posgres database for local use using the docker-compose file
    * The default user, password and database are postgres
* Create a Makefile target to spin up a docker-compose database and bootstrap the database

### Tables

#### cinema_sites
|-------------------|-----------|-------------------------------------------------------------------------------------------------------|
| Colume Name       | Data Type | Description                                                                                           |
|-------------------|-----------|-------------------------------------------------------------------------------------------------------|
| id                | int       | Primary Key. Created by system                                                                        |
| name              | varchar   | Generic name of the site. Some sites are for multiple cinema's                                        |
| listings_endpoint | varchar   | The url where movie data can be scraped from                                                          |
| endpoint_format   | varchar   | The format that the movie endpoint is in, e.g. does it take a date parameter or a cinema id parameter |
|-------------------|-----------|-------------------------------------------------------------------------------------------------------|

#### cinemas
|----------------|-----------|----------------------------------------------------------------------------------|
| Colume Name    | Data Type | Description                                                                      |
|----------------|-----------|----------------------------------------------------------------------------------|
| id             | int       | Primary Key. Created by system                                                   |
| cinema_site_id | int       | FK, the primary key of the cinema_site table                                     |
| cinema_self_id | varchar   | If the cinema has it's own id that is required to construct the correct endpoint |
| name           | varchar   | Generic name of the cinema.                                                      |
| address        | varchar   | address of the cinema                                                            |
| phone          | varchar   | phone number of the cinema                                                       |
| website        | varchar   | website of the cinema                                                            |
|----------------|-----------|----------------------------------------------------------------------------------|

#### movies
|--------------|-----------|------------------------------------|
| Colume Name  | Data Type | Description                        |
|--------------|-----------|------------------------------------|
| id           | int       | Primary Key. Created by system     |
| name         | varchar   | The name of the movie              |
| running time | int       | The lenght of the movie in minutes |
| poster_url   | varchar   | The url of the movie               |
| imdb_link    | varchar   | The url of the movie on imdb       |
| attributes   | array     | additional attributes of the movie |
|--------------|-----------|------------------------------------|

#### listings
|--------------|-----------|-----------------------------------|
| Colume Name  | Data Type | Description                       |
|--------------|-----------|-----------------------------------|
| id           | int       | Primary Key. Created by system    |
| movie_id     | int       | FK, the primary key of the movie  |
| cinema_id    | int       | FK, the primary key of the cinema |
| listing_date | date      | The date for the listing          |
| listing_time | time      | The time for the listing          |
|--------------|-----------|-----------------------------------|

### Views

#### vw_listings
|--------------------|-----------|----------------------------------------------|
| Colume Name        | Data Type | Description                                  |
|--------------------|-----------|----------------------------------------------|
| cinema_site_name   | varchar   | The name of the cinema site e.g. Cinema City |
| cinema_name        | varchar   | The name of the cinema e.g. Slovansky Dum    |
| cinema_address     | varchar   |                                              |
| cinema_phone       | varchar   |                                              |
| cinema_website     | varchar   |                                              |
| movie_name         | varchar   |                                              |
| movie_running_time | int       |                                              |
| movie_poster_url   | varchar   |                                              |
| movie_imdb_link    | varchar   |                                              |
| attributes         | array     |                                              |
| listing_date       | date      |                                              |
| listing_time       | time      |                                              |
|--------------------|-----------|----------------------------------------------|

### Users/Roles

#### migration
* Can create and modify tables in the database.
* This will be assigned to the process that runs the ci/cd.

#### reader
* Can read from vw_listings.
* This will be assigned to the process that runs the backend.

#### scraper
* Can insert, update and delete for movies and listings tables.
* Can read from cinema and cinema_sites
* This will be assigned to the process that runs the scraper.

#### cinema_admin
* Can insert, update and delete for cinema and cinema_sites tables.
* This will be assigned to the process that runs the admin console server

