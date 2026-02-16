-- Solution for The Interstellar Sales Tracker 9000

SELECT
	od.productid,
	od.orderid,
	o.orderdate,
	sum(od.quantity * p.price) over(PARTITION BY od.productid ORDER BY o.orderdate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as runningtotal
FROM
	orders o inner join orderdetails od ON o.orderid = od.orderid
	inner join products p ON od.productid = p.productid
