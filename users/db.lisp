(in-package #:spa)

(postmodern:defprepared users/get-all-names
    "SELECT id, name FROM users" :plists)

(postmodern:defprepared-with-names users/create (name)
  ("INSERT INTO users (name) VALUES ($1) RETURNING id" name) :single)
