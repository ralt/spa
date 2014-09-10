(in-package #:spa)

(restas:define-route users/get-login ("users/login" :method :get)
  (check-logout)
  (spa.layout:main
   (list
    :title "Login"
    :isnotlogged t
    :body (spa.users:login
           (list
            :users (db users/get-all-names))))))

(restas:define-route users/post-login ("users/login" :method :post)
  (check-logout)
  (let* ((name (hunchentoot:post-parameter "name"))
         (pass (hunchentoot:post-parameter "pass"))
         (user (db users/get-by-name name)))
    (unless user
      (restas:redirect 'users/get-login))
    (if (cl-pass:check-password pass (getf user :pass))
        (progn
          (setf (hunchentoot:session-value :userid) (getf user :id))
          (restas:redirect 'cat))
        (restas:redirect 'users/get-login))))

(restas:define-route users/logout ("users/logout")
  (check-login)
  (hunchentoot:delete-session-value :userid)
  (restas:redirect 'users/get-login))

(restas:define-route users/get-add ("users/add" :method :get)
  (check-admin)
  (spa.layout:main
   (list
    :title "Add user"
    :body (spa.users:add))))

(restas:define-route users/post-add ("users/add" :method :post)
  (check-admin)
  (let ((name (hunchentoot:post-parameter "name")))
    (db users/create name)
    (restas:redirect 'users/get-login)))
