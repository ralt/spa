(in-package #:spa)

(restas:define-route cats ("cat")
  (let ((cats (db cat/get-all-names)))
    (spa.layout:cats
     (list
      :title "All cats"
      :cats cats
      :body (spa.cat:all
             (list
              :names cats))))))

(restas:define-route cat ("cat/:id")
  (let* ((id (parse-integer id :junk-allowed t))
         (name (db cat/get-name-by-id id)))
    (spa.layout:main
     (list
      :title name
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
         (id (db cat/create name)))
    (restas:redirect 'cat :id id)))
