(in-package #:spa)

(restas:define-route cat ("cat")
  (check-login)
  (let ((cats (db cat/get-all)))
    (spa.layout:cat
     (list
      :title "All cats"
      :cats cats
      :onhome t
      :body (spa.cat:home
             (list
              :cats (spa.cat:links (list :cats cats))
              :histories (spa.history:show-all
                          (list
                           :histories (db history/get-last-50)))))))))

(restas:define-route cat/goto ("cat/goto")
  (check-login)
  (let ((id (hunchentoot:get-parameter "id")))
    (restas:redirect 'cat/get-one :id id)))

(restas:define-route cat/get-one ("cat/:id" :method :get)
  (check-login)
  (let* ((id (parse-integer id :junk-allowed t))
         (cat (db cat/get-by-id id))
         (type-filters (split-sequence:split-sequence #\Comma (hunchentoot:get-parameter "types")))
         (types (db type/get-all type-filters))
         (now (local-time:now)))
    (spa.layout:cat
     (list
      :title (getf cat :name)
      :cats (db cat/get-all)
      :body (spa.cat:view
             (list
              :cat cat
              :types (spa.type:show-all
                      (list
                       :types types))
              :form (spa.history:add
                     (list
                      :title "Ajouter un suivi"
                      :button "Ajouter"
                      :action (concat "/history/add/" (write-to-string (getf cat :id)))
                      :types (spa.type:select
                              (list
                               :types types))
                      :catname (getf cat :name)
                      :date (format nil
                                    "~2,'0d-~2,'0d-~2,'0d"
                                    (local-time:timestamp-year now)
                                    (local-time:timestamp-month now)
                                    (local-time:timestamp-day now))
                      :time (format nil
                                    "~2,'0d:~2,'0d:~2,'0d"
                                    (local-time:timestamp-hour now)
                                    (local-time:timestamp-minute now)
                                    (local-time:timestamp-second now))))
              :histories (spa.history:show-all
                          (list
                           :histories (db history/get-all-by-cat-id id type-filters)))))))))

(restas:define-route cat/get-add ("cat/add" :method :get)
  (check-login)
  (spa.layout:main
   (list
    :title "Add a cat"
    :body (spa.cat:add
           (list
            :title "Ajout d'un chat"
            :status (spa.status:select
                     (list
                      :statuses (db status/get-all))))))))

(restas:define-route cat/post-add ("cat/add" :method :post)
  (check-login)
  (let* ((name (hunchentoot:post-parameter "name"))
         (gender (hunchentoot:post-parameter "gender"))
         (status (hunchentoot:post-parameter "status"))
         (birthday (hunchentoot:post-parameter "birthday"))
         (identification (hunchentoot:post-parameter "identification"))
         (race (hunchentoot:post-parameter "race"))
         (color (hunchentoot:post-parameter "color"))
         (weight (hunchentoot:post-parameter "weight"))
         (description (hunchentoot:post-parameter "description"))
         (id (db cat/create
                 name
                 gender
                 status
                 birthday
                 identification
                 race
                 color
                 weight
                 description)))
    (restas:redirect 'cat/get-one :id id)))

(restas:define-route cat/get-edit ("cat/:id/edit" :method :get)
  (check-login)
  (let* ((cat (db cat/get-by-id id))
         (birthday (local-time:universal-to-timestamp (getf cat :birthday))))
    (spa.layout:main
     (list
      :title (concat "Edit the cat " (getf cat :name))
      :body (spa.cat:add
             (list
              :title (concat "Modifier le chat " (getf cat :name))
              :name (getf cat :name)
              :gender (if (getf cat :gender)
                          "1" ; females are T
                          "0")
              :birthday (format nil
                                "~2,'0d-~2,'0d-~2,'0d"
                                (local-time:timestamp-year birthday)
                                (local-time:timestamp-month birthday)
                                (local-time:timestamp-day birthday))
              :identification (getf cat :identification)
              :race (getf cat :race)
              :color (getf cat :color)
              :weight (getf cat :weight)
              :description (getf cat :description)
              :status (spa.status:select
                       (list
                        :statuses (db status/get-all-for-cat (getf cat :statusid))))))))))

(restas:define-route cat/post-edit ("cat/:id/edit" :method :post)
  (let* ((name (hunchentoot:post-parameter "name"))
         (gender (hunchentoot:post-parameter "gender"))
         (status (hunchentoot:post-parameter "status"))
         (birthday (hunchentoot:post-parameter "birthday"))
         (identification (hunchentoot:post-parameter "identification"))
         (race (hunchentoot:post-parameter "race"))
         (color (hunchentoot:post-parameter "color"))
         (weight (hunchentoot:post-parameter "weight"))
         (description (hunchentoot:post-parameter "description")))
    (db cat/update
        id
        name
        gender
        status
        birthday
        identification
        race
        color
        weight
        description)
    (restas:redirect 'cat/get-one :id id)))

