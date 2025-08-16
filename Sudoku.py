from collections import defaultdict


class Sudoku:
    def is_valid_sudoku(self, board):
        row = defaultdict(set)
        col = defaultdict(set)
        box = defaultdict(set)

        for r in range(9):
            for c in range(9):
                val = board[r][c]

                if val == 0:
                    continue

                box_no = (r // 3) * 3 + (c // 3)
                if val in row[r] or val in col[c] or val in box[box_no]:
                    return False

                row[r].add(val)
                col[c].add(val)
                box[box_no].add(val)

        return True


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
