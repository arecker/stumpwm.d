;;;; cl-recker.lisp

(in-package #:cl-recker)

(defun read-first-line (filename)
  (with-open-file (stream filename)
    (read-line stream)))

(defun read-first-int (filename)
  (parse-integer (read-first-line filename)))

(defun power-attribute-path (attr)
  (let ((battery-path #P"/sys/class/power_supply/BAT0/"))
    (merge-pathnames (pathname (string-downcase attr)) battery-path)))

(defun power-charge-percentage ()
  (let* ((now (read-first-int (power-attribute-path "charge_now")))
	 (full (read-first-int (power-attribute-path "charge_full")))
	 (ratio (/ now full))
	 (percent (float (* 100 ratio))))
    (format nil "~$%" percent)))

(defun power-charging-p ()
  (let ((status (read-first-line (power-attribute-path "status"))))
    (not (equal status "Discharging"))))
