CREATE TABLE IF NOT EXISTS cinemas (
    id              serial  PRIMARY KEY,
    cinema_site_id  integer REFERENCES cinema_sites (id),
    cinema_self_id  varchar(50)  UNIQUE,
    name            varchar(255) UNIQUE NOT NULL,
    address         varchar(255) NOT NULL,
    phone           varchar(10)  NOT NULL,
    website         varchar(255) NOT NULL,
);
