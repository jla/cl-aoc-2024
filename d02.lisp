(in-package :cl-user)
(ql:quickload "str")

(defpackage :cl-aoc-2024.d02
  (:use :cl))
(in-package :cl-aoc-2024.d02)

;; https://adventofcode.com/2024/day/2

(defparameter *input* "\
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
")


(defparameter *reports*
  (mapcar #'(lambda (line)
              (mapcar #'parse-integer (str:words line)))
          (str:lines *input* :omit-nulls t)))



;; --- Day 2: Red-Nosed Reports ---

(print
 (reduce #'+
         (loop :for report in *reports*
               :collect (let ((diff (mapcar #'- (cdr report) report)))
                          (cond
                            ((every (lambda (level) (and (>= level  1) (<= level  3))) diff) 1)
                            ((every (lambda (level) (and (>= level -3) (<= level -1))) diff) 1)
                            (t 0))))))


;; --- Part Two ---

(defun remove-nth (n lst)
  (cond ((< n  0) lst)
        ((= n  0) (cdr lst))
        (t (cons (car lst)
            (remove-nth (1- n)
                (cdr lst))))))


(defun check-report (report &optional (exclude-index -1))
  (when (>= exclude-index (length report)) (return-from check-report 0))
  (let* ((subreport (remove-nth exclude-index report))
         (diff (mapcar #'- (cdr subreport) subreport)))
    (if (or (every (lambda (level) (and (>= level  1) (<= level  3))) diff)
            (every (lambda (level) (and (>= level -3) (<= level -1))) diff))
        1
        (check-report report (1+ exclude-index)))))


(print
 (reduce #'+
         (loop :for report in *reports*
               :collect (check-report report))))

