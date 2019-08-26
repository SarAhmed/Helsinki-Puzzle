# Helsinki-Puzzle
Grid Puzzle
## Description
Given a square grid of size N, where the horizontal rows are numbered 1 to N from
top to bottom and the vertical columns are numbered 1 to N from left to right.
You must place a number in each cell of the N by N grid such that :-
* Each row is unique.<br/>
* Each row is exactly equal to one of the columns, however, it must not bethe column with the same index as the row.<br/>
* If X is the largest number you place in the grid, then you must also place1,2,...,X-1, where the condition X ≤ N is satisfied.<br/>
## Examples
For a 3 × 3 grid, you may have the following matrix
```
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |


```
