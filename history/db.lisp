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

(defun history/get-all-by-cat-id (id type-filters)
  (let ((filters (format nil " AND ( ~{ t.id = ~a ~^OR ~} ) " type-filters)))
    (when (or (not (car type-filters))
              (string= (car type-filters) ""))
      (setf filters ""))
    (postmodern:query (concat "
SELECT h.id, t.name as type, h.time as date, h.comment as comment, u.name as author
FROM history h
LEFT JOIN type t ON h.type = t.id
LEFT JOIN users u ON h.users = u.id
WHERE h.cat = $1
" filters "
ORDER BY time DESC
") id :plists)))

(postmodern:defprepared-with-names history/get-one (id)
  ("
SELECT h.id as id, c.name as catname, c.id as catid, h.time, h.comment, h.type
FROM history h
LEFT JOIN cat c ON h.cat = c.id
WHERE h.id = $1
" id) :plist)

(postmodern:defprepared-with-names history/update-one (id
                                                       type
                                                       comment
                                                       time)
  ("
UPDATE history
SET
type = $1,
comment = $2,
time = $3
WHERE id = $4
" type comment time id) :none)

(postmodern:defprepared-with-names history/get-cat-by-history-id (id)
  ("
SELECT c.id, c.name
FROM cat c
LEFT JOIN history h on c.id = h.cat
WHERE h.id = $1
" id) :plist)

(postmodern:defprepared history/get-last-50
    "
SELECT h.type, h.time as date, h.comment, u.name as author
FROM history h
LEFT JOIN users u ON h.users = u.id
ORDER BY time DESC
LIMIT 50
" :plists)
