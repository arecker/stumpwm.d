(defparameter *stumpwm-modules* '("pass" "swm-gaps" "ttf-fonts"))

(defmacro in-stumpwm (&rest forms)
  `(let ((returned nil))
     (in-package :stumpwm)
     (setf returned (progn ,@forms))
     (in-package :cl-user)
     returned))

(defun load-modules ()
  (in-stumpwm
   (set-module-dir "~/.stumpwm.d/modules/")
   (dolist (module *stumpwm-modules*)
     (load-module module))))

(load-modules)

(stumpwm:add-screen-mode-line-formatter #\B 'cl-recker:power-charge-formatter)
(setf stumpwm:*window-border-style* :none)
(setf stumpwm:*new-frame-action* :last-window)
(setf stumpwm:*window-format* " %30t ")
(setf stumpwm:*window-name-source* :class)
(setf stumpwm:*message-window-gravity* :bottom-right)
(setf stumpwm:*input-window-gravity* :bottom-right)
(setf stumpwm:*message-window-padding* 5)
(stumpwm:set-fg-color "#000000")
(stumpwm:set-bg-color "#E5E5E5")
(stumpwm:set-border-color "#FFFFFF")
(stumpwm:set-msg-border-width 5)
(setf swm-gaps:*inner-gaps-size* 10)
(setf swm-gaps:*outer-gaps-size* 10)
(swm-gaps:toggle-gaps)
(setf stumpwm:*time-modeline-string* "%Y-%m-%d %I:%M %P")
(setf stumpwm:*screen-mode-line-format* '("[%n] %v ^> %B %d"))
(setf stumpwm:*hidden-window-color* "^n")
(setf stumpwm:*colors* (append stumpwm:*colors* '("#BFBFBF" "#E5E5E5")))
(stumpwm:update-color-map (stumpwm:current-screen))
(setf stumpwm:*mode-line-background-color* "#E5E5E5")
(setf stumpwm:*mode-line-foreground-color* "#000000")
(setf stumpwm:*mode-line-border-width* 5)
(setf stumpwm:*mode-line-border-color* "#FFFFFF")
(stumpwm:mode-line)
(stumpwm:set-font (make-instance 'xft:font :family "Inconsolata" :subfamily "Regular" :size 12))

(stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "M-0") "pass-copy")

(stumpwm:defcommand firefox () ()
  "Start an firefox instance."
  (stumpwm:run-shell-command "firefox"))

(stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "M-1") "firefox")

;; (define-key *top-map* (kbd "XF86AudioLowerVolume") "todo-volume-down")
;; (define-key *top-map* (kbd "XF86AudioRaiseVolume") "todo-volume-up")
;; (define-key *top-map* (kbd "XF86AudioMute") "todo-volume-toggle")

(stumpwm:defcommand urxvt () ()
  "Start an xterm instance."
  (stumpwm:run-shell-command "urxvt"))
(stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "c") "urxvt")
