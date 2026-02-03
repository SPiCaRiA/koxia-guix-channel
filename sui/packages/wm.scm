;;; wm.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-wm.org.
;;; Do not modify manually.

(define-module (sui packages wm)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (nonguix build-system binary))

;;; Commentary:
;;;
;;; Window manager packages.
;;;
;;; Code:

(define-public noctalia-shell-minimal
  (package
    (name "noctalia-shell-minimal")
    (version "4.2.5")
    (source
     (origin
       (method url-fetch)
       (uri
        (string-append
         "https://github.com/noctalia-dev/noctalia-shell/releases/download/v"
         version "/noctalia-v" version ".tar.gz"))
       (sha256
        (base32 "0y9kln39cl747zg49jmmx6ylw8wsjjfhr3pnapniwl0agh12jq1w"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan
      #~'(("." "share/noctalia-shell"
           #:include ("Assets" "Bin" "Commons" "Helpers"
                      "Modules" "Services" "Shaders" "Widgets" "Scripts"
                      "shell.qml")))))
    (propagated-inputs
     (list quickshell
           brightnessctl
           imagemagick
           python
           git))
    (home-page "https://noctalia.dev/")
    (synopsis "Minimal desktop shell for Wayland built with Quickshell")
    (description
     "Noctalia is a sleek and minimal desktop shell for Wayland compositors,
built with Quickshell.

To launch, run @code{qs -p <guix-store>/share/noctalia-shell}.")
    (license license:expat)))

(define-public noctalia-shell
  (package
    (inherit noctalia-shell-minimal)
    (name "noctalia-shell")
    (propagated-inputs
     (modify-inputs (package-propagated-inputs noctalia-shell-minimal)
       (append cliphist
               cava
               ddcutil
               wlsunset
               wl-clipboard)))))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; wm.scm ends here.
