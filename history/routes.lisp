(in-package #:spa)

(restas:define-route history/post-add ("history/add/:catid" :method :post)
  (check-login)
  (let* ((type (hunchentoot:post-parameter "type"))
         (comment (hunchentoot:post-parameter "comment"))
         (userid (hunchentoot:session-value :userid))
         (date (hunchentoot:post-parameter "date"))
         (time (hunchentoot:post-parameter "time"))
         (timestamp (format nil "~a ~a" date time)))
    (db history/create catid type userid comment timestamp)
    (restas:redirect 'cat/get-one :id catid)))

(restas:define-route history/get-edit ("history/:id/edit" :method :get)
  (let ((history (db history/get-one id)))
    (spa.layout:main
     (list
      :title "Edit history"
      :body (spa.history:add
             (list
              :action (concat "/history/" id "/edit")
              :types (spa.type:select
                      (list
                       :types (db type/get-all '((getf history :id)))))
              :catname (getf history :catname)
              :catid (getf history :catid)
              :comment (getf history :comment)
              :date (getf history :date)
              :time (getf history :time)))))))
