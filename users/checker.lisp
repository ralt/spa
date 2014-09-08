(in-package #:spa)

(defun check-login ()
  (unless (hunchentoot:session-value :userid)
    (restas:redirect 'users/get-login)))

(defun check-logout ()
  (when (hunchentoot:session-value :userid)
    (restas:redirect 'cat)))
