# Sudoku Solver

This is a simple Sudoku solver written in Python.

## Features
- Solves any valid 9x9 Sudoku puzzle
- Uses backtracking
- Can apply the "naked singles" strategy
- Prints the animated board as it solves step by step in the terminal

---

## Requirements
- Python 3.8 or later
- No extra libraries required

---

## How to Run
1. Clone the repository or download the python code
2. Run the solver with:
   ```bash
   python sudoku.py
   ```
3. Edit the `board` variable in `sudoku.py` to try your own puzzle (use 0 for empty cells)

---

## Example board output
```
 ----------------------
|3 4 5 | 6 7 8 | 9 1 2 | 
|2 9 8 | 1 4 5 | 7 3 6 | 
|7 6 1 | 2 9 3 | 5 4 8 | 
 ------|-------|-------| 
|1 2 7 | 9 3 4 | 6 8 5 | 
|6 3 9 | 5 8 1 | 4 2 7 | 
|5 8 4 | 7 2 6 | 1 9 3 | 
 ------|-------|-------
|4 7 2 | 3 6 9 | 8 5 1 | 
|9 1 3 | 8 5 7 | 2 6 4 | 
|8 5 6 | 4 1 2 | 3 7 9 | 
 ----------------------
```
### Board uses animation to visualy show how the algorithm solves the board 
---
