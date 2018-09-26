;;;; cl-recker.lisp

(in-package #:cl-recker)

(defparameter *battery-path* #P"/sys/class/power_supply/BAT0/")

(defparameter *vpn-interface* "tun0")

(defun read-first-line (filename)
  (with-open-file (stream filename)
    (read-line stream)))

(defun read-first-int (filename)
  (parse-integer (read-first-line filename)))

(defun power-charge-percentage ()
  (let* ((energy-now (merge-pathnames "energy_now" *battery-path*))
	 (energy-full (merge-pathnames "energy_full" *battery-path*))
	 (charge-now (merge-pathnames "charge_now" *battery-path*))
	 (charge-full (merge-pathnames "charge_full" *battery-path*))
	 (now (read-first-int (if (probe-file energy-now) energy-now charge-now)))
	 (full (read-first-int (if (probe-file energy-full) energy-now charge-full))))
    (format nil "~$%" (* 100 (/ now full)))))

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
