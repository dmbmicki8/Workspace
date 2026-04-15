## UNData API Exercise

In this exercise, you'll redo the data gathering phase of the UNData Exploration project by using APIs instead of downloading csv files.

You'll make use of the [World Bank Indicators API](https://datahelpdesk.worldbank.org/knowledgebase/articles/889392-about-the-indicators-api-documentation). Note that this API does not require an API key. Before attempting the exercise, it would be a good idea to skim through the Documentation page and to check out the [Basic Call Structure article](https://datahelpdesk.worldbank.org/knowledgebase/articles/898581).

1. Use the API to get all available data for the _GDP per capita, PPP (constant 2017 international $)_ indicator. Hint: this indicator has code "NY.GDP.PCAP.PP.KD". Adjust the query parameters so that you can retrieve all available rows. Convert the results to a DataFrame.

2. Now, use the API to get all available data for _Life expectancy at birth, total (years)_. This indicator has code "SP.DYN.LE00.IN". Again, convert the results to a DataFrame.

3. Merge the two results DataFrames together. You may want to rename or drop columns prior to merging.

4. You can also get more information about the available countries (region, capital city, income level classification, etc.) by using the [Country API](https://datahelpdesk.worldbank.org/knowledgebase/articles/898590-country-api-queries). Use this API to pull in all available data. Merge this with your other datasets. Use this to now remove the rows that correspond to regions and not countries.

**Bonus Questions:** After doing a basic request to get all records, you can attempt these exercises to get additional practice using query parameters.

1. Adjust your request so that it returns data just for the United States.

2. Adjust your request so that it returns data just for the United States for the year 2021.

3. Adjust your request so that it returns data just for the United States for the years 2000 through 2021.

4. Adjust your request so that it returns data for the United States and Canada for the years 2000 through 2021.

5. If you haven't already done so and you would like to get some additional practice using loops, use the page parameter in order to pull all records. Do not change the value of the per_page parameter. You will likely need to utilize a loop of some kind in order to pull all records.

6. The endpoint "http://api.worldbank.org/v2/indicator" will return information about all available indicators. See [Indicator API Queries](https://datahelpdesk.worldbank.org/knowledgebase/articles/898599-indicator-api-queries). Use this endpoint to find the code for the "Public Expenditure on Education (% GDP)" indicator.