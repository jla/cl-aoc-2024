(in-package :cl-user)

(ql:quickload "str")

(defpackage :cl-aoc-2024.d07
  (:use :cl))

(in-package :cl-aoc-2024.d07)

;; https://adventofcode.com/2024/day/7

(defparameter *input* "\
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
")

;; --- Day 7: Bridge Repair ---

(defun extract-equations (input)
  (loop for line in (str:lines input :omit-nulls t)
        collect (let ((words (str:words line)))
                  (list (parse-integer (str:substring 0 -1 (car words))) (mapcar #'parse-integer (cdr words))))))

(defun solvable (x y ops)
  (if (= (length x) 1)
      (= (first x) y)
      (loop for op in ops
            thereis (solvable (cons (funcall op (first x) (second x)) (subseq x 2) ) y ops))))


(print
 (loop for equation in (extract-equations *input*)
       summing (if (solvable (second equation) (first equation) '(+ *))
                   (first equation)
                   0)))


;; --- Part Two ---

(defun || (a b)
  (parse-integer (format nil "~a~a" a b)))


(print
 (loop for equation in (extract-equations *input*)
       summing (if (solvable (second equation) (first equation) '(+ * ||))
                   (first equation)
                   0)))
