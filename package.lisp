;;;; package.lisp

(defpackage #:cl-recker
  (:use #:cl)
  (:export :*battery-path*
	   :power-charge-percentage
	   :power-charge-formatter))
