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

(defparameter *pactl-cmd* "pactl list sinks")

(defun volume-level ()
  (first (run-command (awk (grep *pactl-cmd* "Volume: front-left") 5))))

(defun volume-muted-p ()
  (equal "yes" (first (run-command (awk (grep *pactl-cmd* "Mute: ") 2)))))

(defparameter *font* '(:family "Inconsolata" :subfamily "Regular" :size 12))

(defun make-font ()
  (let ((family (getf *font* :family))
	(subfamily (getf *font* :subfamily))
	(size (getf *font* :size)))
    (unless (find subfamily (xft:get-font-subfamilies family) :test #'equal)
      (xft:cache-fonts))
    (make-instance 'xft:font :family family :subfamily subfamily :size size)))
