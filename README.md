# Helsinki-Puzzle
Grid Puzzle
## Description
Given a square grid of size N, where the horizontal rows are numbered 1 to N from
top to bottom and the vertical columns are numbered 1 to N from left to right.
You must place a number in each cell of the N by N grid such that :-
* Each row is unique.<br/>
* Each row is exactly equal to one of the columns, however, it must not bethe column with the same index as the row.<br/>
* If X is the largest number you place in the grid, then you must also place1,2,...,X-1, where the condition X ≤ N is satisfied.<br/>
## Example

For a 4 × 4 grid, you may have the following matrix

|  | `c1` | `c2` | `c3` | `c3`|
| r1| 1|2| 3| 1|
|r2 |3 |4 |4 |2|
|r3 |2 |4 |4 |3|
|r4 |1| 3| 2| 1|

defined by the following equalities:
*c1 = r2
*c2 = r3
*c3 = r1

