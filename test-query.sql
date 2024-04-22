--
-- short
--

-- Q1
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (n:Person {id: 10995116277795 })-[:IS_LOCATED_IN]->(p:Place)
RETURN
    n.firstName AS firstName,
    n.lastName AS lastName,
    n.birthday AS birthday,
    n.locationIP AS locationIP,
    n.browserUsed AS browserUsed,
    p.id AS cityId,
    n.gender AS gender,
    n.creationDate AS creationDate
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype, result8 agtype, result9 agtype);' from generate_series(1,10) \gexec




-- here VLE is the issue, :REPLY_OF returns correct result (:REPLY_OF*0.. wont give result)
-- removing VLE expr gives the result
-- Q2
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (:Person {id: 10995116277796})<-[:HAS_CREATOR]-(message)
WITH
 message,
 message.id AS messageId,
 message.creationDate AS messageCreationDate
LIMIT 10
MATCH (message)-[:REPLY_OF*0..]->(post:Post),
      (post)-[:HAS_CREATOR]->(person)
RETURN
 messageId,
 coalesce(message.imageFile,message.content) AS messageContent,
 messageCreationDate,
 post.id AS postId,
 person.id AS personId,
 person.firstName AS personFirstName,
 person.lastName AS personLastName
ORDER BY messageCreationDate DESC, messageId ASC
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype, result7 agtype);' from generate_series(1,10) \gexec


-- Q3
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (n:Person {id: 10995116277795 })-[r:KNOWS]-(friend)
RETURN
    friend.id AS personId,
    friend.firstName AS firstName,
    friend.lastName AS lastName,
    r.creationDate AS friendshipCreationDate
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype);' from generate_series(1,10) \gexec


-- this record with id doesnt exist in Comment vertices
-- original id used 206158431837, changed it to 206158431894
-- Q4
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (m:Comment {id:  206158431894 })
RETURN
    m.creationDate as messageCreationDate,
    coalesce(m.content, m.imageFile) as messageContent
$$) AS (result1 agtype, result2 agtype);' from generate_series(1,10) \gexec





-- this record with id doesnt exist in Comment vertices
-- original id used 206158431837, changed it to 206158431894
-- Q5
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (m:Comment {id:  206158431894 })-[:HAS_CREATOR]->(p:Person)
RETURN
    p.id AS personId,
    p.firstName AS firstName,
    p.lastName AS lastName
$$) AS (result1 agtype, result2 agtype, result3 agtype);' from generate_series(1,10) \gexec






-- this record with id doesnt exist in Comment vertices
-- original id used 206158431837, changed it to 206158431894
-- removing VLE expr returns the result
-- Q6
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (m:Comment {id: 206158431894 })-[:REPLY_OF*0..]->(p:Post)<-[:CONTAINER_OF]-(f:Forum)-[:HAS_MODERATOR]->(mod:Person)
RETURN
    f.id AS forumId,
    f.title AS forumTitle,
    mod.id AS moderatorId,
    mod.firstName AS moderatorFirstName,
    mod.lastName AS moderatorLastName
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype, result5 agtype);' from generate_series(1,10) \gexec



-- Q7
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (m:Comment {id: 206158432795 })<-[:REPLY_OF]-(c:Comment)-[:HAS_CREATOR]->(p:Person)
    OPTIONAL MATCH (m)-[:HAS_CREATOR]->(a:Person)-[r:KNOWS]-(p)
    RETURN c.id AS commentId,
        c.content AS commentContent,
        c.creationDate AS commentCreationDate,
        p.id AS replyAuthorId,
        p.firstName AS replyAuthorFirstName,
        p.lastName AS replyAuthorLastName,
        CASE r
            WHEN null THEN false
            ELSE true
        END AS replyAuthorKnowsOriginalMessageAuthor
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype, result5 agtype, result6 agtype, result7 agtype);
' from generate_series(1,10) \gexec

--
-- complex
--

-- Q1 not supported by AGE yet



-- Q2
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (:Person {id: 10995116278010 })-[:KNOWS]-(friend:Person)<-[:HAS_CREATOR]-(message:Comment)
    WHERE message.creationDate <= 1287230400000
    RETURN
        friend.id AS personId,
        friend.firstName AS personFirstName,
        friend.lastName AS personLastName,
        message.id AS postOrCommentId,
        coalesce(message.content,message.imageFile) AS postOrCommentContent,
        message.creationDate AS postOrCommentCreationDate
    LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype);' from generate_series(1,10) \gexec





-- ERROR:  operator does not exist: benchmark._ag_label_vertex = agtype
-- Q3
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (countryX:Place {name: ''Angola'' }),
      (countryY:Place {name: ''Colombia'' }),
      (person:Person {id: 6597069766735 })
