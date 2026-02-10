;;; audio.scm --- The Sui Guix Channel  -*- mode: scheme; -*-
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later
;;;
;;; This file is generated from sui-audio.org.
;;; Do not modify manually.

(define-module (sui packages audio)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module ((gnu packages linux) #:select (alsa-ucm-conf)))

;;; Commentary:
;;;
;;; Audio packages.
;;;
;;; Code:

(define-public alsa-ucm-conf-1.2.15
  (package/inherit alsa-ucm-conf
    (version "1.2.15.3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://www.alsa-project.org/files/pub/lib/"
             "alsa-ucm-conf-" version ".tar.bz2"))
       (sha256
        (base32 "0ccab0pvkbzszkhhf9nvhas52jhsvbyc8xfx8vx6rj4gq09yhycz"))))))

;; Local Variables:
;; indent-tabs-mode: nil
;; tab-width: 2
;; End:

;;; audio.scm ends here.
