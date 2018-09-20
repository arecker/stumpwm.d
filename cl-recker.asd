;;;; cl-recker.asd

(asdf:defsystem #:cl-recker
  :description "StumpWM Configuration"
  :author "Alex Recker <alex@reckerfamily.com>"
  :license  "GPLv3"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:file "cl-recker")))
