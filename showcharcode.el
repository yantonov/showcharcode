(defvar scc/prefix "scc/")
(defvar scc/adviced-functions (list 'forward-char
                                    'backward-char
                                    'left-char
                                    'right-char
                                    'previous-line
                                    'next-line
                                    'forward-sentence
                                    'backward-sentence
                                    'forward-word
                                    'backward-word
                                    'forward-page
                                    'backward-page
                                    'beginning-of-buffer
                                    'end-of-buffer))

(defun scc/iterate-functions-to-advice (fn)
  (dolist (fn-to-advice scc/adviced-functions)
    (let ((advice-sym (intern (concat scc/prefix (symbol-name fn-to-advice)))))
      (funcall fn fn-to-advice advice-sym))))

(scc/iterate-functions-to-advice
 (lambda (f advice-f)
   (eval `(defadvice ,f (after ,advice-f)
            (what-cursor-position)))))

(defun scc/enable ()
  (scc/iterate-functions-to-advice
   (lambda (f advice-f)
     (ad-enable-advice f 'after advice-f)
     (ad-activate f))))

(defun scc/disable ()
  (scc/iterate-functions-to-advice
   (lambda (f advice-f)
     (ad-disable-advice f 'after advice-f)
     (ad-activate f))))

(define-minor-mode showcharcode-mode
  :init-value nil
  :lighter " scc"
  (progn (if showcharcode-mode 
             (scc/enable)
           (scc/disable))))

(provide 'showcharcode)
