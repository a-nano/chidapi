(in-package :chidapi)

(defun enumerate (&optional (vendor-id #x0000) (product-id #x0000))
  (let (devices ret)
    (unwind-protect
	 (progn
	   (setf devices (hid-enumerate vendor-id product-id))
	   (setf ret
		 (loop
		    for p = devices then (getf d :next)
		    for d = (unless (cffi:null-pointer-p p)
			      (cffi:mem-ref p '(:struct hid-device-info)))
		    while d
		    collect (alexandria:remove-from-plist d :next))))
      (when devices
	(hid-free-enumeration devices)))
    ret))

(defun call-with-hid-device (thunk vendor-id product-id serial-number path)
  (let ((device nil))
    (unwind-protect
	 (progn
	   (setf device (if path
			    (hid-open-path path)
			    (hid-open vendor-id product-id
				      (or serial-number (null-pointer)))))
	   (funcall thunk (if (null-pointer-p device) nil device)))
      (hid-close device))))

(defmacro with-hid-device ((device &key (vendor-id 0) (product-id 0) serial-number path) &body body)
  `(call-with-hid-device (lambda (,device) ,@body)
			 ,vendor-id ,product-id ,serial-number ,path))

(defmacro get-string (fun device)
  `(with-foreign-pointer-as-string (s 1024 :encoding +wchar-encoding+)
     (setf (mem-aref s :unsigned-int) 0)
     (when (minusp (,fun ,device s 256))
       (error (format nil "hidapi ~a failed" ,fun)))))

(defun get-manufacturer-string (device)
  (get-string hid-get-manufacturer-string device))

(defun get-product-string (device)
  (get-string hid-get-product-string device))

(defun get-serial-number-string (device)
  (get-string hid-get-serial-number-string device))

(defun get-indexed-string (device index)
  (with-foreign-pointer-as-string (s 1024 :encoding +wchar-encoding+)
    (setf (mem-aref s :unsigned-int) 0)
    (when (minusp (hid-get-indexed-string device index s 256))
      (error (format nil "hidapi ~a failed" hid-get-indexed-string)))))
