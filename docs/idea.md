### Idea
15 Piece slide puzzle might seem a bit borring and too familliar, if you're a 90s kid
Puzzle in phisical form quickly becomes borring as it always looks the same.
From the math point of view this puzzle is quite interesting, there are 16! possible puzzles and only half
of them is solvable while not violating rules: puzzle pieces are constrained to slide into blank spot
(in this puzzle blank spot is number 16)

The point of this puzzle is to make every of the solvable puzzle unique by using generated image / animation
based on initial puzzle seed. 
Impossible to solve puzzles are solvable in "hack mode" using console and literally being a cheater.
For this reason tiles will be placed and animated on Stack plane / teleport into different possitions. 

## Play mode and Hack mode
Hack mode allows player to move puzzle pieces without restriction to the rules. 
It is a new, only possible in virtual world way to solve 15 puzzle. It is a mix of human-sorting and tactics.
I imagine that interaction with hack mode should be possible using keyboard and console, tho on mobile it would not be super friendly so click to swap is also a possibility. 
Hack mode changes appearance of the board. 
It is possible to:
* swap numbers: "10-13" : " 1-16 2-16 " out of bounds characters are not interpreted eg.: "1-50" "1-Z"
* slide by one tile left, right, up, down in the direction of the gap: [a-left] [d-right] [w-up] [s-down] (wrong moves do not incrise move count, possible to count mistakes count), slide whole row/column using uppercase letters: [A-left-whole] [D-right-whole] [W-up-whole] [S-down-whole] 

## Link to app state (deep linking)
There are several 15 puzzles online but all of them lack ability to allow player to enter their own puzzles.
It should be possible to initialize puzzle with link containing:
Path params:
* (required param) seed (seed is composed of alphanumeric characters that map from 1 to 16)
/{seed}

Changing puzzle should be also possible to do from the app for non techy users, because it is also not that 
easy to map numbers to characters on the go (Entering numbers array)

## Competing with friends
It would be cool to compete with friends. The timer should start preferably at the same time (eg. 20:10)/ maybe at the time user opens the puzzle. Link with the challange should contain info about hack mode (if it is possible to cheat or not).
When puzzle is finished there is a time result and number of swaps made 
Query params:
* (optional param) start - start time - time in local time  e.g.: "start=20:30"
* (optional param) hack - is puzzle in hack mode e.g.: "hack=true" "hack=nohack" (any other word does not change anything, unless it's not true)

/{seed}?start=20:30&puzzle=hack
/{seed}?puzzle=hack

## Achievement and validation
Can generate result screen with link
Preferably user's achievements - stats - should be verifiable and not possible to counterfit - possible with
custom backend (Sounds like super fun - post MVP)

## Notes
This is mainly a web app - parsing and updating address bar is important
Trying to use Flutter's favorite packages whenever possible (Good practice)
