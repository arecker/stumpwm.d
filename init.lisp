(in-package :stumpwm)

(defun load-modules ()
  (set-module-dir "~/.stumpwm.d/modules/")
  (dolist (module '("pass" "swm-gaps" "ttf-fonts"))
    (load-module module)))

(load-modules)

(defun configure-font (&key family subfamily size)
  (unless (find subfamily (xft:get-font-subfamilies family) :test #'equal)
    (xft:cache-fonts))
  (stumpwm:set-font (make-instance 'xft:font
				   :family family
				   :subfamily subfamily
				   :size size)))

(configure-font :family "Inconsolata" :subfamily "Regular" :size 12)

(defun configure-windows ()
  (setf *window-name-source* :class)
  (setf *window-format* " %30t ")
  (set-win-bg-color "#E5E5E5")
  (setf *window-border-style* :thin)
  (setf *new-frame-action* :last-window))

(configure-windows)

(defun configure-interface ()
  (set-msg-border-width 5)
  (set-fg-color "#000000")
  (set-bg-color "#E5E5E5")
  (setf *input-window-gravity* :bottom-right)
  (setf *message-window-gravity* :bottom-right)
  (setf *message-window-padding* 5))

(configure-interface)

(setf *hidden-window-color* "^5*")
(setf *hidden-window-color* "^n")

(defun configure-gaps ()
  (setf swm-gaps:*inner-gaps-size* 10)
  (setf swm-gaps:*outer-gaps-size* 10)
  (unless swm-gaps:*gaps-on* (swm-gaps:toggle-gaps)))

(configure-gaps)

(defun configure-modeline ()
  (add-screen-mode-line-formatter #\V 'cl-recker:net-vpn-formatter)
  (add-screen-mode-line-formatter #\B 'cl-recker:power-charge-formatter)
  (setf *time-modeline-string* "%Y-%m-%d | %I:%M %P")
  (setf *screen-mode-line-format* '("[%n] %v ^> %V | %B | %d"))
  (setf *mode-line-background-color* "#E5E5E5")
  (setf *mode-line-foreground-color* "#000000")
  (setf *mode-line-border-width* 5)
  (setf *mode-line-border-color* "#FFFFFF")
  (setf *hidden-window-color* "^n")
  (unless *mode-lines* (mode-line)))

(configure-modeline)

(defcommand firefox () ()
  (run-or-raise "firefox" '(:class "Firefox")))

(define-key *root-map* (stumpwm:kbd "M-f") "firefox")

(defcommand deluge () ()
  (run-or-raise "deluge-gtk" '(:class "Deluge")))

(define-key *root-map* (kbd "M-d") "deluge")

(defcommand urxvt () ()
  (run-shell-command "urxvt"))

(define-key *root-map* (kbd "c") "urxvt")

(defcommand pavucontrol () ()
  (run-or-raise "pavucontrol" '(:class "Pavucontrol")))

(define-key *root-map* (kbd "M-v") "pavucontrol")

(defun configure-xorg ()
  (dolist (cmd '("xscreensaver -no-splash"
		 "compton"
		 "setxkbmap -option ctrl:nocaps"
		 "xsetroot -cursor_name left_pt"
		 "xrdb -merge ~/.Xresources"
		 "xsetroot -cursor_name left_ptr"))
      (run-shell-command cmd)))

(configure-xorg)

(defun set-wallpaper (pic)
  (let ((target (merge-pathnames pic (user-homedir-pathname))))
    (run-shell-command (format nil "feh --bg-scale ~a" target))))

(set-wallpaper "pics/apartment.jpeg")

(defcommand volume-toggle-mute () ()
  (run-shell-command "pactl set-sink-mute 0 toggle"))

(define-key *top-map* (kbd "XF86AudioMute") "volume-toggle-mute")

(defcommand volume-increase () ()
  (run-shell-command "pactl set-sink-volume 0 +10%"))

(define-key *top-map* (kbd "XF86AudioRaiseVolume") "volume-increase")

(defcommand volume-decrease () ()
  (run-shell-command "pactl set-sink-volume 0 -10%"))

(define-key *top-map* (kbd "XF86AudioLowerVolume") "volume-decrease")

(define-key *root-map* (kbd "M-p") "pass-copy")
