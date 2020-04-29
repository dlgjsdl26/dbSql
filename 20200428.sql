
join2
SELECT COUNT(*)
FROM
    (SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
    FROM prod JOIN buyer ON prod.prod_buyer = buyer.buyer_id);

join2-1

SELECT buyer.buyer_name, COUNT(*)
FROM prod JOIN buyer ON prod.prod_buyer = buyer.buyer_id
GROUP BY buyer_name;

join3

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON (member.mem_id = cart.cart_member)
JOIN prod ON (cart.cart_prod = prod.prod_id);




SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle;

join4

SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid 
    AND customer.cnm IN('brown', 'sally');

join5

SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid 
    AND cycle.pid = product.pid 
    AND customer.cnm IN('brown', 'sally');
    
join6

SELECT MAX(cycle.cid) cid, MAX(cnm) cnm, MAX(cycle.pid) pid, MAX(pnm) pnm, sum(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid 
    AND cycle.pid = product.pid
GROUP BY cnm, pnm;

join7

SELECT cycle.pid, Max(pnm), sum(cnt)
FROM cycle, product
WHERE product.pid = cycle.pid
GROUP BY cycle.pid;

    
    