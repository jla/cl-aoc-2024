(in-package :cl-user)
(ql:quickload "str")

(defpackage :cl-aoc-2024.d01
  (:use :cl))
(in-package :cl-aoc-2024.d01)

;; https://adventofcode.com/2024/day/1

(defparameter *intput* "\
3   4
4   3
2   5
1   3
3   9
3   3
")

(defparameter *lists*
  (apply #'mapcar #'list
         (mapcar #'(lambda (line)
                     (mapcar #'parse-integer (str:words line)))
                 (str:lines *intput* :omit-nulls t))))


;; --- Day 1: Historian Hysteria ---

(print
 (reduce #'+
         (apply #'mapcar
                #'(lambda (x y) (abs  (- x y)))
                (mapcar #'(lambda (x) (sort (copy-seq x) #'<))
                        *lists*))))

;; --- Part Two ---

(print
 (reduce #'+
         (loop :for x in (first *lists*)
               :collect (* x (count x (second *lists*)))
               )))
