# SQL Assessment - Poetry by Kids

> **Note:** The data in this exercise is derived from the datasets found [here](https://github.com/whipson/PoKi-Poems-by-Kids). An academic paper describing the PoKi project can be found [here](https://arxiv.org/abs/2004.06188)
> The data is used for education purposes with permission from the maintainer.  

## READ THIS FIRST

### Be careful of the `id` column.  It means something different in every table, so you will NEVER join on id.
### Your output should return names not id numbers.
### The data have been normalized to third normal form (3NF). Take care in choosing the correct primary and foreign key pairs to join on.

### Setup
1. Create a database named `PoetryKids` on your PostreSQL Server.
2. Right-click on the empty database and choose the `Restore` option. Navigate to the `poetrykids.tar` file by clicking on the ellipsis (`...`). Leave the defaults for all other options.

### ERD
![](./assets/PoetryKids_erd.png)


### Assessment
**Write SQL Queries to answer the questions below. Save your queries to a `.sql` script along with the answers (as comments) to the questions posed.**

1. The poetry in this database is the work of children in grades 1 through 5.  
    a. How many poets from each grade are represented in the data?  
    b. How many of the poets in each grade are Male and how many are Female? Only return the poets identified as Male or Female.  
    c. Briefly describe the trend you see across grade levels.

2. Two foods that are favorites of children are pizza and hamburgers. Which of these things do children write about more often? Which do they have the most to say about when they do?
    a. Return the **total number** of poems that mention **pizza** and **total number** that mention the word **hamburger** in the TEXT or TITLE, also return the **average character count** for poems that mention **pizza** and also for poems that mention the word **hamburger** in the TEXT or TITLE. Do this in a single query, (i.e. your output should contain all the information).

3. Do longer poems have more emotional intensity compared to shorter poems?  
    a. Start by writing a query to return each emotion in the database with its average intensity and average character count.   
     - Which emotion is associated the longest poems on average?  
     - Which emotion has the shortest?  

    b. Convert the query you wrote in part a into a CTE. Then find the 5 most intense poems that express anger and whether they are to be longer or shorter than the average angry poem.   
     -  What is the most angry poem about?  
     -  Do you think these are all classified correctly?

4. Compare the 5 most joyful poems by 1st graders to the 5 most joyful poems by 5th graders.  

  	a. Which group writes the most joyful poems according to the intensity score?  
    b. How many times do males show up in the top 5 poems for each grade?  Females?


5. Robert Frost was a famous American poet. There is 1 poet named `robert` per grade.

	a. Examine the 5 poets in the database with the name `robert`. Create a report showing the distribution of emotions that characterize their work by grade.  
	b. Export this report to Excel and create an appropriate visualization that shows what you have found.
  c. Write a short description that summarizes the visualization.
