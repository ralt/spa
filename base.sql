CREATE TABLE IF NOT EXISTS status (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS cat (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL,
       birthday date,
       status bigint references status(id),
       identification varchar(255) UNIQUE,
       weight varchar(50),
       race varchar(255),
       color varchar(255),
       gender boolean
);

CREATE TABLE IF NOT EXISTS type (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS history (
       cat bigint references cat(id),
       type bigint references type(id),
       users bigint references users(id),
       comment text,
       time timestamp NOT NULL
);