WITH person, countryX, countryY
LIMIT 1
MATCH (city:Place)-[:IS_PART_OF]->(country:Place)
WHERE country IN [countryX, countryY]
WITH country, person, countryX, countryY, collect(city) AS cities
MATCH (person)-[:KNOWS*1..2]-(friend)-[:IS_LOCATED_IN]->(city)
WHERE NOT person=friend AND NOT city IN cities
WITH DISTINCT country, friend, countryX, countryY
MATCH (friend)<-[:HAS_CREATOR]-(message),
      (message)-[:IS_LOCATED_IN]->(country)
WHERE 1277812800000 > message.creationDate >= 1275393600000 AND
      country IN [countryX, countryY]
WITH friend,
     CASE WHEN country=countryX THEN 1 ELSE 0 END AS messageX,
     CASE WHEN country=countryY THEN 1 ELSE 0 END AS messageY
WITH friend, sum(messageX) AS xCount, sum(messageY) AS yCount
WHERE xCount>0 AND yCount>0
RETURN friend.id AS friendId,
       friend.firstName AS friendFirstName,
       friend.lastName AS friendLastName,
       xCount,
       yCount,
       xCount + yCount AS xyCount
LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype);' from generate_series(1,10) \gexec



-- Q4
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 4398046511334 })-[:KNOWS]-(friend:Person),
      (friend)<-[:HAS_CREATOR]-(post:Post)-[:HAS_TAG]->(tag)
WITH DISTINCT tag, post
WITH tag,
     CASE
       WHEN 1275350400000 <= post.creationDate < 1277856000000 THEN 1
       ELSE 0
     END AS valid,
     CASE
       WHEN post.creationDate < 1275350400000 THEN 1
       ELSE 0
     END AS inValid
WITH tag, sum(valid) AS postCount, sum(inValid) AS inValidPostCount
WHERE postCount>0 AND inValidPostCount=0
RETURN tag.name AS tagName, postCount
LIMIT 10
$$) AS (result1 agtype, result2 agtype);' from generate_series(1,10) \gexec




-- doesnt return any result; but the following query returns results
-- issue is with WHERE condition doesnt return any rows
-- Q5
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person { id: 6597069766735 })-[:KNOWS*1..2]-(friend)
WHERE
    NOT person=friend
WITH DISTINCT friend
MATCH (friend)<-[membership:HAS_MEMBER]-(forum)
WITH
    forum,
    collect(friend) AS friends
OPTIONAL MATCH (friend)<-[:HAS_CREATOR]-(post)<-[:CONTAINER_OF]-(forum)
WHERE
    friend IN friends
WITH
    forum,
    count(post) AS postCount
RETURN
    forum.title AS forumName,
    postCount
LIMIT 20
$$) AS (result1 agtype, result2 agtype);' from generate_series(1,10) \gexec

SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person { id: 6597069766735 })-[:KNOWS*1..2]-(friend)
WHERE
    NOT person=friend
WITH DISTINCT friend
MATCH (friend)<-[membership:HAS_MEMBER]-(forum)
WHERE
    membership.joinDate > 1288612800000
WITH
    forum,
    collect(friend) AS friends
OPTIONAL MATCH (friend)<-[:HAS_CREATOR]-(post)<-[:CONTAINER_OF]-(forum)
WHERE
    friend IN friends
WITH
    forum,
    count(post) AS postCount
RETURN
    forum.title AS forumName,
    postCount
LIMIT 20
$$) AS (result1 agtype, result2 agtype);' from generate_series(1,10) \gexec



-- error ; invalid variable reuse
-- Q6
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (knownTag:Tag { name: 'Carl_Gustaf_Emil_Mannerheim' })
WITH knownTag.id as knownTagId

MATCH (person:Person { id: 4398046511334 })-[:KNOWS*1..2]-(friend)
WHERE NOT person=friend
WITH
    knownTagId,
    collect(distinct friend) as friends
UNWIND friends as f
    MATCH (f)<-[:HAS_CREATOR]-(post:Post),
          (post)-[:HAS_TAG]->(t:Tag{id: knownTagId}),
          (post)-[:HAS_TAG]->(tag:Tag)
    WHERE NOT t = tag
    WITH
        tag.name as tagName,
        count(post) as postCount
RETURN
    tagName,
    postCount
LIMIT 10
$$) AS (result1 agtype, result2 agtype);' from generate_series(1,10) \gexec


-- syntax error
-- Q7
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 4398046511269})<-[:HAS_CREATOR]-(message:Comment)<-[like:LIKES]-(liker:Person)
    WITH liker, message, like.creationDate AS likeTime, person
    WITH liker, head(collect({msg: message, likeTime: likeTime})) AS latestLike, person
