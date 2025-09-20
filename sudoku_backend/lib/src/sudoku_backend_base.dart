bool start = false;
double speedFac = 2;
final int rowSize = 9;
final int colSize = 9;

class Sudoku {
  static Set<int> validValues = {for (int i = 1; i <= rowSize; i++) i};
  final Map<int, Set<int>> rowMap = {};
  final Map<int, Set<int>> colMap = {};
  final Map<int, Set<int>> boxMap = {};
  final List<(int, int)> empty = [];

  Sudoku() {
    resetMaps();
  }

  void resetMaps() {
    rowMap.clear();
    colMap.clear();
    boxMap.clear();
    empty.clear();
    for (int i = 0; i < rowSize; i++) {
      rowMap[i] = <int>{};
      colMap[i] = <int>{};
      boxMap[i] = <int>{};
    }
  }

  void printBoard(List<List<int>> board, [animation=false]) {}

  bool isValidElement(int row, int col, int val) {
    int boxNo = (row ~/ 3) * 3 + (col ~/ 3);

    if (rowMap[row]?.contains(val) ?? false) return false;
    if (colMap[col]?.contains(val) ?? false) return false;
    if (boxMap[boxNo]?.contains(val) ?? false) return false;

    return true;
  }

  void findAllEmpty(List<List<int>> board) {
    empty.clear();
    for (int i = 0; i < rowSize; i++) {
      for (int j = 0; j < colSize; j++) {
        if (board[i][j] == 0) {
          empty.add((i, j));
        }
      }
    }
  }

  bool isValidSudoku(List<List<int>> board) {
    resetMaps();
    for (int row = 0; row < rowSize; row++) {
      for (int col = 0; col < colSize; col++) {
        final int val = board[row][col];

        if (val == 0) continue;

        if (!isValidElement(row, col, val)) {
          return false;
        }

        final boxNo = (row ~/ 3) * 3 + (col ~/ 3);
        rowMap[row]!.add(val);
        colMap[col]!.add(val);
        boxMap[boxNo]!.add(val);
      }
    }
    return true;
  }

  void nakedSingles(List<List<int>> board, [bool animation = false]) {
    int row = 0;
    int col = 0;
    int boxNo;
    int val;
    Set<int> possibility;
    bool found = false;

    while (row < rowSize) {
      while (col < colSize) {
        if (board[row][col] != 0) {
          col++;
          continue;
        }

        boxNo = (row ~/ 3) * 3 + (col ~/ 3);
        possibility = validValues.difference(
          (rowMap[row] ?? {})
              .union(colMap[col] ?? {})
              .union(boxMap[boxNo] ?? {}),
        );

        if (possibility.length == 1) {
          val = possibility.single;
          board[row][col] = val;

          rowMap[row]!.add(val);
          colMap[col]!.add(val);
          boxMap[boxNo]!.add(val);

          if (animation) {
            printBoard(board);
          }

          found = true;
          row = 0;
          col = 0;
          break;
        }

        col++;
      }

      if (found) {
        found = false;
        continue;
      }

      row++;
      col = 0;
    }
  }


  void solver(List<List<int>> board) {
    if (!isValidSudoku(board)) {
      print("Not a valid Sudoku board");
      return;
    }

    nakedSingles(board);
    findAllEmpty(board);
    print("It is a valid Sudoku!\n");

    bool backtrack([int idx = 0]) {
      if (idx == empty.length) return true;

      final (row, col) = empty[idx];
      final int boxNo = (row ~/ 3) * 3 + (col ~/ 3);

      for (var val = 1; val <= 9; val++) {
        if (isValidElement(row, col, val)) {
          board[row][col] = val;
          rowMap[row]!.add(val);
          colMap[col]!.add(val);
          boxMap[boxNo]!.add(val);

          if (backtrack(idx + 1)) return true;

          board[row][col] = 0;
          rowMap[row]!.remove(val);
          colMap[col]!.remove(val);
          boxMap[boxNo]!.remove(val);
        }
      }
      return false;
    }

    backtrack();
  }
}

void main() {
  final List<List<int>> board = [
    for (int i = 0; i < 9; i++) [for (int i = 0; i < 9; i++) 0],
  ];

  board[0][0] = 2;

  final Sudoku solver = Sudoku();
  print(solver.isValidSudoku(board));
  print(solver.empty);
  solver.solver(board);

  for (final row in board) {
    print(row);
  }
}
