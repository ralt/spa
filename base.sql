CREATE TABLE cat (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL,
       birthday date NOT NULL,
       presence boolean NOT NULL
);

CREATE TABLE type (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE user (
       id serial PRIMARY KEY,
       name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE history (
       cat bigint references cat(id),
       type bigint references type(id),
       user bigint references user(id),
       comment text,
       time timestamp NOT NULL
);
