(define-module (koxia packages fonts)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix build-system font)
  #:use-module ((guix licenses) #:prefix license:))

(define-public font-meslo-nerd
  (package
   (name "font-meslo-nerd")
   (version "3.4.0")
   (source
    (origin
     (method url-fetch/zipbomb)
     (uri (string-append
           "https://github.com/ryanoasis/nerd-fonts/releases/download/v"
           version "/Meslo.zip"))
     (sha256
      (base32 "0mxd35d2cx894w57hc5pbcbjpm1ww9h4a1hq20bd7n9bijn05d8k"))))
   (build-system font-build-system)
   (home-page "https://github.com/ryanoasis/nerd-fonts")
   (synopsis "Meslo Nerd Font")
   (description "Meslo font with nerd icons.")
   (license license:asl2.0)))


(define-public font-ia-writer-variable
  (package
   (name "font-ia-writer-variable")
   (version "1.0.0")
   (source #f)
   (build-system font-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
                     (replace 'unpack
                              (lambda* (#:key inputs #:allow-other-keys)
                                (mkdir-p "source")
                                (chdir "source")

                                (for-each
                                 (lambda (input)
                                   (let* ((input-name (car input))
                                          (input-path (cdr input)))
                                     (copy-file input-path (basename input-path))))
                                 (alist-delete "source" inputs)))))))
   (inputs
    `(("iAWriterMonoV"
       ,(origin
         (method url-fetch)
         (uri "https://github.com/iaolo/iA-Fonts/raw/refs/heads/master/iA%20Writer%20Mono/Variable/iAWriterMonoV.ttf")
         (sha256
          (base32
           "0h0jw162pj0p2fbwzll30lgi023ndgza51g9m78zy1gxsx05g2ya"))))
      ("iAWriterMonoV-Italic"
       ,(origin
         (method url-fetch)
         (uri "https://github.com/iaolo/iA-Fonts/raw/refs/heads/master/iA%20Writer%20Mono/Variable/iAWriterMonoV-Italic.ttf")
         (sha256
          (base32
           "1w7dsk017chrbyw60y6xkm49frk9glcy08jz6yv0bzw0s5fldcws"))))
      ("iAWriterDuoV"
       ,(origin
         (method url-fetch)
         (uri "https://github.com/iaolo/iA-Fonts/raw/refs/heads/master/iA%20Writer%20Duo/Variable/iAWriterDuoV.ttf")
         (sha256
          (base32
           "0f4v9i8dvsbs7ql8lzan85pwa4cyfc2wm9lrwkviw69lkyhs9nq0"))))
      ("iAWriterDuoV-Italic"
       ,(origin
         (method url-fetch)
         (uri "https://github.com/iaolo/iA-Fonts/raw/refs/heads/master/iA%20Writer%20Duo/Variable/iAWriterDuoV-Italic.ttf")
         (sha256
          (base32
           "1vc4634cbk208wzzi25dbk9d0dq3wh4fn0c3fdw7h2a8x7j3qava"))))
      ("iAWriterQuattroV"
       ,(origin
         (method url-fetch)
         (uri "https://github.com/iaolo/iA-Fonts/raw/refs/heads/master/iA%20Writer%20Quattro/Variable/iAWriterQuattroV.ttf")
         (sha256
          (base32
           "1w320ijrwzpkh48p198sj0n3mys665zf2fhyqynwmfw7m1cy75ky"))))
      ("iAWriterQuattroV-Italic"
       ,(origin
         (method url-fetch)
         (uri "https://github.com/iaolo/iA-Fonts/raw/refs/heads/master/iA%20Writer%20Quattro/Variable/iAWriterQuattroV-Italic.ttf")
         (sha256
          (base32
           "0fiqx5dpfs51ql2q9i2ssg2pavn811vnqyqdx15zvnzhnh0qkhik"))))))
   (home-page "https://github.com/iaolo/iA-Fonts")
   (synopsis "iA Writer Variable fonts.")
   (description
    "Free variable writing fonts from iA.  @uref{https://ia.net}.")
   ;; iA-Fonts uses the licensing file from its upstream project, IBM Plex.
   (license license:silofl1.1)))
