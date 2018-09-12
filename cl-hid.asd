(defsystem "cl-hid"
  :class :package-inferred-system
  :version "0.1.0"
  :author "Akihide Nano"
  :license "BSD 2-Clause"
  :description "hid device control"
  :components ((:module "src"
			:serial t
			:components
			((:file "package")
			 (:file "hid")
			 (:file "main"))))
  :depends-on ("cffi"))
