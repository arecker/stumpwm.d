;;;; cl-recker.lisp

(in-package #:cl-recker)

(defparameter *battery-path* #P"/sys/class/power_supply/BAT0/")

(defun read-first-line (filename)
  (with-open-file (stream filename)
    (read-line stream)))

(defun read-first-int (filename)
  (parse-integer (read-first-line filename)))

(defun power-charging-p ()
  (let ((status (read-first-line (merge-pathnames "status" *battery-path*))))
    (not (equal status "Discharging"))))

(defun power-charge-percentage ()
  (let* ((now-attr (if (power-charging-p) "energy_now" "charge_now"))
	 (full-attr (if (power-charging-p) "energy_full" "charge_full"))
	 (now (read-first-int (merge-pathnames now-attr *battery-path*)))
	 (full (read-first-int (merge-pathnames full-attr *battery-path*)))
	 (ratio (/ now full))
	 (percent (float (* 100 ratio))))
    (format nil "~$%" percent)))
