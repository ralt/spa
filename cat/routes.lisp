(in-package #:spa)

(restas:define-route cat ("cat")
  (let ((cats (db cat/get-all-names)))
    (spa.layout:cat
     (list
      :title "All cats"
      :cats cats
      :body ""))))

(restas:define-route cat/get-one ("cat/:id")
  (let* ((id (parse-integer id :junk-allowed t))
         (name (db cat/get-name-by-id id))
         (cats (db cat/get-all-names)))
    (spa.layout:cat
     (list
      :title name
      :cats cats
      :body (spa.cat:view
             (list
              :title (concat "Cat " name)
              :name name))))))

(restas:define-route cat/get-add ("cat/add" :method :get)
  (spa.layout:main
   (list
    :title "Add a cat"
    :body (spa.cat:add))))

(restas:define-route cat/post-add ("cat/add" :method :post)
  (let* ((name (hunchentoot:post-parameter "name"))
         (birthdate (hunchentoot:post-parameter "birthday"))
         (presence (hunchentoot:post-parameter "presence"))
         (id (db cat/create name birthdate presence)))
    (restas:redirect 'cat/get-one :id id)))
