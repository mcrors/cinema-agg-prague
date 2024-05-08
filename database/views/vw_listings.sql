DROP VIEW IF EXISTS vw_listings;

CREATE VIEW vw_listings AS
    SELECT
        cs.name         AS cinema_site_name,
        c.name          AS cinema_name,
        c.address       AS cinema_address,
        c.phone         AS cinema_phone,
        c.website       AS cinema_website,
        m.name          AS movie_name,
        m.running_time  AS movie_running_time,
        m.poster_url    AS movie_poster_url,
        m.imdb_link     AS movie_imdb_link,
        m.attributes    AS movie_attributes,
        l.listing_date  AS listing_date,
        l.listing_time  AS listing_time
    FROM listings l
    INNER JOIN movies m
        on l.movie_id = m.id
    INNER JOIN cinemas c
        on l.cinema_id = c.id
    INNER JOIN cinema_sites cs
        on c.cinema_site_id = cs.id;

