# Overview

The frontend will be an angular based Single Page Application(SPA).

Users will be given the option to search by:
* Cinema
* Movie
* Date & time

* Each selection will be represented by a checkbox form input.
* When each one is selected or delected a new part of the form display or not.
* The Dropdown lists should also be typable
* When you hoover/click on the cinema name you get the info for the cinema. Or a modal or a side bar.
* Once the search results are displayed, the search forms should be hideable and recoverable.


|-----------------------------------------------------------------------------------|
|                                                                                   |
|                                                                                   |
|       |-- Search By --------------------------------------------------|           |
|       |                                                               |           |
|       |  Select at least one                                          |           |
|       |   [] Cinema                                                   |           |
|       |   [] Movie                                                    |           |
|       |   [] Date & time                                              |           |
|       |---------------------------------------------------------------|           |
|                                                                                   |
|       |-- Cinemas ----------------------------------------------------|           |
|       |                                                               |           |
|       |   |-- Drop Down List -----------------|                       |           |
|       |   | Prefiled list of Cinemas          |                       |           |
|       |   |-----------------------------------|                       |           |
|       |---------------------------------------------------------------|           |
|                                                                                   |
|       |-- Movies -----------------------------------------------------|           |
|       |                                                               |           |
|       |   |-- Drop Down List -----------------|                       |           |
|       |   | Prefiled list of Movies           |                       |           |
|       |   |-----------------------------------|                       |           |
|       |---------------------------------------------------------------|           |
|                                                                                   |
|       |-- Dates & Times ----------------------------------------------|           |
|       |                                                               |           |
|       |   |-- Date Picker ----|     |-- Time Picker ----|             |           |
|       |   |                   |     |                   |             |           |
|       |   |-------------------|     |-------------------|             |           |
|       |---------------------------------------------------------------|           |
|                                                                                   |
|  ------------------------------------------------------------------------------   |
|                                                                                   |
|       | -- Film Card -------------------------------------------------|           |
|       |                                                               |           |
|       |   |-- Film Poster ----|       |-- Film Info --------------|   |           |
|       |   |                   |       |   Film Name               |   |           |
|       |   |                   |       |   Cinema Name             |   |           |
|       |   |                   |       |   Date & Time             |   |           |
|       |   |                   |       |   Running Time            |   |           |
|       |   |                   |       |   imdb link               |   |           |
|       |   |-------------------|       |---------------------------|   |           |
|       |---------------------------------------------------------------|           |
|                                                                                   |
|       | -- Film Card -------------------------------------------------|           |
|       |                                                               |           |
|       |   |-- Film Poster ----|       |-- Film Info --------------|   |           |
|       |   |                   |       |   Film Name               |   |           |
|       |   |                   |       |   Cinema Name             |   |           |
|       |   |                   |       |   Date & Time             |   |           |
|       |   |                   |       |   Running Time            |   |           |
|       |   |                   |       |   imdb link               |   |           |
|       |   |-------------------|       |---------------------------|   |           |
|       |---------------------------------------------------------------|           |
|                                                                                   |
|       ....                                                                        |
|-----------------------------------------------------------------------------------|

# Required API

## /movies
Description: This endpoint retrieves a list of all the movies currently in the database.
It is used to populate the Movies Drop Down List

HTTP Method: GET

## /cinemas
Description: This endpoint retrieves a list of all the cinemas currently in the database.
It is used to populate the Cinemas Drop Down List

HTTP Method: GET

## /listings
Description: This endpoint retrieves movie listings based on specified query parameters.

HTTP Method: GET

Query Parameters:

movie (optional)
    Type: integer
    Description: Filter listings to only include those that feature the specified movie. The ID of the movie is sent to the backend.

cinema (optional)
    Type: integer
    Description: Filter listings to only include those that occur at the specified cinema. The ID of the movie is sent to the backend.

date (required with fromTime and toTime)
    Type: string
    Format: YYYY-MM-DD
    Description: Specify the date for which to find movie listings. Must be provided if fromTime and toTime are specified.

fromTime (required with date and toTime)
    Type: string
    Format: HH:MM (24-hour format)
    Description: The start time to begin filtering listings. Must be provided if date and toTime are specified.

toTime (required with date and fromTime)
    Type: string
    Format: HH:MM (24-hour format)
    Description: The end time to stop filtering listings. Must be provided if date and fromTime are specified.

Parameter Combinations:

The parameters date, fromTime, and toTime should always be included together. If one is provided, the other two must also be provided.
The movie and cinema parameters can be used independently or in conjunction with each other and with the date, fromTime, and toTime group.

### Example Requests

1. Retrieve all listings for a specific movie:

```bash
GET /listings?movie=123
```

2. Retrieve all listings for a specific cinema:

```bash
GET /listings?cinema=123
```

3. Retrieve all listings for a specific date and time range:

```bash
GET /listings?date=2024-05-01&fromTime=12:00&toTime=16:00
```

4. Retrieve listings for a specific movie at a specific cinema during a specified date and time:

```bash
GET /listings?movie=123&cinema=123&date=2024-05-01&fromTime=14:00&toTime=18:00
```
