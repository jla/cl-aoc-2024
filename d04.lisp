(in-package :cl-user)
(ql:quickload "str")
(ql:quickload "cl-ppcre")
(defpackage :cl-aoc-2024.d04
  (:use :cl))
(in-package :cl-aoc-2024.d04)

;; https://adventofcode.com/2024/day/4

(defparameter *input* "\
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
")


;; --- Day 4: Ceres Search ---


(print
 (let* ((lines (str:lines *input* :omit-nulls t))
        (m (length lines))
        (n (reduce #'max (mapcar #'length lines)))
        (rows  (make-array m :initial-element ""))
        (cols  (make-array n :initial-element ""))
        (minor (make-array (1- (+ m n)) :initial-element ""))
        (major (make-array (1- (+ m n)) :initial-element "")))
   (loop for line in lines
         for i from 0 do
           (loop for c across line
                 for j from 0 do
                   (progn
                     (setf (aref rows i) (concatenate 'string (aref rows i) (string c) ))
                     (setf (aref cols j) (concatenate 'string (aref cols j) (string c) ))
                     (setf (aref minor (+ i j)) (concatenate 'string (aref minor (+ i j)) (string c)))
                     (setf (aref major (+ (- i j) (- n 1))) (concatenate 'string (aref major (+ (- i j) (- n 1))) (string c)))
                     )))
   (reduce (lambda (acc str) (+ acc (ppcre:count-matches "(?=(XMAS|SAMX))" str))) (concatenate 'vector rows cols minor major) :initial-value 0)))



;; --- Part Two ---


(print
 (let* ((lines (str:lines *input* :omit-nulls t))
        (m (length lines))
        (a (make-array `(,m ,m) :initial-element "")))
   (loop for line in lines
         for i from 0 do
           (loop for c across line
                 for j from 0 do
                   (setf (aref a i j) c)))
   (loop for i from 1 to (- m 2)
         summing
         (loop for j from 1 to (- m 2)
               counting
               (and
                (eq (aref a i j) #\A)
                (or
                 (and (eq (aref a (1- i) (1- j)) #\M)
                      (eq (aref a (1+ i) (1+ j)) #\S))
                 (and (eq (aref a (1- i) (1- j)) #\S)
                      (eq (aref a (1+ i) (1+ j)) #\M)))
                (or
                 (and (eq (aref a (1- i) (1+ j)) #\M)
                      (eq (aref a (1+ i) (1- j)) #\S))
                 (and (eq (aref a (1- i) (1+ j)) #\S)
                      (eq (aref a (1+ i) (1- j)) #\M)))
                )))))
