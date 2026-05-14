#|
Author:       Muhammad Danish Zahin Bin Rafizal
E-mail:       mjr7066@psu.edu
Course:       CMPSC 460
Assignment:   Lisp Programming Project
Due date:     4/6/2026
File:         FoodOrder.LISP
Purpose:      This program uses random-number generation to create food orders
              from lists of different categories of food items. It also allows
              the user to add food items to or remove food items from the lists
              initially provided. The program loops until the user decides that
              s/he is done creating food orders.
IDE/Compiler: SBCL 2.6.3 (Steel Bank Common Lisp)
Extensions: Common Lisp Extensions for VScode
Operating system: MS Windows 11
References:   Web sites listed on our course Programming Language Resources page
              Lisp interactive sessions and demo functions posted on our course
              Demo Programs page
              GeekforGeeks websites
              multiple-value-setq documentation: https://novaspec.org/cl/f_multiple-value-setq
AI Tool(s):   GITHUB Copilot
|#


; Function to display the main menu of options
(defun display-main-menu ()
  (format t "~%MENU OPTIONS:~%")
  (format t "1) Generate a food order~%")
  (format t "2) Add a food item~%")
  (format t "3) Remove a food item~%")
  (format t "4) Quit~%"))


; Function to display the submenu of food item categories
(defun display-sub-menu ()
  (format t "~%FOOD ITEM TYPES:~%")
  (format t "1) Sandwich~%")
  (format t "2) Side~%")
  (format t "3) Beverage~%")
  (format t "4) Dessert~%"))


; Function to display all four food item lists
(defun display-all-lists (sandwiches sides beverages desserts)
  (format t "~%Current food items lists:~%")
  (format t "Sandwiches: ~a~%" sandwiches)
  (format t "Sides      : ~a~%" sides)
  (format t "Beverages  : ~a~%" beverages)
  (format t "Desserts   : ~a~%" desserts))


; Function to get and validate the user's main menu choice (1-4)
(defun get-main-choice ()
  (format t "Please enter your choice:~%")
  (force-output)
  (let ((choice (read)))
    (if (and (integerp choice) (>= choice 1) (<= choice 4))
        choice
        (progn
          (format t "Invalid choice! Please re-enter.~%")
          (force-output)
          (get-main-choice)))))


; Function to get and validate the user's submenu choice (1-4)
(defun get-sub-choice ()
  (format t "Please enter your choice:~%")
  (force-output)
  (let ((choice (read)))
    (if (and (integerp choice) (>= choice 1) (<= choice 4))
        choice
        (progn
          (format t "Invalid choice! Please re-enter.~%")
          (force-output)
          (get-sub-choice)))))


; Function to generate a random food order by selecting one item from each list
; Returns a list containing the four selected food items
(defun generate-food-order (sandwiches sides beverages desserts)
  (let ((order '()))
    (setf order (append order (list (nth (random (length sandwiches)) sandwiches))))
    (setf order (append order (list (nth (random (length sides)) sides))))
    (setf order (append order (list (nth (random (length beverages)) beverages))))
    (setf order (append order (list (nth (random (length desserts)) desserts))))
    (format t "~%Random food order:~%")
    (format t "~a, ~a, ~a, ~a~%" (first order) (second order) (third order) (fourth order))
    order))


; Function to add a food item to a specific list if it is not already present
; Returns the updated list
(defun add-food-item (food-list list-name)
  (format t "Please enter your food item:~%")
  (force-output)
  (let ((item (read)))
    (if (member item food-list)
        (progn
          (format t "~a : ~a~%" list-name food-list)
          food-list)
        (let ((updated-list (append food-list (list item))))
          (format t "~a : ~a~%" list-name updated-list)
          updated-list))))


; Function to remove a food item from a specific list
; Does nothing if the list is empty or the item is not found
; Returns the (possibly unchanged) list
(defun remove-food-item (food-list list-name)
  (if (null food-list)
      (progn
        (format t "~a : ~a~%" list-name food-list)
        food-list)
      (progn
        (format t "Please enter your food item:~%")
        (force-output)
        (let* ((item (read))
               (updated-list (remove item food-list)))
          (format t "~a : ~a~%" list-name updated-list)
          updated-list))))


; Function to handle the "add a food item" option (menu choice 2)
; Displays all lists, shows submenu, routes to correct list based on category choice
; Returns updated lists as multiple values
(defun handle-add (sandwiches sides beverages desserts)
  (display-all-lists sandwiches sides beverages desserts)
  (display-sub-menu)
  (let ((sub-choice (get-sub-choice)))
    (cond
      ((= sub-choice 1)
       (let ((new-sandwiches (add-food-item sandwiches "Sandwiches")))
         (values new-sandwiches sides beverages desserts)))
      ((= sub-choice 2)
       (let ((new-sides (add-food-item sides "Sides      ")))
         (values sandwiches new-sides beverages desserts)))
      ((= sub-choice 3)
       (let ((new-beverages (add-food-item beverages "Beverages  ")))
         (values sandwiches sides new-beverages desserts)))
      ((= sub-choice 4)
       (let ((new-desserts (add-food-item desserts "Desserts   ")))
         (values sandwiches sides beverages new-desserts))))))


; Function to handle the "remove a food item" option (menu choice 3)
; Displays all lists, shows submenu, routes to correct list based on category choice
; Returns updated lists as multiple values
(defun handle-remove (sandwiches sides beverages desserts)
  (display-all-lists sandwiches sides beverages desserts)
  (display-sub-menu)
  (let ((sub-choice (get-sub-choice)))
    (cond
      ((= sub-choice 1)
       (let ((new-sandwiches (remove-food-item sandwiches "Sandwiches")))
         (values new-sandwiches sides beverages desserts)))
      ((= sub-choice 2)
       (let ((new-sides (remove-food-item sides "Sides      ")))
         (values sandwiches new-sides beverages desserts)))
      ((= sub-choice 3)
       (let ((new-beverages (remove-food-item beverages "Beverages  ")))
         (values sandwiches sides new-beverages desserts)))
      ((= sub-choice 4)
       (let ((new-desserts (remove-food-item desserts "Desserts   ")))
         (values sandwiches sides beverages new-desserts))))))


; Main loop function that drives the program
; Initializes the four food lists and loops until the user chooses to quit
(defun loop-program ()
  (let ((sandwiches '(blt tuna-salad grilled-cheese hamburger cheesesteak))
        (sides      '(tossed-salad pasta-salad fries onion-rings chips))
        (beverages  '(lemonade iced-tea water soda coffee))
        (desserts   '(ice-cream cake pie brownie cookies)))
    (loop
      (display-main-menu)
      (let ((choice (get-main-choice)))
        (cond
          ((= choice 1)
           (generate-food-order sandwiches sides beverages desserts))
          ((= choice 2)
           (multiple-value-setq (sandwiches sides beverages desserts)
             (handle-add sandwiches sides beverages desserts)))
          ((= choice 3)
           (multiple-value-setq (sandwiches sides beverages desserts)
             (handle-remove sandwiches sides beverages desserts)))
          ((= choice 4)
           (format t "~%\"Thank you for using my Food Order Generator!\"~%")
           (return)))))))