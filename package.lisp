;;;; package.lisp

(defpackage #:cl-recker
  (:use #:cl)
  (:export :*colors*
	   :hostname-formatter
	   :net-vpn-formatter
	   :power-charge-formatter
	   :wireless-formatter))
