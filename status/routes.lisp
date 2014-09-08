(in-package #:spa)

(restas:define-route status/get-add ("status/add" :method :get)
  (spa.layout:main
   (list
    :title "Add a status"
    :body (spa.status:add))))

(restas:define-route status/post-add ("status/add" :method :post)
  (let* ((name (hunchentoot:post-parameter "name")))
    (db status/create name)
    (restas:redirect 'status/get-add)))
