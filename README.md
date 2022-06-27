# Flutter Puzzle Hack
An app for a Flutter hackathon for reimagining classic 15 Piece Puzzle, hosted on [devpost](https://flutterhack.devpost.com/)  
###### "Push your creativity to its limits by reimagining this classic puzzle!"

## [❯❯ PLAY THE GAME HERE](https://flutter-puzzle-hack-75f98.web.app/#/)

<img src="https://github.com/Rongix/flutter_puzzle_hack/blob/main/resources/project_logo.png"/>


## About
The game uses a seed to determine starting conditions: gameplay shape and numbers distribution. The game seed is in the URL (this is a seed for starting conditions).
An application uses multiple animated widgets to morph between animated shapes, align puzzle pieces, and delay effects.

## Getting Started
The application does not depend on code generation. It should be possible to run it after fetching dependencies.   
There are two packages in the repository:
- app (multiplatform application)
- sixteen_puzzle (generator of 15 Piece Puzzle)

Run the following setup script from the root of the repository:
```zsh
sh scripts/setup.sh
```

## Gameplay
Move tiles with your mouse or keyboard (awsd && arrow keys) 
Press and hold shift to move whole rows/columns
Moves in consecutive directions will count as one move.

## Screens from the game
<img src="https://github.com/Rongix/flutter_puzzle_hack/blob/main/resources/start.jpeg"/>
<img src="https://github.com/Rongix/flutter_puzzle_hack/blob/main/resources/example_1.jpeg"/>
<img src="https://github.com/Rongix/flutter_puzzle_hack/blob/main/resources/example_2.jpeg"/>
