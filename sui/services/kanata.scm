;;; kanata.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-kanata.org.
;;; Do not modify manually.

(define-module (sui services kanata)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services configuration)
  #:use-module (gnu services linux)
  #:use-module (gnu services shepherd)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu system accounts)
  #:use-module (gnu system shadow)
  #:use-module (guix gexp)
  #:use-module (guix records)

  #:export (kanata-service-type
            home-kanata-configuration
            home-kanata-service-type))

;;; Commentary:
;;;
;;; Code:

(define kanata-udev-rules
  (udev-rule
   "99-kanata.rules"
   "KERNEL==\"uinput\", MODE=\"0660\", GROUP=\"uinput\", OPTIONS+=\"static_node=uinput\""))

(define kanata-service-type
  (service-type
    (name 'kanata)
    (extensions
     (list (service-extension account-service-type
                              (const
                               (list (user-group (name "uinput")
                                                 (system? #t)))))
           (service-extension udev-service-type
                              (const (list kanata-udev-rules)))
           (service-extension kernel-module-loader-service-type
                              (const '("uinput")))))
    (default-value #f)
    (description "Kanata keyboard remapping service.")))

(define-maybe file-like)

(define-configuration/no-serialization home-kanata-configuration
  (config
   maybe-file-like
   "Kanata configuration file."))

(define %home-kanata-shepherd
  (match-record-lambda <home-kanata-configuration>
      (config)
    (list (shepherd-service
            (documentation "Start kanata keyboard remapper.")
            (provision '(kanata))
            (start #~(make-forkexec-constructor
                      (list #$(file-append kanata "/bin/kanata")
                            "-c"
                            #$(if (maybe-value-set? config)
                                  config
                                  #~(string-append (or (getenv "XDG_CONFIG_HOME")
                                                       (string-append (getenv "HOME")
                                                                      "/.config"))
                                                   "/kanata/kanata.kbd")))))
            (stop #~(make-kill-destructor))))))

(define home-kanata-service-type
  (service-type
    (name 'home-kanata)
    (extensions
     (list (service-extension home-shepherd-service-type
                              %home-kanata-shepherd)))
    (default-value (home-kanata-configuration))
    (description "Home service for running Kanata keyboard remapper.")))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; kanata.scm ends here.
