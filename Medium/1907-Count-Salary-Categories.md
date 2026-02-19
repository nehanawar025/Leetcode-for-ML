# [1907. Count Salary Categories](https://leetcode.com/problems/count-salary-categories/description/)
![Difficulty](https://img.shields.io/badge/Difficulty-Medium-blue)

## Input:

Accounts table:

| account_id | income |
|------------|--------|
| 3 | 108939 |
| 2 | 12747 |
| 8 | 87709 |
| 6 | 91796 |



## Output:

| category | accounts_count |
|----------|----------------|
| Low Salary | 1 |
| Average Salary | 0 |
| High Salary | 3 |



## Explanation:

Low Salary: Account 2.  
Average Salary: No accounts.  
High Salary: Accounts 3, 6, and 8.



---

# Solution
```sql
SELECT 
    'Low Salary' AS category,
    COUNT(IF(income < 20000,1,NULL)) AS accounts_count
FROM   
    Accounts 
UNION ALL
SELECT 
    'Average Salary',
    COUNT(IF(income BETWEEN 20000 AND 50000, 1, NULL))
FROM
    Accounts
UNION ALL
SELECT 
    'High Salary',
    COUNT(IF(income > 50000, 1, NULL))
FROM
    Accounts
ORDER BY accounts_count DESC


```
