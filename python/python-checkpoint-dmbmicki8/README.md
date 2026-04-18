

## 1

Create a dataframe titled `movie_ratings` that contains the ratings (G, PG, TV-G, etc) and how many of those movies exist in the dataframe.

---

## 2

Using the `movie_ratings` dataframe, create a **bar chart** that displays the count of the top 5 movie ratings.

> 💡 *Hint: Use `.plot.bar()` with `x='rating'` and `y='count'`. Don't forget to add a title and axis label!*

---

## 3

Using `movies_df`, subset the data to create a new dataframe named **`year_duration`** that contains only two columns:
- `release_year`
- `duration`

---

## 4

Using your `year_duration` dataframe, filter for movies released between **1975 and 1984** (inclusive) and find the:

- **Minimum** duration
- **Maximum** duration
- **Average** duration

---

## 5

Using the `year_duration` dataframe, create a **scatterplot** that shows movie durations over the years. Add a descriptive title to your chart.

After creating your plot, answer the following in a comment or markdown cell:

> *Do you notice any correlation between release year and movie duration?*

---

## 6

Find the **actual correlation value** between `release_year` and `duration`.

> 💡 *Hint: Use `.corr()` on the `year_duration` dataframe.*

Answer the following in a comment or markdown cell:

> *Based on the correlation value, is there a meaningful correlation between release year and duration?*

---

## 7

Using `movies_df`, find which **year had the most G-rated movie releases**.

> 🎯 *Challenge: Can you accomplish this in a single line of code?*

---

## 8

1. Find which **year had the most total movie releases**.
2. Create a new dataframe containing only movies from that year.
3. Convert the `duration` column to integers.
4. Use the **IQR method** to determine the upper and lower cutoffs for outliers.
5. Calculate what **percentage of movies** from that year had durations that were statistical outliers.

> 💡 *Hint: Outlier cutoffs are defined as:*
> - *Lower cutoff: Q1 − (1.5 × IQR)*
> - *Upper cutoff: Q3 + (1.5 × IQR)*

---

## 9
Add a new column called **`length_category`** to `movies_df` that categorizes each movie as one of the following:

| Category  | Duration               |
|-----------|------------------------|
| `short`   | 30 minutes or less     |
| `average` | Between 31–120 minutes |
| `long`    | More than 120 minutes  |


**Bonus:** Once the column is created, create a **pie chart** showing the distribution of movie length categories.

---

## 10

1. Create a new column called **`gap`** that calculates the difference between the year a movie was added to Disney+ and its original `release_year`.
2. Find the **movie with the greatest gap**.
3. Find the **average gap** across all movies.