RETURN
    liker.id AS personId,
    liker.firstName AS personFirstName,
    liker.lastName AS personLastName,
    latestLike.likeTime AS likeCreationDate,
    latestLike.msg.id AS commentOrPostId,
    coalesce(latestLike.msg.content, latestLike.msg.imageFile) AS commentOrPostContent,
    toInteger(floor(toFloat(latestLike.likeTime - latestLike.msg.creationDate)/1000.0)/60.0) AS minutesLatency,
    not((liker)-[:KNOWS]-(person)) AS isNew
LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype, result7 agtype, result8 agtype);' from generate_series(1,10) \gexec




-- works fine
-- Q8
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (start:Person {id: 144})<-[:HAS_CREATOR]-(:Comment)<-[:REPLY_OF]-(comment:Comment)-[:HAS_CREATOR]->(person:Person)
RETURN
    person.id AS personId,
    person.firstName AS personFirstName,
    person.lastName AS personLastName,
    comment.creationDate AS commentCreationDate,
    comment.id AS commentId,
    comment.content AS commentContent
LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype);' from generate_series(1,10) \gexec



-- Q9
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (root:Person {id: 4398046511269 })-[:KNOWS*1..2]-(friend:Person)
WHERE NOT friend = root
WITH collect(distinct friend) as friends
UNWIND friends as friend
    MATCH (friend)<-[:HAS_CREATOR]-(message:Comment)
    WHERE message.creationDate < 1289908800000
RETURN
    friend.id AS personId,
    friend.firstName AS personFirstName,
    friend.lastName AS personLastName,
    message.id AS commentOrPostId,
    coalesce(message.content,message.imageFile) AS commentOrPostContent,
    message.creationDate AS commentOrPostCreationDate
ORDER BY
    message.id ASC
LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype);' from generate_series(1,10) \gexec




-- error; using edge label in path constraint in WHERE clause
-- Q 10
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 4398046511334})-[:KNOWS*2..2]-(friend),
       (friend)-[:IS_LOCATED_IN]->(city:Place)
WHERE NOT friend=person AND
      NOT (friend)-[:KNOWS]-(person)
WITH person, city, friend, datetime({epochMillis: friend.birthday}) as birthday
WHERE  (birthday.month=5 AND birthday.day>=21) OR
        (birthday.month=(5%12)+1 AND birthday.day<22)
WITH DISTINCT friend, city, person
OPTIONAL MATCH (friend)<-[:HAS_CREATOR]-(post:Post)
WITH friend, city, collect(post) AS posts, person
WITH friend,
     city,
     size(posts) AS postCount,
     size([p IN posts WHERE (p)-[:HAS_TAG]->()<-[:HAS_INTEREST]-(person)]) AS commonPostCount
RETURN friend.id AS personId,
       friend.firstName AS personFirstName,
       friend.lastName AS personLastName,
       commonPostCount - (postCount - commonPostCount) AS commonInterestScore,
       friend.gender AS personGender,
       city.name AS personCityName
LIMIT 10
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype, result6 agtype);' from generate_series(1,10) \gexec



-- doesnt return anything
-- this query would work --corrected
-- Q 11
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 10995116277919 })-[:KNOWS]-(friend:Person)
WHERE not(person=friend)
WITH DISTINCT friend
MATCH (friend)-[workAt:WORK_AT]->(company:Organisation)-[:IS_LOCATED_IN]->(:Place  {name: ''Sweden'' })
RETURN
        friend.id AS personId,
        friend.firstName AS personFirstName,
        friend.lastName AS personLastName,
        company.name AS organizationName,
        workAt.workFrom AS organizationWorkFromYear
LIMIT 10
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype);' from generate_series(1,10) \gexec

SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 10995116277919 })-[:KNOWS*1..2]-(friend:Person)
WHERE not(person=friend)
WITH DISTINCT friend
MATCH (friend)-[workAt:WORK_AT]->(company:Organisation)-[:IS_LOCATED_IN]->(:Place {name: ''Hungary'' })
WHERE workAt.workFrom < 2011
RETURN
        friend.id AS personId,
        friend.firstName AS personFirstName,
        friend.lastName AS personLastName,
        company.name AS organizationName,
        workAt.workFrom AS organizationWorkFromYear
LIMIT 10
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype);' from generate_series(1,10) \gexec


