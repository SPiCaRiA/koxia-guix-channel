;;; authentication.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-password-utils.org.
;;; Do not modify manually.

(define-module (sui services authentication)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (gnu services dbus)
  #:use-module (gnu services shepherd)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu system accounts)
  #:use-module (gnu system privilege)
  #:use-module (gnu system shadow)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (sui packages password-utils)
  #:export (1password-configuration
            1password-service-type
            home-1password-service-type))

;;; Commentary:
;;;
;;; 1Password Polkit services.
;;;
;;; Code:

(define-configuration/no-serialization 1password-configuration
  (1password
   (file-like 1password)
   "1Password package to use.")
  (1password-cli
   (file-like 1password-cli)
   "1Password CLI package to use.")
  (user
   string
   "User to set for the 1password-cli privileged program."))

(define 1password-groups
  (list
   (user-group (name "onepassword"))
   (user-group (name "onepassword-cli"))))

(define 1password-privileged-programs
  (match-record-lambda <1password-configuration>
      (1password 1password-cli user)
    (list
     (privileged-program
       (program (file-append 1password-cli "/bin/op"))
       (setgid? #t)
       (user user)
       (group "onepassword-cli"))
     (privileged-program
       (program (file-append 1password
                             "/share/1Password/1Password-BrowserSupport"))
       (setgid? #t)
       (group "onepassword")))))

(define 1password-polkit-policies
  (match-record-lambda <1password-configuration>
      (1password)
    (list 1password)))

(define 1password-packages
  (match-record-lambda <1password-configuration>
      (1password 1password-cli)
    (list 1password 1password-cli)))

(define 1password-service-type
  (service-type
    (name '1password)
    (extensions
     (list (service-extension account-service-type
                              (const 1password-groups))
           (service-extension privileged-program-service-type
                              1password-privileged-programs)
           (service-extension polkit-service-type
                              1password-polkit-policies)
           (service-extension profile-service-type
                              1password-packages)))
    (description "Set user groups, setuid programs, and polkit policies for
1Password.")))

(define home-1password-service-type
  (service-type
    (name 'home-1password)
    (extensions
     (list (service-extension home-shepherd-service-type
                              (const
                               (list (shepherd-service
                                       (documentation "Start 1Password.")
                                       (provision '(1password))
                                       (start #~(make-forkexec-constructor
                                                 (list #$(file-append 1password
                                                                      "/bin/1password"))))
                                       (stop #~(make-kill-destructor))))))))
    (default-value #f)
    (description "Home service for running 1Password.")))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; authentication.scm ends here.
