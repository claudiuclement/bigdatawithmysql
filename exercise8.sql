# MySQL Exercise 8: Joining Tables with Outer Joins
%load_ext sql
%sql mysql://studentuser:studentpw@mysqlserver/dognitiondb
%sql USE dognitiondb


# Question 1:
%%sql
SELECT d.user_guid AS UserID, d.dog_guid AS DogID, d.breed, d.breed_type,
d.breed_group
FROM dogs d JOIN complete_tests c
ON d.dog_guid=c.dog_guid
WHERE test_name='Yawn Warm-up';

# Question 2:
%%sql
SELECT r.dog_guid AS rDogID, d.dog_guid AS dDogID, r.user_guid AS rUserID,
d.user_guid AS dUserID, AVG(r.rating) AS AvgRating, COUNT(r.rating) AS
NumRatings, d.breed, d.breed_group, d.breed_type
FROM dogs d RIGHT JOIN reviews r
ON d.dog_guid=r.dog_guid AND d.user_guid=r.user_guid
WHERE r.dog_guid IS NOT NULL
GROUP BY r.dog_guid
HAVING NumRatings >= 10
ORDER BY AvgRating DESC;

%%sql SELECT r.dog_guid AS rDogID, d.dog_guid AS dDogID, r.user_guid AS rUserID, d.user_guid AS dUserID, AVG(r.rating) AS AvgRating, COUNT(r.rating) AS NumRatings, d.breed, d.breed_group, d.breed_type
FROM reviews r LEFT JOIN dogs d
  ON r.dog_guid=d.dog_guid AND r.user_guid=d.user_guid
WHERE d.dog_guid IS NULL
GROUP BY r.dog_guid
HAVING NumRatings >= 10
ORDER BY AvgRating DESC;

# Question 3: How would you use a left join to retrieve a list of all the unique dogs in the dogs table, 
# and retrieve a count of how many tests each one completed? Include the dog_guids and user_guids from the dogs and complete_tests tables in your output. (If you do not limit your query, your output should contain 35050 rows. 
# HINT: use the dog_guid from the dogs table to group your results.)
%%sql
SELECT d.user_guid AS dUserID, c.user_guid AS cUserID, d.dog_guid AS dDogID,
c.dog_guid AS dDogID, count(test_name)
FROM dogs d LEFT JOIN complete_tests c
ON d.dog_guid=c.dog_guid
GROUP BY d.dog_guid;


# Question 4: Repeat the query you ran in Question 3, but intentionally use the dog_guids from the completed_tests table to 
# group your results instead of the dog_guids from the dogs table. (Your output should contain 17987 rows)
%%sql
SELECT DISTINCT d.dog_guid, d.user_guid, c.dog_guid,c.user_guid,count(test_name)
FROM dogs d LEFT JOIN complete_tests c
on d.dog_guid=c.dog_guid
GROUP BY c.dog_guid
LIMIT 10;

#Question 5:
%%sql
SELECT COUNT(DISTINCT(dog_guid))
FROM complete_tests;

#Question 6: 
%%sql
SELECT d.breed, d.user_guid, u.user_guid,d.dog_guid AS dDogID
FROM users u LEFT JOIN dogs d
ON u.user_guid=d.user_guid
LIMIT 10;

#Question 7:
%%sql
SELECT u.user_guid AS uUserID, d.user_guid AS dUserID, d.dog_guid AS dDogID, 
d.breed, count(*) AS numrows
FROM users u LEFT JOIN dogs d
ON u.user_guid=d.user_guid
GROUP BY u.user_guid
ORDER BY numrows DESC
LIMIT 10;

#Question 8:
%%sql
SELECT COUNT(user_guid) 
FROM users
WHERE user_guid='ce225842-7144-11e5-ba71-058fbc01cf0b';

#Question 9:
%%sql
SELECT *
FROM dogs
WHERE user_guid='ce225842-7144-11e5-ba71-058fbc01cf0b';

#Question 10:
%%sql
SELECT COUNT(DISTINCT u.user_guid)
FROM users u LEFT JOIN dogs d
ON u.user_guid=d.user_guid
WHERE d.user_guid IS NULL;

#Question 11:
%%sql
SELECT COUNT(DISTINCT u.user_guid)
FROM dogs d RIGHT JOIN users u
ON d.user_guid=u.user_guid
WHERE d.user_guid IS NULL;

#Question 12:
%%sql
SELECT s.dog_guid AS SA_dogs_not_present_in_dogs_table, COUNT(*) AS 
NumEntries
FROM site_activities s LEFT JOIN dogs d
ON s.dog_guid=d.dog_guid 
WHERE d.dog_guid IS NULL AND s.dog_guid IS NOT NULL
GROUP BY SA_dogs_not_present_in_dogs_table;


