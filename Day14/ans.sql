SELECT COUNT(*)
FROM Posts AS p
INNER JOIN PostTypeIdMap AS m
ON p.PostTypeId = m.id
WHERE m.value = "Question";


SELECT COUNT(*)
FROM Posts AS p
INNER JOIN PostTypeIdMap AS m
ON p.PostTypeId = m.id
WHERE m.value = "Answer";

SELECT m.value, COUNT(*) AS num
FROM Posts AS p
INNER JOIN PostTypeIdMap AS m
ON p.PostTypeId = m.id
GROUP BY m.value
ORDER BY num DESC
;


SELECT OwnerUserId, COUNT(*) as numQuestions, u.Location, u.CreationDate
FROM Posts AS p
INNER JOIN PostTypeIdMap AS m
ON p.PostTypeId = m.id
INNER JOIN Users AS u
ON p.OwnerUserId = u.Id
WHERE m.value = "Question"
GROUP BY p.OwnerUserId
HAVING NOT OwnerUserId = ''
ORDER BY numQuestions DESC
LIMIT 10;


Let's find examples of OwnerUserId = ''
SELECT *
FROM Posts
WHERE PostTypeId = 1
AND  OwnerUserId = '';





