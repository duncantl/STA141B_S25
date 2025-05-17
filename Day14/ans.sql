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



- What question has the most comments associated with it?

SELECT p.Id, COUNT(*) as numComments
FROM Posts AS p
LEFT JOIN Comments AS c
ON  c.PostId = p.Id
WHERE PostTypeId = 1
GROUP BY p.Id
ORDER BY numComments DESC
LIMIT 20;


-- Quick check
select postId, COUNT(*) FROM Comments Where postId = '328630';


-- What is the distribution of answers per posted question?

Like the Comments, we need to have
Q1   answer1
Q1   answer2
Q1   answer3
Q2   NULL
Q3   answer10
Q3   answer87
....


So we need to LEFT JOIN Posts with  what other table?

The answers are also in Posts.  So we need to LEFT JOIN Posts with Posts.

We connect an answer post with the question post when
    answer.ParentId = question.Id


SELECT q.Id, COUNT(*) as numAnswers
FROM Posts AS q
LEFT JOIN Posts AS a
ON a.ParentId = q.Id
WHERE q.PostTypeId = 1  -- a question
GROUP BY q.Id
ORDER BY numAnswers DESC
LIMIT 10;


-- A Quick check
select Id, COUNT(*) FROM Posts Where ParentId = '726';




-- What is the length of time for a question to receive an answer?  to obtaining an accepted answer?

CreationDate gives us the time of each post.

If we had

Questions      Answers
  Posts         Posts
(all columns)  (all columns)
Q1             answer1
Q1             answer2
Q1             answer3
Q2             NULL
Q3             answer10
Q3              answer87


Then we would have the CreationDate for the question and the CreationDate for each answer.

Within each sub-group, for a given question, we can compute
   MIN( a.CreationDate - q.Creation)
to find the time to the first answer.


SELECT q.Id, COUNT(*) as numAnswers, MIN( unixepoch(a.CreationDate) - unixepoch(q.CreationDate)) timeToAnswer, q.CreationDate
FROM Posts AS q
LEFT JOIN Posts AS a
ON a.ParentId = q.Id
WHERE q.PostTypeId = 1  -- a question
GROUP BY q.Id
HAVING timeToAnswer IS NOT NULL
ORDER BY timeToAnswer
LIMIT 10;

-- Quick check
-- Why are there numerous negative values, i.e, answers before the question.


