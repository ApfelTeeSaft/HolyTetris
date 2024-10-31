# HolyTetris

This is a simple Tetris clone written in HolyC for TempleOS. Use the arrow keys and spacebar to control the falling pieces, clear lines, and score points!

## How to Run the Game

1. **Save the Code**:
   - Copy the Tetris code into a new file in TempleOS named `Tetris.HC`.

2. **Load and Run the Game**:
   - Open TempleOS, and at the command prompt, type:
     ```c
     #include "Tetris.HC"
     Tetris();
     ```
   - The game will start, and you can begin playing immediately.

## Game Controls

| Key       | Action                                  |
|-----------|----------------------------------------|
| `←`       | Move the piece left                    |
| `→`       | Move the piece right                   |
| `↑`       | Rotate the piece                       |
| `SPACE`   | Speed up the piece's descent           |

- **Scoring**: You score points by completing rows, which are cleared automatically when filled.
- **Game Over**: The game ends when pieces stack up to the top of the play area.

## Additional Notes

- **Normal Drop Speed**: Pieces descend at a regular pace, controlled by the game’s internal timer.
- **Increased Speed with Spacebar**: Holding down the spacebar doubles the drop speed, making it easier to position pieces quickly.