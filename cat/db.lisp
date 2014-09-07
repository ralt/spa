(in-package #:spa)

(postmodern:defprepared-with-names cat/get-name-by-id (id)
  ("SELECT name FROM cat WHERE id = $1" id) :single)

(postmodern:defprepared-with-names cat/create (name birthday presence)
  ("
INSERT INTO cat (name, birthday, presence)
VALUES ($1, $2, $3)
RETURNING id
" name birthday presence) :single)

(postmodern:defprepared cat/get-all-names
    "SELECT id, name FROM cat" :plists)
