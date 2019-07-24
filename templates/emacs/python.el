(require 'python)

;; to see env with pyvenv: https://emacs.stackexchange.com/questions/20092/using-conda-environments-in-emacs
(setenv "WORKON_HOME" "/home/{{username}}/.virtualenvs/")

(require 'eval-in-repl-python)
(setq eir-repl-placement 'below)
(setq eir-always-split-script-window t)
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'eir-eval-in-python)))
