
;; @func orc-battle
;; @desc Top level function that initiates a game, runs the game loop (REPL) and also prints win/lose messages.

(defun orc-battle ()
                  (init-player)
                  (init-monsters)
                  (game-loop)
                  (when (player-dead)
                        (princ "You were killed by the orcs. Game over!"))
                  (when (monsters-dead)
                        (princ "Congratulations Commodore! You have vanquished all your foes!")))


;; @func game-loop
;; @desc The game REPL function.

(defun game-loop ()
                 (unless (or (player-dead) (monsters-dead))
                         (show-player)
                         (dotimes (k (1+ (truncate (/ (max 0 *player-agility*) 15))))
                                  (unless (monsters-dead)
                                          (show-monsters)
                                          (player-attack)))
                         (fresh-line)
                         (map 'list (lambda (m)
                                            (or (monster-dead m) (monster-attack m)))
                                    *monsters*)
                         (game-loop)))
