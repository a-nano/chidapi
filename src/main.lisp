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
		       
