;;; configuration.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-utils.org.
;;; Do not modify manually.

(define-module (sui utils configuration)
  #:use-module (gnu)
  #:export ($
            with-config))

;;; Commentary:
;;;
;;; Utilities for accessing operating-system fields, both within the
;;; operating-system form (via this-operating-system) and in external
;;; helper functions (via with-config).
;;;
;;; Code:

(define current-config (make-parameter #f))

(define-syntax $
  (lambda (stx)
    "Access fields of the current operating-system configuration.

Within an operating-system form, falls back to this-operating-system.
Within with-config, uses the parameterized config.

Special cases:
  ($ user-names) returns the list of user account names

General case:
  ($ field) accesses the field"
    (syntax-case stx (user-names)
      [(k user-names)
       (with-syntax ([tos (datum->syntax #'k 'this-operating-system)])
         #'(map user-account-name
                (operating-system-users (or (current-config) tos))))]
      [(k field)
       (let* ([field-name (symbol->string (syntax->datum #'field))]
              [accessor-sym (string->symbol
                             (string-append "operating-system-" field-name))])
         (with-syntax ([accessor (datum->syntax #'field accessor-sym)]
                       [tos (datum->syntax #'k 'this-operating-system)])
           #'((@ (gnu system) accessor) (or (current-config) tos))))])))

(define-syntax with-config
  (syntax-rules ()
    "Bind CONFIG as the current configuration for $ access in BODY.
Use this in helper functions that need to access the operating-system."
    [(_ config body ...)
     (parameterize ([current-config config])
       body ...)]))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; configuration.scm ends here.
