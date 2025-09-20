//import 'package:sudoku_backend/sudoku_backend.dart';
//import 'package:test/test.dart';

bool start = false;
double speedFac = 2;
final int rowSize = 9;
final int colSize = 9;

class Sudoku {
  final Map<int, Set<int>> rowMap = {};
  final Map<int, Set<int>> colMap = {};
  final Map<int, Set<int>> boxMap = {};
  final List<(int, int)> empty = [];

  Sudoku() {
    rowMap.clear();
    colMap.clear();
    boxMap.clear();
    for (int i = 0; i < rowSize; i++) {
      rowMap[i] = <int>{};
      colMap[i] = <int>{};
      boxMap[i] = <int>{};
    }
  }

  bool isValidElement(int row, int col, int val) {
    int boxNo = (row ~/ 3) * 3 + (col ~/ 3);

    if (rowMap[row]?.contains(val) ?? false) return false;
    if (colMap[col]?.contains(val) ?? false) return false;
    if (boxMap[boxNo]?.contains(val) ?? false) return false;

    return true;
  }

  bool isValidSudoku(List<List<int>> board) {
    for (int row = 0; row < rowSize; row++) {
      for (int col = 0; col < colSize; col++) {
        final int val = board[row][col];
        if (val == 0) {
          empty.add((row, col));
        } else {

          if (!isValidElement(row, col, val)) {
            return false;
          }
          final boxNo = (row ~/ 3) * 3 + (col ~/ 3);
          rowMap[row]!.add(val);
          colMap[col]!.add(val);
          boxMap[boxNo]!.add(val);
        }
      }
    }
    return true;
  }

  void solver(List<List<int>> board) {

    if (!isValidSudoku(board)) {
      print("Not a valid Sudoku board");
      return;
    }

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
  final board = [
    for (int i = 0; i < 9; i++) [for (int i = 0; i < 9; i++) 0],
  ];

  final solver = Sudoku();
  solver.solver(board);
  print(solver.empty);

  for (final row in board) {
    print(row);
  }
}
