;; Player
;; @func init-player
;; @desc Instantiate a player object with full health, strength etc.

(defun init-player ()
                   (setf *player-health* 30)
                   (setf *player-strength* 30)
                   (setf *player-agility* 30))

;; Player Methods

;; @func player-dead
;; @desc Nullify players health when he dies.

(defun player-dead ()
                   (<= *player-health* 0))

;; @func show-player
;; @desc Display player stats.

(defun show-player ()
                   (fresh-line)
                   (princ "You are a valiant knight with a health of ")
                   (princ *player-health*)
                   (princ ", agility ")
                   (princ *player-agility*)
                   (princ ", and strength ")
                   (princ *player-strength*)
                   (princ "."))

;; @func player-attack
;; @desc Let the player attack one of the monsters of his choice.

(defun player-attack ()
                     (fresh-line)
                     (princ "Attack style: [s]tab, [d]ouble swing, [r]oundhouse:")
                     (case (read)
                           (s (monster-hit (pick-monster) (+ 2 (randval (ash *player-strength* -1)))))
                           (d (let ((x (randval (truncate (/ *player-strength* 6)))))
                                   (princ "Your double swing has a strength of ")
                                   (princ x)
                                   (fresh-line)
                                   (monster-hit (pick-monster) x)
                                   (unless (monsters-dead)
                                           (monster-hit (pick-monster) x))))
                           (otherwise (dotimes (x (1+ (randval (truncate (/ *player-strength* 3)))))
                                               (unless (monsters-dead)
                                                       (monster-hit (random-monster) 1))))))


;; Helper functions

;; @func randval
(defun randval (n)
               (1+ (random (max 1 n))))

;; @func random-monster
;; @desc Picks a random monster

(defun random-monster ()
                      (let ((m (aref *monsters* (random (length *monsters*)))))
                           (if (monster-dead m)
                               (random-monster)
                               m)))
;; @func pick-monster
;; @desc Allows user to pick a monster.

(defun pick-monster ()
                    (fresh-line)
                    (princ "Monster #: ")
                    (let ((x (read)))
                         (if (not (and (integerp x) (>= x 1) (<= x *monster-num*)))
                             (progn (princ "That is a not a valid monster.")
                                    (pick-monster))
                             (let ((m (aref *monsters* (1- x))))
                                  (if (monster-dead m)
                                      (progn (princ "That monster is already dead. Pick another one.")
                                             (pick-monster))
                                      m)))))
