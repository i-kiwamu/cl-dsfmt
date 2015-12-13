#|
  This file is a part of cl-dsfmt project.
  Copyright (c) 2015 Kiwamu Ishikura (ishikura.kiwamu@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-dsfmt-test-asd
  (:use :cl :asdf))
(in-package :cl-dsfmt-test-asd)

(defsystem cl-dsfmt-test
  :author "Kiwamu Ishikura"
  :license "New BSD"
  :depends-on (:cl-dsfmt
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cl-dsfmt"))))
  :description "Test system for cl-dsfmt"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
