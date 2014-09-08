(in-package #:spa)

(defun formatted-date (params end value)
  (declare (ignore params))
  (declare (ignore end))
  (let ((timestamp (local-time:universal-to-timestamp value)))
    (format nil
            "~a/~a/~a"
            (local-time:timestamp-day timestamp)
            (local-time:timestamp-month timestamp)
            (local-time:timestamp-year timestamp))))

(closure-template:define-print-syntax formatted-date "date" (:constant t))
(closure-template:register-print-handler :common-lisp-backend 'formatted-date :function #'formatted-date)

