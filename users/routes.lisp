(in-package #:spa)

(restas:define-route users/get-login ("users/login" :method :get)
  (spa.layout:main
   (list
    :title "Login"
    :body (spa.users:login
           (list
            :users (db users/get-all-names))))))

(restas:define-route users/post-login ("users/login" :method :post)
  (let ((id (hunchentoot:post-parameter "users")))
    (hunchentoot:start-session)
    (setf (hunchentoot:session-value "userid") id)
    (restas:redirect 'cat)))

(restas:define-route users/get-add ("users/add" :method :get)
  (spa.layout:main
   (list
    :title "Add user"
    :body (spa.users:add))))

(restas:define-route users/post-add ("users/add" :method :post)
  (let ((name (hunchentoot:post-parameter "name")))
    (db users/create name)
    (restas:redirect 'users/get-login)))
