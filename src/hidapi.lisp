(in-package :chidapi)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant +wchar-encoding+
    #-windows :utf-32le
    #+windows :utf-16le))

(define-foreign-library hidapi
  (:windows (:or "libhidapi-0"
		 "libhidapi"))
  (:unix (:or "libhidapi-libsub"
	      "libhidapi-hidraw")))

(use-foreign-library hidapi)

(defctype wchar-t* (:string :encoding #.+wchar-encoding+))
(defctype size-t :unsigned-long)

(defcstruct hid-device)
(defctype hid-device* (:pointer (:struct hid-device)))

(defcstruct hid-device-info
  (:path :string)
  (:vendor-id :unsigned-short)
  (:product-id :unsigned-short)
  (:serial-number wchar-t*)
  (:release-number :unsigned-short)
  (:manufacturer-string wchar-t*)
  (:product-string wchar-t*)
  (:usage-page :unsigned-short)
  (:usage :unsigned-short)
  (:interface-number :int)
  (:next (:pointer #++(:struct hid-device-info))))
(defctype hid-device-info* (:pointer (:struct hid-device-info)))

(defcfun ("hid_init" hid-init) :int)

(defcfun ("hid_exit" hid-exit) :int)

(defcfun ("hid_enumerate" hid-enumerate) hid-device-info*
  (vendor-id :unsigned-short)
  (product-id :unsigned-short))

(defcfun ("hid_free_enumeration" hid-free-enumeration) :void
  (devs hid-device-info*))

(defcfun ("hid_open" hid-open) hid-device*
  (vendor-id :ushort)
  (product-id :ushort)
  (serial-number wchar-t*))
    
(defcfun ("hid_open_path" hid-open-path) hid-device*
  (path (:pointer :char)))

(defcfun ("hid_write" hid-write) :int
  (device hid-device*)
  (data (:pointer :uchar))
  (length size-t))

(defcfun ("hid_read_timeout" hid-read-timeout) :int
  (dev hid-device*)
  (data (:pointer :unsigned-char))
  (length size-t)
  (milliseconds :int))

(defcfun ("hid_read" hid-read) :int
  (device hid-device*)
  (data (:pointer :unsigned-char))
  (length size-t))

(defcfun ("hid_set_nonblocking" hid-set-nonblocking) :int
  (device hid-device*)
  (nonblock :int))

(defcfun ("hid_send_feature_report" hid-send-feature-report) :int
  (device hid-device*)
  (data (:pointer :unsigned-char))
  (length size-t))

(defcfun ("hid_close" hid-close) :void
  (device hid-device*))

(defcfun ("hid_get_manufacturer_string" hid-get-manufacturer-string) :int
  (device hid-device*)
  (string wchar-t*)
  (maxlen size-t))

(defcfun ("hid_get_product_string" hid-get-product-string) :int
  (device hid-device*)
  (string wchar-t*)
  (maxlen size-t))

(defcfun ("hid_get_serial_number_string" hid-get-serial-number-string) :int
  (device hid-device*)
  (string wchar-t*)
  (maxlen size-t))

(defcfun ("hid_get_indexed_string" hid-get-indexed-string) :int
  (device hid-device*)
  (string-index :int)
  (string wchar-t*)
  (maxlen size-t))

(defcfun ("hid_error" hid-error) wchar-t*
  (device hid-device*))
