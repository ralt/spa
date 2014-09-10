(in-package #:spa)

(postmodern:defprepared users/get-all-names
    "SELECT id, name FROM users" :plists)

(postmodern:defprepared-with-names users/create (name)
  ("INSERT INTO users (name) VALUES ($1) RETURNING id" name) :single)

(postmodern:defprepared-with-names users/get-by-name (name)
  ("SELECT id, pass FROM users WHERE name = $1" name) :plist)
