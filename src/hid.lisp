(in-package :cl-hid)

(defun set-library (path)
  (push path cffi:*foreign-library-directories*))

(cffi:defcstruct hid-device)

(defun load-library ()
  (cffi:load-foreign-library "libhidapi-0")
  
  (cffi:defcfun ("hid_init" hid-init) :int)
  
  (cffi:defcfun ("hid_exit" hid-exit) :int)
  
  (cffi:defcfun ("hid_open" hid-open) (:pointer (:struct hid-device))
    (vendor-id :ushort)
    (product-id :ushort)
    (serial-number (:pointer :uchar)))
  t)

