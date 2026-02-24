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
 
- The 𝗻𝗲𝘅𝘁_𝗹𝗼𝗴𝗶𝗻_𝗱𝗮𝘁𝗲 column shows the next login date, basically the next row for each event_date for each player_Id.

- The 𝗱𝗮𝘁𝗲_𝗱𝗶𝗳𝗳𝗲𝗿𝗲𝗻𝗰𝗲 column is calculating the difference between the next login date and the event date.

- The 𝗲𝘃𝗲𝗻𝘁_𝗱𝗮𝘁𝗲_𝘄𝗶𝘀𝗲_𝗿𝗻 column is assigning a unique row number based on event dates for each player.

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

- `𝗜𝗙𝗡𝗨𝗟𝗟(𝗖𝗢𝗨𝗡𝗧(𝗜𝗙(𝗱𝗮𝘁𝗲_𝗱𝗶𝗳𝗳𝗲𝗿𝗲𝗻𝗰𝗲 = 𝟭, 𝟭, 𝗡𝗨𝗟𝗟)), 𝟬)/𝗖𝗢𝗨𝗡𝗧(𝗱𝗶𝘀𝘁𝗶𝗻𝗰𝘁 𝗽𝗹𝗮𝘆𝗲𝗿_𝗶𝗱)` Here, I have divided the number of players who have logged in for 2 consecutive days by the total number of players.

- `𝗪𝗛𝗘𝗥𝗘 𝗲𝘃𝗲𝗻𝘁_𝗱𝗮𝘁𝗲_𝘄𝗶𝘀𝗲_𝗿𝗻 = 𝟭` Here, this condition helps to identify the first login date for each player.

So this outer table shows the number of players who logged in the next day after their first login, divided by the total number of players.
