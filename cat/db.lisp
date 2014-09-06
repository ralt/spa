(in-package #:spa)

(postmodern:defprepared-with-names cat/get-name-by-id (id)
  ("SELECT name FROM cat WHERE id = $1" id) :single)

(postmodern:defprepared-with-names cat/create (name)
  ("INSERT INTO cat (name) VALUES ($1) RETURNING id" name) :single)

(postmodern:defprepared cat/get-all-names
    "SELECT name FROM cat")
