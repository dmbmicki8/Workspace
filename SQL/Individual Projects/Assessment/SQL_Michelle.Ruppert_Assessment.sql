--The poetry in this database is the work of children in grades 1 through 5.
--1a. How many poets from each grade are represented in the data?

SELECT COUNT(grade_id), grade.name
FROM author
	JOIN grade
	ON author.grade_id = grade.id	
GROUP BY grade_id

--"count"	"name"
--3288		"4th Grade"
--1437		"2nd Grade"
--3464		"5th Grade"
--623		"1st Grade"
--2344		"3rd Grade"

--1b. How many of the poets in each grade are Male and how many are Female? Only return the poets identified as Male or Female.

SELECT COUNT(grade_id), grade.name AS grade, gender.name AS gender
FROM author
	JOIN grade
	ON author.grade_id = grade.id
	JOIN gender
	ON author.gender_id = gender.id
WHERE gender_id = 1 OR gender_id = 2
GROUP BY grade_id, gender.name, grade.name
ORDER BY grade.name ASC, gender.name ASC;

--"count"	"grade"		"gender"
--243		"1st Grade"	"Female"
--163		"1st Grade"	"Male"
--605		"2nd Grade"	"Female"
--412		"2nd Grade"	"Male"
--948		"3rd Grade"	"Female"
--577		"3rd Grade"	"Male"
--1241		"4th Grade"	"Female"
--723		"4th Grade"	"Male"
--1294		"5th Grade"	"Female"
--757		"5th Grade"	"Male"


--1c. Briefly describe the trend you see across grade levels.
--While all genders trend upwards during the year span, females have a higher participation rate in writing poetry. 

-----------------------------------------------------------------------------------------------------------
--2 Two foods that are favorites of children are pizza and hamburgers. Which of these things do children write about more often? Which do they have the most to say about when they do? 

--2a. Return the total number of poems that mention pizza and total number that mention the word hamburger in the TEXT or TITLE, also return the average character count for poems that mention pizza and also for poems that mention the word hamburger in the TEXT or TITLE. Do this in a single query, (i.e. your output should contain all the information).

SELECT 'pizza', COUNT(id), ROUND(AVG(char_count),2)
FROM poem
WHERE title LIKE '%pizza%' OR text LIKE '%pizza%'
UNION
SELECT 'hamburger', COUNT(id), ROUND(AVG(char_count),2)
FROM poem
WHERE title LIKE '%hamburger%' OR text LIKE '%hamburger%';

--"?column?"	"count"		"avg"
--"hamburger"		28		259.71
--"pizza"			226		241.49

--------------------------------------------------------------------------------------------------------------
--3 Do longer poems have more emotional intensity compared to shorter poems?
--3a. Start by writing a query to return each emotion in the database with its average intensity and average character count.

SELECT emotion.name, ROUND(AVG(intensity_percent),2) AS avg_intensity, ROUND(AVG(char_count),2) AS avg_char
FROM poem_emotion
	JOIN emotion
		ON poem_emotion.emotion_id = emotion.id
	JOIN poem
		ON poem_emotion.poem_id = poem.id
GROUP BY emotion.name
ORDER BY avg_intensity ASC, avg_char ASC;

--"name"	"avg_intensity"	"avg_char"
--"Sadness"		39.26		247.19
--"Anger"		43.57		261.16
--"Fear"		45.47		256.27
--"Joy"			47.82		220.99

--Which emotion is associated the longest poems on average? --ANGER--
--Which emotion has the shortest? -- JOY--
----------------------------------------------------------------------
--3b. Convert the query you wrote in part a into a CTE. Then find the 5 most intense poems that express anger and whether they are to be longer or shorter than the average angry poem.

WITH avg_emotions AS(
SELECT emotion.name, ROUND(AVG(intensity_percent),2) AS avg_intensity, ROUND(AVG(char_count),2) AS avg_char
FROM poem_emotion
	JOIN emotion
		ON poem_emotion.emotion_id = emotion.id
	JOIN poem
		ON poem_emotion.poem_id = poem.id
GROUP BY emotion.name
ORDER BY avg_intensity ASC, avg_char ASC
)
SELECT title, text, emotion.name, intensity_percent,
	CASE 
		WHEN poem.char_count > avg_char THEN 'longer'
		WHEN poem.char_count < avg_char THEN 'shorter'
		ELSE 'n/a'
		END AS poem_length
