(in-package #:spa)

(restas:define-route cat ("cat")
  (check-login)
  (let ((cats (db cat/get-all)))
    (spa.layout:cat
     (list
      :title "All cats"
      :cats cats
      :body ""))))

(restas:define-route cat/goto ("cat/goto")
  (check-login)
  (let ((id (hunchentoot:get-parameter "id")))
    (restas:redirect 'cat/get-one :id id)))

(restas:define-route cat/get-one ("cat/:id")
  (check-login)
  (let* ((id (parse-integer id :junk-allowed t))
         (cat (db cat/get-by-id id)))
    (spa.layout:cat
     (list
      :title (getf cat :name)
      :cats (db cat/get-all)
      :body (spa.cat:view
             (list
              :cat cat
              :types (db type/get-all)
              :histories (db cat/get-histories-by-cat-id id)))))))

(restas:define-route cat/get-add ("cat/add" :method :get)
  (check-login)
  (spa.layout:main
   (list
    :title "Add a cat"
    :body (spa.cat:add
           (list
            :status (spa.status:select
                     (list
                      :statuses (db status/get-all))))))))

(restas:define-route cat/post-add ("cat/add" :method :post)
  (check-login)
  (let* ((name (hunchentoot:post-parameter "name"))
         (birthdate (hunchentoot:post-parameter "birthday"))
         (presence (hunchentoot:post-parameter "presence"))
         (id (db cat/create
                 name
                 birthdate
                 presence)))
    (restas:redirect 'cat/get-one :id id)))
