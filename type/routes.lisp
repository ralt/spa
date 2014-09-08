(in-package #:spa)

(restas:define-route type/get-add ("type/add" :method :get)
  (check-login)
  (spa.layout:main
   (list
    :title "Add a type"
    :body (spa.type:add))))

(restas:define-route type/post-add ("type/add" :method :post)
  (check-login)
  (let* ((name (hunchentoot:post-parameter "name")))
    (db type/create name)
    (restas:redirect 'type/get-add)))
