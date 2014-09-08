(in-package #:spa)

(postmodern:defprepared-with-names history/create (catid
                                                   typeid
                                                   userid
                                                   comment
                                                   time)
  ("
INSERT INTO history (cat, type, users, comment, time)
VALUES ($1, $2, $3, $4, $5)
" catid typeid userid comment time) :none)

(postmodern:defprepared-with-names history/get-all-by-cat-id (id)
  ("
SELECT t.name as type, h.time as date, h.comment as comment, u.name as author
FROM history h
LEFT JOIN type t ON h.type = t.id
LEFT JOIN users u ON h.users = u.id
WHERE h.cat = $1
" id) :plists)
