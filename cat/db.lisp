(in-package #:spa)

(postmodern:defprepared-with-names cat/get-by-id (id)
  ("
SELECT c.id, c.name, c.gender, s.name as status, c.birthday, c.identification, c.race, c.color, c.weight
FROM cat c
LEFT JOIN status s ON s.id = c.status
WHERE c.id = $1
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
