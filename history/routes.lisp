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
  (check-login)
  (let* ((history (db history/get-one id))
         (timestamp (local-time:universal-to-timestamp (getf history :time))))
    (spa.layout:main
     (list
      :title "Edit history"
      :body (spa.history:add
             (list
              :title "Editer le suivi"
              :button "Sauver les changements"
              :action (concat "/history/" id "/edit")
              :types (spa.type:select
                      (list
                       :types (db type/get-all (list (write-to-string (getf history :id))))))
              :catname (getf history :catname)
              :catid (getf history :catid)
              :comment (getf history :comment)
              :date (format nil
                            "~2,'0d-~2,'0d-~2,'0d"
                            (local-time:timestamp-year timestamp)
                            (local-time:timestamp-month timestamp)
                            (local-time:timestamp-day timestamp))
              :time (format nil
                            "~2,'0d:~2,'0d:~2,'0d"
                            (local-time:timestamp-hour timestamp)
                            (local-time:timestamp-minute timestamp)
                            (local-time:timestamp-second timestamp))))))))

(restas:define-route history/post-edit ("history/:id/edit" :method :post)
  (let* ((type (hunchentoot:post-parameter "type"))
         (comment (hunchentoot:post-parameter "comment"))
         (date (hunchentoot:post-parameter "date"))
         (time (hunchentoot:post-parameter "time"))
         (timestamp (format nil "~a ~a" date time))
         (cat (db history/get-cat-by-history-id id)))
    (db history/update-one id type comment timestamp)
    (restas:redirect 'cat/get-one :id (getf cat :id))))
