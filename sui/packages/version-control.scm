;;; version-control.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-version-control.org.
;;; Do not modify manually.

(define-module (sui packages version-control)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (nonguix build-system binary))

;;; Commentary:
;;;
;;; Version control packages.
;;;
;;; Code:

(define-public gh
  (package
    (name "gh")
    (version "2.86.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/cli/cli/releases/download/v"
                           version "/gh_" version "_linux_amd64.tar.gz"))
       (sha256
        (base32 "1iq3h6k1q1612is2jjzhscwbiwi5za3sd8dh54icq844lbb8pc7k"))))
    (build-system binary-build-system)
    (arguments
     (list
      #:install-plan #~'(("bin/" "bin/")
                         ("share/" "share/"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'install-completions
            (lambda _
              (let* ([gh (string-append #$output "/bin/gh")]
                     [bash-comp
                      (string-append #$output
                                     "/share/bash-completion/completions")]
                     [zsh-comp (string-append #$output
                                              "/share/zsh/site-functions")]
                     [fish-comp
                      (string-append #$output
                                     "/share/fish/vendor_completions.d")])
                (mkdir-p bash-comp)
                (mkdir-p zsh-comp)
                (mkdir-p fish-comp)
                (with-output-to-file (string-append bash-comp "/gh")
                  (lambda () (invoke gh "completion" "-s" "bash")))
                (with-output-to-file (string-append zsh-comp "/_gh")
                  (lambda () (invoke gh "completion" "-s" "zsh")))
                (with-output-to-file (string-append fish-comp "/gh.fish")
                  (lambda () (invoke gh "completion" "-s" "fish")))))))))
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

;;; version-control.scm ends here.
