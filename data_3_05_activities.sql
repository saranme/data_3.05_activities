/*
3.05 Activity 1
Keep working on the bank database.

Find out the average number of transactions by account. 
Get those accounts that have more transactions than the average.
*/
SELECT AVG(n_trans)
FROM (
	SELECT account_id, COUNT(trans_id ) n_trans
	FROM trans
	GROUP BY 1
    ) AS n_trans_per_account;

SELECT account_id, COUNT(trans_id) n_trans
FROM trans
GROUP BY 1
HAVING COUNT(trans_id) > (
						SELECT AVG(n_trans)
						FROM (
							SELECT account_id, COUNT(trans_id ) n_trans
							FROM trans
							GROUP BY 1
							) AS n_trans_per_account
						);

/*
3.05 Activity 2
Get a list of accounts from Central Bohemia using a subquery.
Rewrite the previous as a join query.
Discuss which method will be more efficient.
*/
SELECT DISTINCT account_id
FROM account
WHERE district_id IN (SELECT DISTINCT A1
					FROM district
					WHERE A3 = 'central Bohemia');

SELECT a.account_id, d.A3 district
FROM district d
JOIN account a
ON d.A1 = a.district_id
WHERE d.A3 = 'central Bohemia';

/*
3.05 Activity 3
Find the most active customer for each district in Central Bohemia.
*/
SELECT account_id, COUNT(trans_id) n_trans
FROM trans
WHERE account_id IN (SELECT account_id
					FROM account
					WHERE district_id IN (SELECT district_id
										FROM account
										WHERE district_id IN (SELECT A1 
															FROM district 
															WHERE A3 = 'central Bohemia')))
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1