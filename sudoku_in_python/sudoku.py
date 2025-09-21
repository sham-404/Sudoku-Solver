from collections import defaultdict
from functools import lru_cache
import time
import numpy as np

""" 
Uncomment this if you are a windows user.
Before using, make sure to install colorama using
pip install colorama
"""

# import colorama
# colorama.init()

start = False
SPEED_FAC = (
    2  # Increase the value to decrease the speed of the animation and vice versa
)
ROW_SIZE = 9
COL_SIZE = 9


class Sudoku:
    valid_values = {i for i in range(1, ROW_SIZE + 1)}

    def __init__(self) -> None:
        self.row = defaultdict(set)
        self.col = defaultdict(set)
        self.box = defaultdict(set)

    def print_board(self, board, x=0.01):
        global start
        if start:
            print("\n\n\n\n\n\n\n\n\n\n\n\n\n")
            start = False
        print("\033[13A", end="")
        print(" ----------------------")

        for i in range(ROW_SIZE):
            print(end="|")
            for j in range(COL_SIZE):
                val = board[i][j] if board[i][j] != 0 else "."
                print(f"{val} ", end="")
                if j % 3 == 2:
                    print(end="| ")

            print()

            if i in (2, 5):
                print(" ------|-------|-------")

        print(" ----------------------")

        time.sleep(x * SPEED_FAC)

    def is_valid_sudoku(self, board):
        for r in range(ROW_SIZE):
            for c in range(COL_SIZE):
                val = board[r][c]

                if val == 0:
                    continue

                box_no = (r // 3) * 3 + (c // 3)
                if val in self.row[r] or val in self.col[c] or val in self.box[box_no]:
                    return False

                self.row[r].add(val)
                self.col[c].add(val)
                self.box[box_no].add(val)

        return True

    def naked_singles(self, board):
        r = 0
        c = 0
        found = False

        while r < ROW_SIZE:
            while c < COL_SIZE:
                if board[r][c] != 0:
                    c += 1
                    continue

                box_no = (r // 3) * 3 + (c // 3)
                possibility = Sudoku.valid_values - (
                    self.row[r] | self.col[c] | self.box[box_no]
                )
                if len(possibility) == 1:
                    val = list(possibility)[0]
                    board[r][c] = val

                    self.row[r].add(val)
                    self.col[c].add(val)
                    self.box[box_no].add(val)

                    self.print_board(board, x=0.1)

                    found = True
                    r = 0
                    c = 0

                    break

                c += 1

            if found:
                found = False
                continue

            r += 1
            c = 0

        return board

    def is_valid_element(self, r, c, val):
        box_no = (r // 3) * 3 + (c // 3)
        if val in (self.row[r] | self.col[c] | self.box[box_no]):
            return False

        return True

    def find_empty(self, board):
        for r in range(ROW_SIZE):
            for c in range(COL_SIZE):
                if board[r][c] == 0:
                    return r, c

        return None

    def solver(self, board, animation=False):
        global start
        start = True
        if not self.is_valid_sudoku(board):
            print("This board in not valid!\n")
            return None

        self.naked_singles(board)

        lru_cache(maxsize=None)

        def backtracking():
            empty = self.find_empty(board)

            if empty is None:
                return True

            r, c = empty

            for val in range(1, ROW_SIZE + 1):
                if self.is_valid_element(r, c, val):
                    board[r][c] = val

                    if animation:
                        self.print_board(board)

                    box_no = (r // 3) * 3 + (c // 3)
                    self.row[r].add(val)
                    self.col[c].add(val)
                    self.box[box_no].add(val)

                    if backtracking():
                        return True

                    board[r][c] = 0
                    self.row[r].remove(val)
                    self.col[c].remove(val)
                    self.box[box_no].remove(val)

            return False

        return backtracking()


s = Sudoku()
s1 = Sudoku()

# Change the board as your desired sudoku board
test_board = [
    [0, 0, 0, 0, 0, 0, 0, 1, 2],
    [0, 0, 0, 0, 0, 0, 0, 3, 0],
    [0, 0, 1, 0, 9, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 4, 0, 0, 0],
    [0, 0, 0, 5, 0, 0, 4, 0, 7],
    [0, 8, 0, 0, 0, 0, 0, 0, 0],
    [0, 7, 0, 0, 6, 0, 0, 0, 0],
    [9, 0, 0, 0, 0, 0, 0, 0, 0],
    [8, 0, 0, 0, 0, 0, 3, 0, 0],
]

test_board = np.array(test_board)
# Solving test_board using animation
print("\nSolving board with animation:")
s.solver(test_board, animation=True)
s.print_board(test_board)

# Example board to demonstrate solving sudoku without animation
board2 = [[0] * 9 for _ in range(9)]
board2[0][0] = 2

board2 = np.array(board2)

print("\nSolving board without animation")
s1.solver(board2, animation=False)  # Or simply s1.solver(board2)
s1.print_board(board2)
