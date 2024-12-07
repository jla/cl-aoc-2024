(in-package :cl-user)

(ql:quickload "str")
(ql:quickload "alexandria")

(defpackage :cl-aoc-2024.d06
  (:use :cl))

(in-package :cl-aoc-2024.d06)

;; https://adventofcode.com/2024/day/6

(defparameter *input* "\
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
")


;; --- Day 6: Guard Gallivant ---

(print
 (let* ((lines (str:lines *input* :omit-nulls t))
        (m (length lines))
        (n (length (first lines)))
        (x 0)
        (y 0)
        (a (make-array `(,m ,n) :initial-contents
                       (loop for line in lines
                             for i from 0
                             collect (loop for c across line
                                           for j from 0
                                           collect (case c
                                                     (#\# t)
                                                     (#\^ (progn (setf x i y j) nil))
                                                     ))))))
   (let ((positions `((,x ,y))))
     (loop with dirs = '((-1 0) (0 1) (1 0) (0 -1))
           with dir  = 0
           do (let ((x1 (+ x (first (nth dir dirs))))
                    (y1  (+ y (second (nth dir dirs)))))
                (if (or (< x1 0) (>= x1 m) (< y1 0) (>= y1 n)) (return))
                (if (aref a x1 y1)
                    (setf dir (mod (1+ dir) 4))
                    (progn
                      (push `(,x1 ,y1) positions)
                      (setf x x1 y y1)))))
     (length (remove-duplicates positions :test #'equal))
     )))


;; --- Part Two ---

(print
 (let* ((lines (str:lines *input* :omit-nulls t))
        (m (length lines))
        (n (length (first lines)))
        (x 0)
        (y 0)
        (a (make-array `(,m ,n) :initial-contents
                       (loop for line in lines
                             for i from 0
                             collect (loop for c across line
                                           for j from 0
                                           collect (case c
                                                     (#\# t)
                                                     (#\^ (progn (setf x i y j) nil))
                                                     ))))))
   (let ((positions ())
         (obstacles 0)
         (x0 x)
         (y0 y))
     (loop with dirs = '((-1 0) (0 1) (1 0) (0 -1))
           with dir  = 0
           do (let ((x1 (+ x (first (nth dir dirs))))
                    (y1  (+ y (second (nth dir dirs)))))
                (if (or (< x1 0) (>= x1 m) (< y1 0) (>= y1 n)) (return))
                (if (aref a x1 y1)
                    (setf dir (mod (1+ dir) 4))
                    (progn
                      (push `(,x1 ,y1) positions)
                      (setf x x1 y y1)))))

     (loop for p in (remove-duplicates positions :test #'equal)
           do (let  ((positions `((,x0 ,y0 0))))
                (setf x x0 y y0)
                (setf (apply #'aref a p) t)
                (loop with dirs = '((-1 0) (0 1) (1 0) (0 -1))
                      with dir  = 0
                      do (let ((x1 (+ x (first (nth dir dirs))))
                               (y1  (+ y (second (nth dir dirs)))))
                           (if (or (< x1 0) (>= x1 m) (< y1 0) (>= y1 n))
                               (return))
                           (if (aref a x1 y1)
                               (setf dir (mod (1+ dir) 4))
                               (let ((position `(,x1 ,y1 ,dir)))
                                 (if (member position positions :test #'equal)
                                     (progn
                                       (incf obstacles)
                                       (return)))
                                 (push position positions)
                                 (setf x x1 y y1)))))
                (setf (apply #'aref a p) nil)))
     obstacles
     )))
