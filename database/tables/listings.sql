CREATE TABLE IF NOT EXISTS listings (
    id serial PRIMARY KEY,
    movie_id integer REFERENCES movies(id),
    cinema_id integer REFERENCES cinemas(id),
    listing_date date NOT NULL,
    listing_time time NOT NULL,
);
