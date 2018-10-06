;;;; cl-recker.lisp

(in-package #:cl-recker)

(defparameter *vpn-interface* "tun0")

(defun power-charge-percentage ()
  (let ((cmd
	 "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage: ' | awk '{ print $2 }'"))
    (with-input-from-string (str (uiop:run-program cmd :output :string))
      (read str))))

(defun power-charge-formatter (ml)
  (declare (ignore ml))
  (format nil "~a" (power-charge-percentage)))

(defun net-vpn-up-p ()
  (let ((target (merge-pathnames *vpn-interface* #P"/sys/class/net/")))
    (not (equal nil (probe-file target)))))

(defun net-vpn-formatter (ml)
  (declare (ignore ml))
  (format nil "~a: ~:[down~;up~]" *vpn-interface* (net-vpn-up-p)))

(defun hostname-formatter (ml)
  (declare (ignore ml))
  (format nil "~a" (machine-instance)))
