CREATE TABLE IF NOT EXISTS movies (
    id              serial PRIMARY KEY;
    name            varchar(500) UNIQUE NOT NULL ,
    running_time    integer,
    poster_url      varchar(500),
);
