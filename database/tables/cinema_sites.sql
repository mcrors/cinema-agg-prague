CREATE TABLE IF NOT EXISTS cinema_sites (
    id              serial PRIMARY KEY,
    name            varchar(255) UNIQUE NOT NULL,
    endpoint        varchar(500) NOT NULL,
    endpoint_format varchar(500) NOT NULL,
);
