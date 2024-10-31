// Tetris Clone in TempleOS (HolyC)

// HolyTetris
#include "std/Kernel.h"

const int WIDTH = 10, HEIGHT = 20;
int board[WIDTH][HEIGHT];
int score = 0;

int tetrominoes[7][4][4][4] = {
    // I Piece
    {
        {{1, 1, 1, 1},
         {0, 0, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 0, 0, 0},
         {1, 0, 0, 0},
         {1, 0, 0, 0}},

        {{1, 1, 1, 1},
         {0, 0, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 0, 0, 0},
         {1, 0, 0, 0},
         {1, 0, 0, 0}}
    },
    // J Piece
    {
        {{1, 1, 1, 0},
         {0, 0, 1, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{0, 1, 0, 0},
         {0, 1, 0, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 1, 1, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 1, 0, 0},
         {1, 0, 0, 0},
         {1, 0, 0, 0},
         {0, 0, 0, 0}}
    },
    // L Piece
    {
        {{1, 1, 1, 0},
         {1, 0, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 1, 0, 0},
         {0, 1, 0, 0},
         {0, 1, 0, 0},
         {0, 0, 0, 0}},

        {{0, 0, 1, 0},
         {1, 1, 1, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 0, 0, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0}}
    },
    // O Piece
    {
        {{1, 1, 0, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 1, 0, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 1, 0, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 1, 0, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}}
    },
    // S Piece
    {
        {{0, 1, 1, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 1, 0, 0},
         {0, 1, 0, 0},
         {0, 0, 0, 0}},

        {{0, 1, 1, 0},
         {1, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 1, 0, 0},
         {0, 1, 0, 0},
         {0, 0, 0, 0}}
    },
    // T Piece
    {
        {{1, 1, 1, 0},
         {0, 1, 0, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{0, 1, 0, 0},
         {1, 1, 0, 0},
         {0, 1, 0, 0},
         {0, 0, 0, 0}},

        {{0, 1, 0, 0},
         {1, 1, 1, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 0, 0, 0},
         {1, 1, 0, 0},
         {1, 0, 0, 0},
         {0, 0, 0, 0}}
    },
    // Z Piece
    {
        {{1, 1, 0, 0},
         {0, 1, 1, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{0, 1, 0, 0},
         {1, 1, 0, 0},
         {1, 0, 0, 0},
         {0, 0, 0, 0}},

        {{1, 1, 0, 0},
         {0, 1, 1, 0},
         {0, 0, 0, 0},
         {0, 0, 0, 0}},

        {{0, 1, 0, 0},
         {1, 1, 0, 0},
         {1, 0, 0, 0},
         {0, 0, 0, 0}}
    }
};

int pieceType, pieceRotation, pieceX, pieceY;

void InitBoard() {
    for (int x = 0; x < WIDTH; ++x)
        for (int y = 0; y < HEIGHT; ++y)
            board[x][y] = 0;
}

void DrawBoard() {
    ClrScr();
    for (int x = 0; x < WIDTH; ++x) {
        for (int y = 0; y < HEIGHT; ++y) {
            if (board[x][y])
                PlotChar(x + 10, y + 2, '#', WHITE);
            else
                PlotChar(x + 10, y + 2, '.', GRAY);
        }
    }

    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            if (tetrominoes[pieceType][pieceRotation][i][j])
                PlotChar(pieceX + i + 10, pieceY + j + 2, '#', LIGHTBLUE);
        }
    }
    PrintAt(0, 0, "Score: %d", score);
}

// is piece out of bounds?
bool IsValidPosition(int newX, int newY, int newRotation) {
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            if (tetrominoes[pieceType][newRotation][i][j]) {
                int x = newX + i;
                int y = newY + j;
                if (x < 0 || x >= WIDTH || y >= HEIGHT || (y >= 0 && board[x][y]))
                    return FALSE;
            }
        }
    }
    return TRUE;
}

void PlacePiece() {
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            if (tetrominoes[pieceType][pieceRotation][i][j]) {
                board[pieceX + i][pieceY + j] = 1;
            }
        }
    }
}

// clear when line is full
void ClearLines() {
    for (int y = 0; y < HEIGHT; ++y) {
        bool fullLine = TRUE;
        for (int x = 0; x < WIDTH; ++x) {
            if (!board[x][y]) {
                fullLine = FALSE;
                break;
            }
        }
        if (fullLine) {
            // simple gravity impl
            for (int newY = y; newY > 0; --newY)
                for (int x = 0; x < WIDTH; ++x)
                    board[x][newY] = board[x][newY - 1];
            score += 10;
        }
    }
}

void NewPiece() {
    pieceType = Rand() % 7;
    pieceRotation = 0;
    pieceX = WIDTH / 2 - 2;
    pieceY = 0;
    if (!IsValidPosition(pieceX, pieceY, pieceRotation)) {
        PrintAt(0, 2, "Game Over!");
        Wait(100);
        exit();
    }
}

void Tetris() {
    InitBoard();
    NewPiece();

    int speed = 20;
    int dropCounter = 0;

    while (TRUE) {
        ++dropCounter;

        switch (KeyGet()) {
            case KEY_LEFT:
                if (IsValidPosition(pieceX - 1, pieceY, pieceRotation))
                    pieceX--;
                break;
            case KEY_RIGHT:
                if (IsValidPosition(pieceX + 1, pieceY, pieceRotation))
                    pieceX++;
                break;
            case KEY_UP:
                int newRotation = (pieceRotation + 1) % 4;
                if (IsValidPosition(pieceX, pieceY, newRotation))
                    pieceRotation = newRotation;
                break;
            case KEY_SPACE:
                speed = 10;
                break;
        }

        if (KeyPeek() != KEY_SPACE) {
            speed = 20;
        }

        if (dropCounter >= speed) {
            dropCounter = 0;
            if (IsValidPosition(pieceX, pieceY + 1, pieceRotation)) {
                pieceY++;
            } else {
                PlacePiece();
                ClearLines();
                NewPiece();
            }
        }

        DrawBoard();
        Wait(1);
    }
}