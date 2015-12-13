(in-package #:cl-dsfmt)

(defcunion w128-t
  (u :uint64 :count 2)
  (u32 :uint32 :count 4)
  (d :double :count 2))

(defcstruct dsfmt-t
  (status (:union w128-t) :count 192) ; (1+ *dsfmt-n*)
  (idx :int))

(defcvar (*dsfmt-global-data* "dsfmt_global_data") (:struct dsfmt-t))


(defcfun ("dsfmt_chk_init_gen_rand" dsfmt-chk-init-gen-rand) :void
  (dsfmt (:pointer (:struct dsfmt-t)))
  (seed :uint32)
  (mexp :int))

(defun dsfmt-init-gen-rand (dsfmt-ptr seed)
  (dsfmt-chk-init-gen-rand dsfmt-ptr seed *dsfmt-mexp*))

(defun dsfmt-gv-init-gen-rand (seed)
  (dsfmt-init-gen-rand (get-var-pointer '*dsfmt-global-data*) seed))

(defcfun ("dsfmt_gen_rand_all" dsfmt-gen-rand-all) :void
  (dsfmt (:pointer (:struct dsfmt-t))))

(defun dsfmt-genrand-close1-open2 (dsfmt-ptr)
  (let ((idx (getf (mem-ref dsfmt-ptr '(:struct dsfmt-t)) 'idx)))
    (when (>= idx *dsfmt-n64*)
      (dsfmt-gen-rand-all dsfmt-ptr)
      (setf (foreign-slot-value dsfmt-ptr '(:struct dsfmt-t) 'idx) 0)))
  (with-foreign-slots ((status idx) dsfmt-ptr (:struct dsfmt-t))
    (with-foreign-slots ((u u32 d) status (:union w128-t))
      (incf (foreign-slot-value dsfmt-ptr '(:struct dsfmt-t) 'idx))
      (mem-aref d :double idx))))

(defun dsfmt-gv-genrand-close1-open2 ()
  (dsfmt-genrand-close1-open2 (get-var-pointer '*dsfmt-global-data*)))
