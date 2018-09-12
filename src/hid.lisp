(in-package :cl-hid)

(defclass device ()
  ((handle
    :initarg :handle
    :initform nil
    :accessor handle)
   (ol
    :initform nil
    :accessor ol)))

(cffi:define-foreign-library hid
    (t (:default "hid")))

(cffi:load-foreign-library 'hid)

(cffi:defcstruct hidd-attributes
  (size :int)
  (vendor-id :short)
  (product-id :short)
  (version-number :short))

(cffi:defcstruct guid
  (data1 :uint32)
  (data2 :uint16)
  (data3 :uint16)
  (data4 :uint8 :count 8))

(cffi:defcfun ("HidD_GetHidGuid" hid-get-hid-guid)
    :void
  (guid (:pointer (:struct guid))))

(cffi:defcfun ("HidD_GetAttributes" hid-get-attributes)
    :int
  (device :pointer)
  (attributes (:pointer (:struct hidd-attributes))))

(cffi:defcfun ("HiD_SetOutputReport" hid-set-output-report)
    :int
  (device :pointer)
  (buf :pointer)
  (length :uint))

(cffi:defcfun ("memset" hid-memset)
    :pointer
  (dst :pointer)
  (value :uint)
  (count :uint))
