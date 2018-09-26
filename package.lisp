;;;; package.lisp

(defpackage #:cl-recker
  (:use #:cl)
  (:export :*battery-path*
	   :hostname-formatter
	   :net-vpn-formatter
	   :power-charge-percentage
	   :power-charge-formatter))
