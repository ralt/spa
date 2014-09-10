(in-package #:spa)

(postmodern:defprepared users/get-all-names
    "SELECT id, name FROM users" :plists)

(postmodern:defprepared-with-names users/create (name pass)
  ("INSERT INTO users (name, pass) VALUES ($1, $2) RETURNING id" name pass) :single)

(postmodern:defprepared-with-names users/get-by-name (name)
  ("SELECT id, pass FROM users WHERE name = $1" name) :plist)
