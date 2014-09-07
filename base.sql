CREATE TABLE IF NOT EXISTS cat (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL,
       birthday date NOT NULL,
       presence boolean NOT NULL
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
