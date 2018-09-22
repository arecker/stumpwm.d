;;;; cl-recker.lisp

(in-package #:cl-recker)

(defparameter *battery-path* #P"/sys/class/power_supply/BAT0/")

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
    (format nil "~$%" (float (* 100 (/ now full))))))
