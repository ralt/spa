(in-package #:spa)

(postmodern:defprepared-with-names cat/get-by-id (id)
  ("
SELECT name
FROM cat
WHERE id = $1
" id) :plist)

(postmodern:defprepared-with-names cat/create (name
                                               gender
                                               status
                                               birthday
                                               identification
                                               race
                                               color
                                               weight)
  ("
INSERT INTO cat (name, gender, status, birthday, identification, race, color, weight)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING id
" name gender status birthday identification race color weight) :single)

(postmodern:defprepared cat/get-all
    "SELECT id, name FROM cat" :plists)

(postmodern:defprepared-with-names cat/get-histories-by-cat-id (id)
  ("
SELECT t.name, h.time, h.comment, u.name
FROM history h
LEFT JOIN type t ON h.type = t.id
LEFT JOIN users u ON h.users = u.id
WHERE h.cat = $1
" id) :plists)
