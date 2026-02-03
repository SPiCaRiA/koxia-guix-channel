;;; kanata.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-kanata.org.
;;; Do not modify manually.

(define-module (sui services kanata)
  #:use-module ((gnu packages linux) #:select (kmod))
  #:use-module ((gnu packages rust-apps) #:select (kanata))
  #:use-module (gnu services)
  #:use-module ((gnu services base) #:select (udev-service-type
                                              udev-rule))
  #:use-module (gnu services configuration)
  #:use-module ((gnu services linux)
                #:select (kernel-module-loader-service-type))
  #:use-module (gnu system accounts)
  #:use-module (gnu system shadow)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:export (kanata-service-type))

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

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; kanata.scm ends here.
