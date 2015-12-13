#|
  This file is a part of cl-dsfmt project.
  Copyright (c) 2015 Kiwamu Ishikura (ishikura.kiwamu@gmail.com)
|#

#|
  Author: Kiwamu Ishikura (ishikura.kiwamu@gmail.com)
|#

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:load-system 'cffi-grovel))

(in-package :cl-user)
(defpackage cl-dsfmt-asd
  (:use :cl :asdf :cffi-grovel))
(in-package :cl-dsfmt-asd)

(defsystem cl-dsfmt
  :version "0.1"
  :author "Kiwamu Ishikura"
  :license "New BSD"
  :depends-on (:cffi :cffi-libffi)
  :components ((:module "src"
                :components
                ((:file "packages")
                 (:file "cl-dsfmt-configure" :depends-on ("packages"))
                 (cffi-grovel:grovel-file "dsfmt-grovel" :depends-on ("packages" "cl-dsfmt-configure"))
                 (:file "cl-dsfmt" :depends-on ("packages" "cl-dsfmt-configure" "dsfmt-grovel")))))
  :description "dSFMT random generation for Common Lisp"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-dsfmt-test))))
