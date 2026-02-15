SELECT
  customerid,
  orderid,
  SUM(totalamount) OVER(PARTITION BY customerid) as totalrevenue
FROM
  orders
