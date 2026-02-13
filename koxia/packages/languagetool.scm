;;; languagetool.scm --- The Koxia Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from koxia-languagetool.org.
;;; Do not modify manually.

(define-module (koxia packages languagetool)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages java))

;;; Commentary:
;;;
;;; LanguageTool and LTeX+.
;;;
;;; Code:

(define %languagetool-url
  "https://languagetool.org/download/")

(define-public languagetool
  (package
    (name "languagetool")
    (version "6.6")
    (source
     (origin
       (method url-fetch)
       (uri (string-append %languagetool-url
                           "LanguageTool-" version ".zip"))
       (sha256
        (base32 "0c8ns4a97y5nz778rwxa2hpj2y6k9xwyr3ac3vz5zfwrnc30aq2k"))))
    (build-system copy-build-system)
    (native-inputs (list unzip))
    (arguments
     (list
      #:install-plan
      #~'(("languagetool.jar" "share/LanguageTool/")
          ("languagetool-commandline.jar" "share/LanguageTool/")
          ("languagetool-server.jar" "share/LanguageTool/")
          ("org/" "share/LanguageTool/")
          ("libs/" "share/LanguageTool/")
          ("META-INF" "share/LanguageTool/"))))
    (home-page "https://languagetool.org/")
    (synopsis "Standalone LanguageTool")
    (description "A proof-reading tool for English, Spanish, German, French,
Portuguese, Dutch, Ukrainian and
@url{https://dev.languagetool.org/languages, more languages}")
    (license license:lgpl2.1+)))

(define-public ltex-ls-plus
  (package
    (name "ltex-ls-plus")
    (version "18.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/ltex-plus/ltex-ls-plus/releases/download/"
             version "/ltex-ls-plus-" version ".tar.gz"))
       (sha256
        (base32 "1any55znv1vmkmddayqmvp9cpgm34jw35vl00fncqyd9jbar66v2"))))
    (build-system copy-build-system)
    (inputs (list openjdk))
    (arguments
     (list
      #:install-plan #~'(("bin/" "bin/")
                         ("lib/" "lib/"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'wrap-program
            (lambda _
              (let ([openjdk #$(this-package-input "openjdk")])
                (for-each
                 (lambda (name)
                   (wrap-program (string-append #$output "/bin/" name)
                     `("JAVA_HOME" = (,openjdk))))
                 '("ltex-ls-plus" "ltex-cli-plus"))))))))
    (home-page "https://ltex-plus.github.io/ltex-plus/")
    (synopsis "LSP language server for LanguageTool")
    (description "LTeX+ LS provides grammar and spelling checking for LaTeX,
Markdown, Org, and other markup languages using LanguageTool.")
    (license license:mpl2.0)))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; languagetool.scm ends here.
