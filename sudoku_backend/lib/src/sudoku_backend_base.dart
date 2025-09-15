bool start = false;
double speedFac = 2;
int rowSize = 9;
int colSize = 9;

class Sudoku {
	static Set<int> validValues = {for (int i = 1; i <= rowSize; i++) i};
	final Map<int, Set<int>> rowMap = {};
	final Map<int, Set<int>> colMap = {};
	final Map<int, Set<int>> boxMap = {};
	final Set<String> emptySet = {};

	Sudoku() {
		for (int i = 0; i < rowSize; i++) {
			rowMap[i] = <int>{};
			colMap[i] = <int>{};
			boxMap[i] = <int>{};
		}
	}

	void printBoard(List<List<int>> board, [double x = 0.01]) {}

	void findAllEmpty(List<List<int>> board) {
		for (int i = 0; i < rowSize; i++) {
			for (int j = 0; j < colSize; j++) {
				if (board[i][j] == 0) {
					emptySet.add("$i,$j");
				}
			}
		}
	}

	bool isValidSudoku(List<List<int>> board) {
		int val, boxNo;
		for (int r = 0; r < rowSize; r++) {
			for (int c = 0; c < colSize; c++) {
				val = board[r][c];
				if (val == 0) {
					emptySet.add("$r,$c");
					continue;
				}
				boxNo = (r ~/ 3) * 3 + (c ~/ 3);

				if ({...?rowMap[r], ...?colMap[c], ...?boxMap[boxNo]}.contains(val)) {
					return false;
				}

				rowMap[r]!.add(val);
				colMap[c]!.add(val);
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
}

void main() {
	List<List<int>> testBoard = [
	  [5, 3, 0, 0, 7, 0, 0, 0, 0],
	  [6, 0, 0, 1, 9, 5, 0, 0, 0],
	  [0, 9, 8, 0, 0, 0, 0, 6, 0],
	  [8, 0, 0, 0, 6, 0, 0, 0, 3],
	  [4, 0, 0, 8, 0, 3, 0, 0, 1],
	  [7, 0, 0, 0, 2, 0, 0, 0, 6],
	  [0, 6, 0, 0, 0, 0, 2, 8, 0],
	  [0, 0, 0, 4, 1, 9, 0, 0, 5],
	  [0, 0, 0, 0, 8, 0, 0, 7, 9],
	];


	Sudoku s = Sudoku();
	s.findAllEmpty(testBoard);
	print(s.emptySet);
	print(s.isValidSudoku(testBoard));
	s.nakedSingles(testBoard);
	for (var i in testBoard) {
		print(i);
	}
	
}
