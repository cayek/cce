(require 'server)
(or (server-running-p)
    (server-start))

;; inline image size
(setq org-image-actual-width '(300))

;; google translate see: https://github.com/atykhonov/google-translate
(require 'google-translate)
(require 'google-translate-smooth-ui)
(global-set-key "\C-ct" 'google-translate-smooth-translate)

(setq google-translate-translation-directions-alist
      '(("en" . "fr") ("fr" . "en")))

;; flyspell default
(setq flyspell-default-dictionary "en_US")
