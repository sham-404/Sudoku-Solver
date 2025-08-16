from collections import defaultdict
import time
import os

start = True


class Sudoku:
    valid_values = {1, 2, 3, 4, 5, 6, 7, 8, 9}

    def print_board(self, board):
        global start
        if start:
            print("\n\n\n\n\n\n\n\n\n")
            start = False
        print("\033[9A", end="")

        for i in board:
            print(i, flush=True)
        time.sleep(0.15)

    def is_valid_sudoku(self, board):
        self.row = defaultdict(set)
        self.col = defaultdict(set)
        self.box = defaultdict(set)

        for r in range(9):
            for c in range(9):
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

        while r < 9:
            while c < 9:
                if test_board[r][c] != 0:
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

                    self.print_board(board)

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


s = Sudoku()
test_board = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
]


print(s.is_valid_sudoku(test_board))
s.print_board(s.naked_singles(test_board))
