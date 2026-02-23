```sql
WITH temp AS(
	SELECT
		player_id,
		event_date,
		LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date) AS lead_date,
        DATEDIFF((LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date)), event_date) AS date_difference,
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS rn        
	FROM
		Activity
)

SELECT
	ROUND(IFNULL(COUNT(IF(date_difference = 1, 1, NULL)), 0)/COUNT(distinct player_id), 2)	AS fraction 
FROM 
	temp
WHERE
	rn = 1

```
