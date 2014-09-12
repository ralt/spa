(in-package #:spa)

(postmodern:defprepared-with-names cat/get-by-id (id)
  ("
SELECT c.id, c.name, c.gender, s.name as status, c.status as statusid, c.birthday, c.identification, c.race, c.color, c.weight, c.description
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
INSERT INTO cat (name, gender, status, birthday, identification, race, color, weight, description)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING id
" name gender status birthday identification race color weight) :single)

(postmodern:defprepared cat/get-all
    "SELECT id, name FROM cat" :plists)

(postmodern:defprepared-with-names cat/update (id
                                               name
                                               gender
                                               status
                                               birthday
                                               identification
                                               race
                                               color
                                               weight
                                               description)
  ("
UPDATE cat
SET
    name = $2,
    gender = $3,
    status = $4,
    birthday = $5,
    identification = $6,
    race = $7,
    color = $8,
    weight = $9,
    description = $10
WHERE id = $1
" id name gender status birthday identification race color weight description) :none)
