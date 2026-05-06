### Datasets
For this assessment you have been provided a single dataset, `gourds.csv`. This dataset contains the results of the Great Pumpkin Commonwealth Weighoff for the years 2013 through 2021. The columns of this dataframe are contained in the data dictionary.md file.

Your notebook should be able to be run error-free from top to bottom, including the `read_csv` calls.

### Instructions

0. Make a markdown cell in your notebook and type the following: "I, <Your Name>, did not use ChatGPT or any other AI/LLM to assist me on this assessment"

1. Create a Jupyter notebook and name it <firstname_gourds>. For example, John Smith's notebook would be named `john_gourds.ipynb`
2. Read in the gourds data into a DataFrame named `gourds` and look at the top 5 rows.
3. Which country shows up the most frequently in the dataset? Create a visualization (your choice) to show the frequency of appearances for the top 5 countries in terms of number of appearances.
4. The `weight` column currently contains a unit ("in" for Long Gourds and "lb" for every other type). Remove the unit from this so that you just have the numeric value and save the result back to the `weight` column. After doing this, sort the values on the weight column. You should find that the heaviest gourd in the dataset weighs 2702.9 lb. If you cannot find a solution for this question, you can use the `weight_bk` to answer the questions below that rely on it.
5. Create a line plot showing the trend in the **heaviest** gourd by year. What do you notice?
6. Read the `type_name.csv` dataset into a new DataFrame named `type_name`. Merge this with `gourds` to add on `type_name` column. Which type of gourd is heaviest on average? Create a visualization showing the distribution of gourd weights by type.
7. Create a new column `weight_error` that contains the amount by which the estimated weight exceeded the actual weight. What is the worst overestimate of a gourd weight? What percentage of gourd weights are overestimated?
8. Create a visualization to compare the estimated weight (`est_weight`) to the actual weight (`weight_lbs`). Note that both of these columns are numeric, so choose a type of visualization most appropriate for these data types. What do you notice from your visualization?
9. Some growers compete across multiple types of gourd. Which grower has **top 10** finishes across the largest number of types of gourds? What is this grower's best finish that shows up in the dataset?
10. The `seed_mother` and `pollinator_father` give information on the parents for each gourd.  
    a. How many gourds appear in the `seed_mother` column at least 100 times?  
    b. How many gourds appear in the `pollinator_father` column at least 100 times?  
    c. How many gourds have at least 100 offspring that have appeared in the GPC Weighoff? That is, how many gourds appear at least 100 times between the `seed_mother` and `pollinator_father` columns combined? Hint: One way you could do this is to create two `value_counts` Series on the `seed_mother` and `pollinator_father` columns and merge them.
