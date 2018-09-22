(quicklisp:quickload '(:stumpwm :cl-recker) :silent t)

(stumpwm:add-screen-mode-line-formatter #\B 'cl-recker:power-charge-percentage)
