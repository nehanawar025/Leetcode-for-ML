## Table: User Activity

| Column Name   | Type | Description |
|---------------|------|-------------|
| `user_id`     | int  | Unique identifier of the user |
| `activity`    | enum | Type of activity performed |
| `activity_date` | date | Date when the activity occurred |

**Notes**
- This table may contain duplicate rows.
- The `activity` column is an ENUM and can have one of the following values:
  - `login`
  - `logout`
  - `jobs`
  - `groups`
  - `homepage`

Write a solution to find the number of users who log in for the first time on each date within a maximum of **[number] days**, starting from today.
Assume today is **June 30, 2019**.

Return the result table in any order.

The result format is shown below.

## Example

### Traffic Table

| user_id | activity | activity_date |
|---------|----------|---------------|
| 1 | login | 2019-05-01 |
| 1 | homepage | 2019-05-01 |
| 1 | logout | 2019-05-01 |
| 2 | login | 2019-06-21 |
| 2 | logout | 2019-06-21 |
| 3 | login | 2019-01-01 |
| 3 | jobs | 2019-01-01 |
| 3 | logout | 2019-01-01 |
| 4 | login | 2019-06-21 |
| 4 | groups | 2019-06-21 |
| 4 | logout | 2019-06-21 |
| 5 | login | 2019-03-01 |
| 5 | logout | 2019-03-01 |
| 5 | login | 2019-06-21 |
| 5 | logout | 2019-06-21 |

### Output

| login_date | user_count |
|------------|------------|
| 2019-05-01 | 1 |
| 2019-06-21 | 2 |

### Explanation

Please note that we only care about dates with a non-zero number of users.  
The user with ID 5 first logged in on 2019-03-01, therefore he is not included in the statistics for 2019-06-21.
