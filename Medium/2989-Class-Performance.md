# 2989. Class Performance
![Difficulty](https://img.shields.io/badge/Difficulty-Medium-blue)

## Description

### Table: `Scores`

| Column Name   | Type    | Description |
|---------------|---------|-------------|
| `student_id`  | int     | Unique identifier for each student |
| `student_name`| varchar | Name of the student |
| `assignment1` | int     | Score obtained in assignment 1 |
| `assignment2` | int     | Score obtained in assignment 2 |
| `assignment3` | int     | Score obtained in assignment 3 |

- `student_id` contains unique values.
- This table contains student_id, student_name, and scores for three assignments.

## Problem

Write a solution to calculate the difference in the total score (sum of all 3 assignments) between the highest score obtained by students and the lowest score obtained by them.

Return the result table in any order.

The result format is shown below.

## Example

### Input

| student_id | student_name | assignment1 | assignment2 | assignment3 |
|------------|--------------|-------------|-------------|-------------|
| 309 | Owen   | 88  | 47 | 87 |
| 321 | Claire | 98  | 95 | 37 |
| 338 | Julian | 100 | 64 | 43 |
| 423 | Peyton | 60  | 44 | 47 |
| 896 | David  | 32  | 37 | 50 |
| 235 | Camila | 31  | 53 | 69 |

### Output

| difference_in_score |
|---------------------|
| 111 |

### Explanation

- student_id 309 total score = 222
- student_id 321 total score = 230
- student_id 338 total score = 207
- student_id 423 total score = 151
- student_id 896 total score = 119
- student_id 235 total score = 153

The highest score is 230 and the lowest score is 119.  
The difference between them is 111.


# Solution



