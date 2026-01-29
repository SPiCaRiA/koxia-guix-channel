;;; gh.scm --- The Koxia Guix channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from koxia-gh.org.  Do not modify manually.

(define-module (koxia packages gh)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (nonguix build-system binary))

;;; Commentary:
;;;
;;; GitHub CLI.
;;;
;;; Code:

(define-public gh
  (package
    (name "gh")
    (version "2.72.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/cli/cli/releases/download/v"
                           version "/gh_" version "_linux_amd64.tar.gz"))
       (sha256
        (base32 "0f3zqwab3mplzgxsfx96s67g6n76aijv00hkaccn3kvm21wsklzz"))))
    (build-system binary-build-system)
    (arguments
     '(#:install-plan '(("bin/" "bin/")
                        ("share/" "share/"))))
    (home-page "https://cli.github.com/")
    (synopsis "GitHub’s official command line tool")
    (description
     "@code{gh} is GitHub on the command line.  It brings pull requests, issues,
and other GitHub concepts to the terminal next to where you are already working
with @code{git} and your code.")
    (license license:expat)))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; gh.scm ends here.
