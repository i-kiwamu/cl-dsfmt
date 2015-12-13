(in-package #:cl-dsfmt)

(cffi:define-foreign-library libdSFMT
  (:darwin "libdSFMT.dylib")
  (:unix "libdSFMT.so")
  (:windows "libdSFMT.dll")
  (t (:default "libdSFMT")))

;; (defvar *dsfmt-cflags*
;;   (let ((dir (merge-pathnames
;;               "dSFMT-src-2.2"
;;               (asdf:system-source-directory "cl-dsfmt"))))
;;     (concatenate 'string "-I" (namestring dir))))

(eval-when (:load-toplevel :execute)
  (cffi:use-foreign-library libdSFMT))
