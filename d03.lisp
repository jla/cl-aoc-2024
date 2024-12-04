(in-package :cl-user)
(ql:quickload "cl-ppcre")

(defpackage :cl-aoc-2024.d03
  (:use :cl))
(in-package :cl-aoc-2024.d03)

;; https://adventofcode.com/2024/day/3

(defparameter *input* "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")


;; --- Day 3: Mull It Over ---

(print
 (let ((sum 0))
   (ppcre:do-register-groups (a b)
       ("mul\\((\\d{1,3}),(\\d{1,3})\\)" *input*)
     (when (and a b)
       (incf sum (* (parse-integer a) (parse-integer b)))))
   sum))


;; --- Part Two ---

(defparameter *input* "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")

(print
 (let ((enabled t)
       (sum 0))
   (ppcre:do-register-groups (a b do dont)
       ("mul\\((\\d{1,3}),(\\d{1,3})\\)|(do\\(\\))|(don't\\(\\))" *input*)
     (progn
       (when do
         (setf enabled t))
       (when dont
         (setf enabled nil))
       (when (and enabled a b)
         (incf sum (* (parse-integer a) (parse-integer b))))))
   sum))
