(in-package :cl-user)

(ql:quickload "str")

(defpackage :cl-aoc-2024.d05
  (:use :cl))

(in-package :cl-aoc-2024.d05)

;; https://adventofcode.com/2024/day/5


(defparameter *input* "\
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
")


;; --- Day 5: Print Queue ---


(print
 (let ((rules '())
       (updates '()))
   (loop for line in (str:lines *input* :omit-nulls t) do
     (if (= 5 (length line))
         (push (mapcar #'parse-integer (str:split "|" line)) rules)
         (push (mapcar #'parse-integer (str:split "," line)) updates)
         ))
   (loop for update in updates
         summing (if (every #'identity
                            (loop for first-page in update
                                  for second-page in (cdr update)
                                  while (and first-page second-page)
                                  collect (loop for rule in rules
                                                do (if (and
                                                        (= (first rule) first-page)
                                                        (= (second rule) second-page))
                                                       (return t)))))
                     (nth (floor (length update) 2) update)
                     0
                     ))))


;; --- Part Two ---


(print
 (let ((rules '())
       (updates '()))
   (loop for line in (str:lines *input* :omit-nulls t) do
     (if (= 5 (length line))
         (push (mapcar #'parse-integer (str:split "|" line)) rules)
         (push (mapcar #'parse-integer (str:split "," line)) updates)
         ))
   (loop for update in updates
         summing (if (every #'identity
                            (loop for first-page in update
                                  for second-page in (cdr update)
                                  while (and first-page second-page)
                                  collect (loop for rule in rules
                                                do (if (and
                                                        (= (first rule) first-page)
                                                        (= (second rule) second-page))
                                                       (return t)))))
                     0 ;; correctly-ordered update
                     (nth (floor (length update) 2)
                          (stable-sort update #'(lambda (x y)
                                                  (member `(,x ,y) rules :test #'equal) )))
                     ))))
