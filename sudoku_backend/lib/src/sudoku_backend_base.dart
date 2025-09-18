bool start = false;
double speedFac = 2;
int rowSize = 9;
int colSize = 9;

class Sudoku {
	static Set<int> validValues = {for (int i = 1; i <= rowSize; i++) i};
	final Map<int, Set<int>> rowMap = {};
	final Map<int, Set<int>> colMap = {};
	final Map<int, Set<int>> boxMap = {};
	final List<String> emptyList = [];

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
					emptyList.add("$i,$j");
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

	bool isValidElement(int row, int col, int val) {
		int boxNo = (row ~/ 3) * 3 + (col ~/ 3);

		if (rowMap[row]?.contains(val) ?? false) return false;
		if (colMap[col]?.contains(val) ?? false) return false;
		if (boxMap[boxNo]?.contains(val) ?? false) return false;

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

	void solver(List<List<int>> board, [bool animation = false]) {
		start = true;
		if (!isValidSudoku(board)) {
			print("This is not a valid sudoku!");
			return;
		}

		//nakedSingles(board, animation);
		findAllEmpty(board);
		List<String> strVal;
		int row, col, boxNo;
		print(emptyList);

		bool backtracking([int idx = 0]) {
			if (idx == emptyList.length) {
				return true;
			}

			strVal = emptyList[idx].split(",");

			row = int.parse(strVal[0]);
			col = int.parse(strVal[1]);
			boxNo = (row ~/ 3) * 3 + (col ~/ 3);

			for (int val = 1; val <= rowSize; val++) {
				if (isValidElement(row, col, val)) {

					board[row][col] = val;

					print("$val, $row, $col");

					if (animation) {
						for (var i in board) {
							print(i);
						}
						print('');
					}

					rowMap[row]!.add(val);
					colMap[col]!.add(val);
					boxMap[boxNo]!.add(val);

					if (backtracking(idx + 1)) {
						return true;
					}

					board[row][col] = 0;
					print("$row, $col");

					rowMap[row]!.remove(val);
					colMap[col]!.remove(val);
					boxMap[boxNo]!.remove(val);
				}
			}

			return false;

		}

		backtracking();
	}
}

void main() {
	List<List<int>> testBoard1 = [
		[0, 0, 0, 0, 0, 0, 0, 1, 2],
		[0, 0, 0, 0, 0, 0, 0, 3, 0],
		[0, 0, 1, 0, 9, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 4, 0, 0, 0],
		[0, 0, 0, 5, 0, 0, 4, 0, 7],
		[0, 8, 0, 0, 0, 0, 0, 0, 0],
		[0, 7, 0, 0, 6, 0, 0, 0, 0],
		[9, 0, 0, 0, 0, 0, 0, 0, 0],
		[8, 0, 0, 0, 0, 0, 3, 0, 0],
	];


	Sudoku s = Sudoku();
	//s.findAllEmpty(testBoard);
	//print(s.emptyList);
	//print(s.isValidSudoku(testBoard1));
	print(s.emptyList);
	s.solver(testBoard1, true);
	for (var i in testBoard1) {
		print(i);
	}

	
}
