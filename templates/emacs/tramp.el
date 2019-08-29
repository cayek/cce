(with-eval-after-load 'git-gutter+
   (defun git-gutter+-remote-default-directory (dir file)
     (let* ((vec (tramp-dissect-file-name file))
            (method (tramp-file-name-method vec))
            (user (tramp-file-name-user vec))
            (domain (tramp-file-name-domain vec))
            (host (tramp-file-name-host vec))
            (port (tramp-file-name-port vec)))
       (tramp-make-tramp-file-name method user domain host port dir)))

   (defun git-gutter+-remote-file-path (dir file)
     (let ((file (tramp-file-name-localname (tramp-dissect-file-name file))))
       (replace-regexp-in-string (concat "\\`" dir) "" file))))
