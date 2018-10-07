;;;; cl-recker.lisp

(in-package #:cl-recker)

(defparameter *colors*	'("black" "red" "green"
			  "yellow" "blue" "magenta"
			  "cyan" "white" "#E5E5E5")
  "My override for stumpwm's colors list.")

(defun run-command (cmd)
  (multiple-value-bind (output error exit) (uiop:run-program cmd :output :lines)
    (declare (ignore error exit))
    output))

(defun grep (cmdstr searchstr)
  (format nil "~a | grep '~a'" cmdstr searchstr))

(defun awk (cmdstr posindex)
  (format nil "~a | awk '{ print $~a }'" cmdstr posindex))

(defun power-charge-percentage ()
  (let ((cmdstr "upower -i /org/freedesktop/UPower/devices/battery_BAT0"))
    (first (run-command (awk (grep cmdstr "percentage: ") 2)))))

(defun power-charge-formatter (ml)
  (declare (ignore ml))
  (format nil "B: ~a" (power-charge-percentage)))

(defun hostname-formatter (ml)
  (declare (ignore ml))
  (format nil "~a" (machine-instance)))