-- doesnt return anything; removing the VLE expr returns the results
-- corrected
-- Q12
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (tag:Tag)-[e]->(baseTagClass:Tagclass)
WHERE (type(e) = ''HAS_TYPE'' OR type(e) = ''IS_SUBCLASS_OF'') AND (tag.name = ''Monarch'' OR baseTagClass.name = ''Monarch'')
WITH collect(tag.id) as tags
MATCH (:Person {id: 10995116278010 })-[:KNOWS]-(friend:Person)<-[:HAS_CREATOR]-(comment:Comment)-[:REPLY_OF]->(:Post)-[:HAS_TAG]->(tag:Tag)
WHERE tag.id in tags
RETURN
    friend.id AS personId,
    friend.firstName AS personFirstName,
    friend.lastName AS personLastName,
    collect(DISTINCT tag.name) AS tagNames,
    count(DISTINCT comment) AS replyCount
LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype);' from generate_series(1,10) \gexec


SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (tag:Tag)-[e*0..]->(baseTagClass:TagClass)
WHERE (type(e) = ''HAS_TYPE'' OR type(e) = ''IS_SUBCLASS_OF'') AND (tag.name = ''Monarch'' OR baseTagClass.name = ''Monarch'')
WITH collect(tag.id) as tags
MATCH (:Person {id: 10995116278010 })-[:KNOWS]-(friend:Person)<-[:HAS_CREATOR]-(comment:Comment)-[:REPLY_OF]->(:Post)-[:HAS_TAG]->(tag:Tag)
WHERE tag.id in tags
RETURN
    friend.id AS personId,
    friend.firstName AS personFirstName,
    friend.lastName AS personLastName,
    collect(DISTINCT tag.name) AS tagNames,
    count(DISTINCT comment) AS replyCount
LIMIT 20
$$) AS (result1 agtype, result2 agtype, result3 agtype, result4 agtype,
result5 agtype);' from generate_series(1,10) \gexec



-- Q13/14 not yet supported by AGE

--
-- update
--
-- Q1
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (c:Place {id: 117})
CREATE (p:Person {
    id: 35184372093118,
    firstName: "Sanjay",
    lastName: "Anand",
    gender: "male",
    birthday: 581990400000,
    creationDate: 1347533555467,
    locationIP: "103.1.131.183",
    browserUsed: "Firefox",
    languages: ["te","bn","en"],
    email: ["Sanjay35184372093118@gmail.com","Sanjay35184372093118@gmx.com","Sanjay35184372093118@yahoo.com"]
  })-[:IS_LOCATED_IN]->(c)
WITH p, count(*) AS dummy1
UNWIND [4,571,1187,2931,8163,10222,12296] AS tagId
  MATCH (t:Tag {id: tagId})
  CREATE (p)-[:HAS_INTEREST]->(t)
WITH p, count(*) AS dummy2
UNWIND [[3650,2007]] AS s
  MATCH (u:Organisation {id: s[0]})
  CREATE (p)-[:STUDY_AT {classYear: s[1]}]->(u)
WITH p, count(*) AS dummy3
UNWIND [[554,2008]] AS w
  MATCH (comp:Organisation {id: w[0]})
  CREATE (p)-[:WORKS_AT {workFrom: w[1]}]->(comp)
$$) AS (result1 agtype);' from generate_series(1,1) \gexec

-- Q2
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 103}), (post:Post {id: 274877912424})
CREATE (person)-[:LIKES {creationDate: 1347528992194}]->(post)
$$) AS (result1 agtype);' from generate_series(1,1) \gexec




-- Q3
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (person:Person {id: 103}), (comment:Comment {id: 274877909594})
CREATE (person)-[:LIKES {creationDate: 1347529096733}]->(comment)
$$) AS (result1 agtype);' from generate_series(1,1) \gexec



-- Q4
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (p:Person {id: 103})
CREATE (f:Forum {id: 2199023287110, title: "Album 14 of Brian Kelly", creationDate: 1347529304194})-[:HAS_MODERATOR]->(p)
WITH f
UNWIND [12273] AS tagId
  MATCH (t:Tag {id: tagId})
  CREATE (f)-[:HAS_TAG]->(t)
$$) AS (result1 agtype);' from generate_series(1,1) \gexec



-- Q5
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (f:Forum {id: 690}), (p:Person {id: 103})
CREATE (f)-[:HAS_MEMBER {joinDate: 1347528962967}]->(p)
$$) AS (result1 agtype);' from generate_series(1,1) \gexec



-- Q6-7 not supported by AGE yet

-- Q8
SELECT 'SELECT * FROM cypher(''benchmark'', 
$$
MATCH (p1:Person {id: 103}), (p2:Person {id: 2199023255739})
CREATE (p1)-[:KNOWS {creationDate: 1347529389109}]->(p2)
$$) AS (result1 agtype);' from generate_series(1,1) \gexec