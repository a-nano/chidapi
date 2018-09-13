(defsystem "chidapi"
  :class :package-inferred-system
  :version "0.1.0"
  :author "Akihide Nano"
  :license "BSD 2-Clause"
  :description "hidapi rapper for common lisp"
  :components ((:module "src"
			:serial t
			:components
			((:file "package")
			 (:file "hidapi")
			 (:file "main"))))
  :depends-on ("cffi"))
