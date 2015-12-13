(in-package :cl-user)
(defpackage cl-dsfmt
  (:use :cl :cffi :cffi-grovel)
  (:export #:dsfmt-chk-init-gen-rand
           #:dsfmt-init-gen-rand
           #:dsfmt-gv-init-gen-rand
           #:dsfmt-gen-rand-all
           #:dsfmt-genrand-close1-open2
           #:dsfmt-gv-genrand-close1-open2))
