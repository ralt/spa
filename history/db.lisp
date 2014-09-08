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
    (when (not (car type-filters))
      (setf filters ""))
    (postmodern:query (concat "
SELECT t.name as type, h.time as date, h.comment as comment, u.name as author
FROM history h
LEFT JOIN type t ON h.type = t.id
LEFT JOIN users u ON h.users = u.id
WHERE h.cat = $1
" filters "
ORDER BY time DESC
") id :plists)))

(postmodern:defprepared-with-names history/get-one (id)
  ("
SELECT c.name as catname, c.id as catid, h.time, h.comment
FROM history h
LEFT JOIN cat c ON h.cat = c.id
WHERE h.id = $1
" id) :plist)
