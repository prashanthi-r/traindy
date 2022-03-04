# Tech Report

## DATA DELIVERABLES (some metadata and visualizations): https://docs.google.com/spreadsheets/d/1xQTzauyCMY7PSyFvPY2e67AwkOLXV8fPT3Z_BHlnDss/edit?usp=sharing

### Where is the data from?
The data is from Kaggle, posted by the H&M group. It contains the data and metadata of customer purchases across time. 

### How did you collect your data?
Currently, we have enough data for the purposes of this project. However, if there's a need, we plan to scrape ratings and reviews of H&M products from the website.

### Is the source reputable?
We believe that the source is reputable because Kaggle is one of the most credible websites used by data scientists across the world including companies such as Walmart and Facebook. The data comprises of three tables -- articles, customers, transactions. 

### How did you generate the sample? Is it comparably small or large? Is it representative or is it likely to exhibit some kind of sampling bias?
We uniformly sampled data from across all department types. It is comparably smaller than the full dataset and as a result it is likely that this sample set will exhibit sampling bias. However, since the data was sampled uniformly, it is representative of the whole dataset.

### Are there any other considerations you took into account when collecting your data? This is open-ended based on your data; feel free to leave this blank. (Example: If it's user data, is it public/are they consenting to have their data used? Is the data potentially skewed in any direction?)
The data has been provided to us by the H&M group via Kaggle after anonymizing customer IDs and other identification attributes. For the purposes of this project, we assume that the consent and privacy of the customers has been assured by H&M's customer privacy policies. 

### How clean is the data? Does this data contain what you need in order to complete the project you proposed to do? (Each team will have to go about answering this question differently, but use the following questions as a guide. Graphs and tables are highly encouraged if they allow you to answer these questions more succinctly.)
We did not have to scrape the data because this was provided to users in Kaggle. As a result, we did not have to clean the dataset much except for removing outliers and handling missing data. Further, we may have to clean our data when we scrape ratings and reviews from the H&M website.


### How many data points are there total? How many are there in each group you care about (e.g. if you are dividing your data into positive/negative examples, are they split evenly)? Do you think this is enough data to perform your analysis later on?
There are three tables -- articles, customers, transactions. In the transactions table, there are 31788323 data points, in the articles table there are 105541 data points, and in the customers table there are 1371979 data points. 
Yes, this is enough data to perform our analysis.

### Are there missing values? Do these occur in fields that are important for your project's goals?
Yes, and they do occur in some fields that are important for our analysis. We will have to handle missing values during our cleaning.

### Are there duplicates? Do these occur in fields that are important for your project's goals?
Yes there are duplicates. Yes they do occur in fields important for our project goals.

### How is the data distributed? Is it uniform or skewed? Are there outliers? What are the min/max values? (focus on the fields that are most relevant to your project goals)
Refer to 'Data Spec' sheet on the 'Data_Deliverables_TrainDy' google sheets.

### Are there any data type issues (e.g. words in fields that were supposed to be numeric)? Where are these coming from? (E.g. a bug in your scraper? User input?) How will you fix them?
Yes, there are data type issues. For some attributes, there are some int variables that are casted as string which may need to be casted back or .

### Do you need to throw any data away? What data? Why? Any reason this might affect the analyses you are able to run or the conclusions you are able to draw?
Yes, there is a lot of repetitive data like in the `articles' table which has numerical representation apart from string representation for the same attribute. These may need to be thrown away.
No, we do not believe that it might affect our analyses or any conclusion as it is just the repeated numerical data.

### Summarize any challenges or observations you have made since collecting your data. Then, discuss your next steps and how your data collection has impacted the type of analysis you will perform. (approximately 3-5 sentences)
- In the transactions table, there is no attribute corresponding to the quantity / number of units per transaction. This is a challenge because before performing any analysis on the entries in this table, we would have to clean the dataset to get idea of the transaction details.
- Another important observation is that data is limited to 3 years (2018 - 2020). This is challenging to handle because there may be insufficient transaction information at an individual level for personalized recommendations. 
- As with most recommendation systems, the model will struggle to handle cold starts, i.e., new customers, since there is no past data to base the personalized recommendations.
