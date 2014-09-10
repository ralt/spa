(in-package #:spa)

(defun check-login ()
  (unless (hunchentoot:session-value :userid)
    (restas:redirect 'users/get-login)))

(defun check-logout ()
  (when (hunchentoot:session-value :userid)
    (restas:redirect 'cat)))

(defun check-admin ()
  ; user 1 is admin, no question asked
  (when (not (= (hunchentoot:session-value :userid) 1))
    (restas:redirect 'cat)))
