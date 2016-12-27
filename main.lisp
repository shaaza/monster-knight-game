;; Entry point file for the game.

;; Load global variables tracking player state
(load "src/global-vars.lisp")

;; Load monster classes, their methods and other helper functions
(load "src/monsters.lisp")

;; Load player classes, their methods and other helper functions
(load "src/players.lisp")

;; Load the REPL and top level function
(load "src/game.lisp")

;; Run the game
(orc-battle)
