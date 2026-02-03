;;; utils.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-utils.org.
;;; Do not modify manually.

(define-module (sui systems utils)
  #:use-module (ice-9 textual-ports)
  #:use-module (guix gexp)

  #:export (computed-substitution-with-inputs
            file-content))

;;; Commentary:
;;;
;;; File utility functions.
;;;
;;; Mostly from https://github.com/rakino/Rosenthal.
;;;
;;; Code:

(define (computed-substitution-with-inputs name file inputs)
  (with-imported-modules '((guix build utils))
    (computed-file
     name
     #~(begin
         (use-modules (ice-9 match)
                      (guix build utils))
         (copy-file #$file #$output)
         (substitute* #$output
           (("\\$\\$([^\\$]+)\\$\\$" _ path)
            (let loop ((candidates '#$inputs))
              (if (null? candidates)
                  (error "file '~a' not found" path)
                  (match candidates
                    ((candidate . rest)
                     (let ((full-path (in-vicinity candidate path)))
                       (if (file-exists? full-path)
                           full-path
                           (loop rest)))))))))))))

(define (file-content file)
  (call-with-input-file (canonicalize-path file) get-string-all))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; utils.scm ends here.
