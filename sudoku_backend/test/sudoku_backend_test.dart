//import 'package:sudoku_backend/sudoku_backend.dart';
//import 'package:test/test.dart';

class Solution {
  final Map<int, Set<int>> row = {};
  final Map<int, Set<int>> col = {};
  final Map<int, Set<int>> box = {};
  final List<(int, int)> empty = [];

  void solver(List<List<int>> board) {
    // initialize maps
    for (int i = 0; i < 9; i++) {
      row[i] = <int>{};
      col[i] = <int>{};
      box[i] = <int>{};
    }

    
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        final val = board[r][c];
        if (val == 0) {
          empty.add((r, c));
        } else {
          final b = (r ~/ 3) * 3 + (c ~/ 3);
          row[r]!.add(val);
          col[c]!.add(val);
          box[b]!.add(val);
        }
      }
    }

    bool backtrack([int idx = 0]) {
      if (idx == empty.length) return true;

      final (r, c) = empty[idx];
      final b = (r ~/ 3) * 3 + (c ~/ 3);

      for (var val = 1; val <= 9; val++) {
        if (!row[r]!.contains(val) &&
            !col[c]!.contains(val) &&
            !box[b]!.contains(val)) {
          // place
          board[r][c] = val;
          row[r]!.add(val);
          col[c]!.add(val);
          box[b]!.add(val);

          if (backtrack(idx + 1)) return true;

          // undo
          board[r][c] = 0;
          row[r]!.remove(val);
          col[c]!.remove(val);
          box[b]!.remove(val);
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

  final solver = Solution();
  solver.solver(board);

  for (final row in board) {
    print(row);
  }
}
