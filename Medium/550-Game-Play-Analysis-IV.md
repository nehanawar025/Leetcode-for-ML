# Solution 

```sql
WITH temp AS(
	SELECT
	    player_id,
	    event_date,
	    LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date) AS next_login_date,
	    DATEDIFF((LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date)), event_date) AS date_difference,
	    ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS event_date_wise_rn     
	FROM
		Activity
)

SELECT
	ROUND(IFNULL(COUNT(IF(date_difference = 1, 1, NULL)), 0)/COUNT(distinct player_id), 2)	AS fraction 
FROM 
	temp
WHERE
	event_date_wise_rn = 1

```

<br>

# Solution Explanation

### CTE

```sql
SELECT
	player_id,
	event_date,
	LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date) AS lead_date,
	DATEDIFF((LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date)), event_date) AS date_difference,
	ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS rn        
FROM
	Activity
```

<br>

| player_id | event_date | next_login_date | date_difference | event_date_wise_rn |
| --------- | ---------- | --------------- | --------------- | ------------------ |
| 1         | 2016-03-01 | 2016-03-02      | 1               | 1                  |
| 1         | 2016-03-02 | null            | null            | 2                  |
| 2         | 2017-06-25 | null            | null            | 1                  |
| 3         | 2016-03-02 | 2018-07-03      | 853             | 1                  |
| 3         | 2018-07-03 | null            | null            | 2                  |

<br>
 
- The `next_login_date` column shows the next login date that comes right after the previous event date.
- The `date_difference` column is calculating the difference between the next login date and the previous event date, and
- The `event_date_wise_rn` column is showing which event date is the first login date for each player.

<br>

### Outer Table

```sql
SELECT
	ROUND(IFNULL(COUNT(IF(date_difference = 1, 1, NULL)), 0)/COUNT(distinct player_id), 2)	AS fraction 
FROM 
	temp
WHERE
	event_date_wise_rn = 1
```
<br>

- `IFNULL(COUNT(IF(date_difference = 1, 1, NULL)), 0)/COUNT(distinct player_id)` Here, I have divided the number of players who have logged in for 2 consecutive days by the total number of players.
- `WHERE event_date_wise_rn = 1` here, this condition helps to identify only those `event_date`s that are actually the first login dates for each player.

So this outer table shows the number of players who logged in the next day after their first login, divided by the total number of players.