FROM poem_emotion
	JOIN emotion
	ON poem_emotion.emotion_id = emotion.id
	JOIN poem
	ON poem_emotion.poem_id = poem.id
	JOIN avg_emotions
	ON emotion.name = avg_emotions.name
WHERE emotion.name ='Anger'
ORDER BY intensity_percent DESC
LIMIT 5;

--What is the most angry poem about?
----There is a tie for the top two. The top one listed is about nature. Specifically Summer. 
--Do you think these are all classified correctly?
----From this short dataset, I am not sure. The top two under Anger don't really seem angry to me. Some of the others seem a bit more in that genre, but the top two do not fit the description. 
----------------------------------------------------------------------------------------------------
--4 Compare the 5 most joyful poems by 1st graders to the 5 most joyful poems by 5th graders.
(SELECT intensity_percent, author.name, grade.name AS grade, gender.name AS gender
FROM poem
	JOIN poem_emotion
	ON poem.id = poem_emotion.poem_id
	JOIN emotion 
	ON poem_emotion.emotion_id = emotion.id
	JOIN author
	ON poem.author_id = author.id
	JOIN grade
	ON author.grade_id = grade.id
	JOIN gender
	ON author.gender_id = gender.id
WHERE emotion.name = 'Joy'
	AND grade.name = '1st Grade'
	AND gender.name IN ('Male', 'Female')
ORDER BY intensity_percent DESC
LIMIT 5)
UNION
(SELECT intensity_percent, author.name, grade.name AS grade, gender.name AS gender
FROM poem
	JOIN poem_emotion
	ON poem.id = poem_emotion.poem_id
	JOIN emotion 
	ON poem_emotion.emotion_id = emotion.id
	JOIN author
	ON poem.author_id = author.id
	JOIN grade
	ON author.grade_id = grade.id
	JOIN gender
	ON author.gender_id = gender.id
WHERE emotion.name = 'Joy'
	AND grade.name = '5th Grade'
	AND gender.name IN ('Male', 'Female')
ORDER BY intensity_percent DESC
LIMIT 5);

--"intensity_percent"	"name"		"grade"		"gender"
	--83				"elly"		"1st Grade"	"Female"
	--83				"neely"		"1st Grade"	"Female"
	--86				"aden"		"1st Grade"	"Male"
	--86				"carina"	"1st Grade"	"Female"
	--86				"joshua"	"1st Grade"	"Male"
	--92				"james"		"5th Grade"	"Male"
	--94				"mark"		"5th Grade"	"Male"
	--98				"michael"	"5th Grade"	"Male"
	--98				"quintin"	"5th Grade"	"Male"
	--99				"mikaela"	"5th Grade"	"Female"

--4a. Which group writes the most joyful poems according to the intensity score?
--The 5th grade group has higher intensity scores than the 1st grade group

--4b. How many times do males show up in the top 5 poems for each grade? Females?
--In 1st grade they show up 2 times however, 5th grade they show up the majority of the time at 4 times. 

----------------------------------------------------------------------------------------------------
--5 Robert Frost was a famous American poet. There is 1 poet named robert per grade.

--5a. Examine the 5 poets in the database with the name robert. Create a report showing the distribution of emotions that characterize their work by grade.
SELECT author.name, poem.author_id, emotion.name AS emotion, poem_emotion.intensity_percent, grade.name AS grade
FROM poem
	JOIN poem_emotion
	ON poem.id = poem_emotion.poem_id
	JOIN emotion 
	ON poem_emotion.emotion_id = emotion.id
	JOIN author
	ON poem.author_id = author.id
	JOIN grade
	ON author.grade_id = grade.id
	JOIN gender
	ON author.gender_id = gender.id
WHERE author.name LIKE '%robert'
ORDER BY grade.name 

--5b. Export this report to Excel and create an appropriate visualization that shows what you have found. -roberts_Data

--5c. Write a short description that summarizes the visualization. All of the emotions increase as the grade goes up but Joy, Fear and Sadness seem to climb higher than Anger. Overall Joy seems to be a common theme among poems. Fear is disproportionately high in 2nd grade compared to other emotions at that grade level — which could warrant additional support.


