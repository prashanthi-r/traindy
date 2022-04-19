# Tech Report
This is where you can type out your tech report.

We have answered only the questions in the handout as suggested by our mentor TA. 

### A defined hypothesis or prediction task, with clearly stated metrics for success.

A defined hypothesis or prediction task, with clearly stated metrics for success.

One of the hypotheses we considered was the following:

We want to know whether the average day gap between transactions (ADGT) for digital customers is different from that of store customers.

We define the null hypothesis, H_0 as: The means of the ADGTs for digital and store customers are similar to each other. As a result, our althernate hypothesis, H_a is: The means of the ADGTs for digital and store customers are different from each other.

In order to perform this statistical analysis, we define an industry standard metric, **ADGT** (average day gap between transactions) as follows:

$$adgt = \frac{(date of last purchase - data of first purchase)}{total number of purchases in this period}$$

We populated a dataframe with all the customer IDs and each customer’s ADGT value for each sales channel (store and digital). We then performed an independent T-test on these two dataframes to obtain a T-statistic of  and a p-value of 0.07. Since the p-value is higher than 0.001, we accept the null hypothesis. This leads us to the conclusion that the purchase patterns of digital customers are not significantly different from the purchase patterns of store customers; they are similar to each other.

Observe in the box plot graph that the means of the two distributions are aligned. This confirms our conclusion about accepting the null hypothesis.

![alt_text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/TTEST.png)

### Why did you use this statistical test? Did you find the results corresponding to your initial belief on the data? If Yes/No why do you think this was the case?

We used the two sample T-test because we wanted to compare two distributions to determine whether they are statistically different. Two sampled T-Tests determine whether the means of the two distributions are similar to each other.

Our initial belief was that the average day gap between transactions for digital customers would be lower as opposed to store customers, because of the convenience of online shopping. However, our results showed that there isn’t a statistically significant difference between the distributions. This is useful information for H & M because it helps them understand the purchasing trends and ensures they focus on both channels equally. This might be because people usually don’t shop on multiple days (laziness) and complete most transactions within the same day, much like online shopping.

### How did you measure success or failure? Why that metric/value? What challenges did you face evaluating the model? Did you have to clean or restructure your data?
For the purposes of this project, we split our data into train (2017 - half of 2018 data) and test (remaining half of 2018 - 2019). We first converted the train data into a user purchase history matrix for each customer. This matrix would contain “1” if a user has purchased that product and “0” otherwise. We then trained our CVAE on this user purchase history matrix to obtain a latent space that our CVAE would use to generate new samples for a customer of a given category from the same distribution. In order to validate our model, we will calculate the precision and recall of the prediction on the train and test data. We alternatively consider using the cosine similarity between the predicted user history and the actual user history in the test dataset for returning users. 

On further discussion, we figured that precision and recall may be harsh metrics to evaluate the model with because the purchase patterns of a customer may not depend solely on the recommendations. There are several other ways to figure out the impact of the recommendation on the customer, such as their engagement time with that recommendation and number of clicks, etc. However, in the absence of this information, we cannot penalize the model for not predicting all of the customer’s future purchases. Therefore, we have decided to go with a new thresholded metric, that we call **recall_30**. We define our measure of success as: if a customer purchases at least 30% of the products recommended to them. We then count the number of successfully recommended customers and divide by the total number of customers served to give our success score. However, we plan to implement this in the future after further deliberation. Currently, we have only evaluated the model on precision and recall. 

One of the major challenges we faced while evaluating the CVAE model was because of the highly sparse nature of the user purchase history matrix. In other words, since customers end up purchasing a very small percentage of the total number of products, a lot of the entries in the matrix for each user are “0”. As a result, initially when we used these metrics to evaluate the model, we recognized that the model could simply produce a matrix with all 0’s and the loss would still be very low. As an extension of this catch, we also observed this behavior during training, where the model started “cheating” by learning to output all zeroes. However, we could fix this by replacing the loss function, which was originally MSE, with a cosine similarity-based loss function which pushes the model to produce outputs with some ones indicating possible predicted recommendations. 

We also faced challenges with clustering part of our architecture because most of our demographic data for a given customer was categorical in nature. This does not work well with k means because there is no implicit distance ordering between different categories. We therefore considered k modes clustering to include categorical variables. However, due to how expensive the algorithm is in terms of time, we decided to filter out the categorical variables and purely use the continuous variables to cluster. We then use min max scaling to normalize the feature space. We will be doing more experiments with this aspect before the final submission.


### What is your interpretation of the results? Do accept or deny the hypothesis, or are you satisfied with your prediction accuracy? For prediction projects, we expect you to argue why you got the accuracy/success metric you have. Intuitively, how do you react to the results? Are you confident in the results?

ML model: Our model obtains a total recall of 0.1 as per our metric defined above. Currently, we are not satisfied with this recall. We do have a couple of factors that we want to look into in order to improve the model's performance. For instance, we could look into getting better clusters by improving our feature selection (in order to categorize customers better). Further, another important aspect of such recommendation systems is seasonality of sales, which we have not factored in yet. We hope to build an ensemble of models to account for seasonal trends. More importantly, we could play around with the hyperparameters and amount of training data. We could also train on more data to see if that makes the model perform better. 

As an experiment, we evaluated the model with a redefined metric, where we categorize even a single correct recommended prediction as a success. Our model predicted top 50 out of 21000 possible products for each customer on 50,000 data points. In this experiment, we obtained a success score of 73%.  

### For your visualization, why did you pick this graph? What alternative ways might you communicate the result? Were there any challenges visualizing the results, if so, what where they? Will your visualization require text to provide context or is it standalone (either is fine, but it's recognize which type your visualization is)?

(1) For our first visualization, we plotted two curves representing the total revenue for each sales channel over time. The Y axis represents Scaled Revenue and X axis represents time period. The green curve represents the revenue for the digital medium and the blue curve represents the revenue for the brick and mortar store. One can observe that both the curves have a similar distribution, albeit the difference is that the digital medium produces a higher revenue and more pronounced spikes. Another interesting observation is the part of the blue curve that is parallel to the X axis between the months of February and May 2020. Our guess is that this part must represent the lockdown period following the pandemic. The sudden vertical spikes in the two curves must represent holiday/special/seasonal sales. 

We picked this graph because knowing this information could be valuable to the company in increasing their revenue depending on the sales channel. Other ways we can communicate this information would be by providing the reader the mean, median, mode, and other statistical metrics of the two distributions. This visualization would require text to explain to provide context; although the legends and the axis labels are good enough to explain what the graph represents, it is important to provide textual context to explain the trends in the curves. 

![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/Revenue%20Over%20Time%20Across%20Channels.png)

(2) For our second visualization, we created a pie chart with the distribution of popular color choices. We picked this graph because it helps the company understand popular color choices in order to make their recommendation systems better. Another way to communicate this information would have been to make a table with the percentage for each color. In our opinion, this visualization would not require any text to explain because the colors and percentages have been labeled on the chart. 

![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/Pie%20Chart.png)

(3) For this visualization, we plotted the distribution of the customers across different ages. It is clear from the plot that this is a bimodal distribution. The plot peaks at two age groups, one around 20-25 and one around 50-55. We chose this visualization because it helps the company get an idea of the age groups they need to focus on to make more sales. Further, it is interesting to probe into why there are two peaks. One hypothesis would be that people around the ages of 50-55 have younger children in the age groups 15-25 and are buying clothes for their children, and as a result, 50-55 is a mode in the plot too. Another way to communicate this information would be to make a table with different age group bins and the number of people in each bin. Although this graph is well-labeled, I think a reader might benefit from having textual context explaining the peaks, patterns, and trends in the histogram.

![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/Distribution%20of%20the%20Customers%20Age.png)

(4) For this visualization, we plotted the multichannel transactional behavior over ages of the customers. From the plot, we can observe that sales are higher for multichannel customers as opposed to customers who shop from one channel alone. We chose this visualization because it is useful to understand sales as per to the sales channel. This visualization would require textual information to give context to the reader about the implication of the sales being higher for multichannels vs one channel alone. 

![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/WhatsApp%20Image%202022-04-18%20at%206.46.07%20PM.jpeg)

(5) Other visualizations:

![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/Mean%20Price%20Over%20Time.png)

### If you did a machine learning model, why did you choose this machine learning technique? Does your data have any sensitive/protected attributes that could affect your machine learning model?

We chose to build a recommendation engine for H & M products. We considered multiple recommendation approaches. Since we work with incredibly sparse matrices, we considered methods such as matrix factorization to represent the product ratings table and used a collaborative filtering approach to get recommendations. However, literature showed that people moved away from rating based approaches to more implicit methods. Ratings don’t make sense from our perspective because it only validates the quality of the product and not what attracted the customer in the first place i.e. the product and the images. Therefore, we decided to represent our data as a big binary matrix where a user can be represented as a long binary string of products they bought and didn't buy (1’s and 0’s). We moved away from linear decompositions and started looking at nonlinear decomposition. 

This led to us to lower dimensional representations of our incredibly sparse user purchase history matrix. We wanted to see if we could capture buying patterns for different types of users within a latent representation, which would later be sampled for a specific type of user to give out predictions on what the user may be interested in the future. We chose to use Conditional VAE’s for this task because we could achieve a smaller dimensional representation of our user purchase history through the use of neural networks where each layer acts as the linear operation that we see in matrix factorization and activation functions provide non linearity to the operation, as we squash the dimensions of the layers. This gives us a tight latent representation of our inputs. Pairing our latent representation with user cluster information provides us with recommended outputs for users. 

To create user clusters we used K-means clustering with cross validation on user specific data such as Average Dollar Spent (year), Active Period (Regularity of users), Age, Club Member Status, Sales Channel usage patterns etc. We tested different K values and created an elbow plot to decide on the ideal K value beyond which the error rate does not see significant difference. The labels of the clusters created form the labels for a given customer which is fed into the model described below to give out recommendations for products based on user cluster groups.

![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/download.png)

Thus to summarize our ML model uses a 2 model ensemble pipeline to generate recommendations. Here is an illustration:
![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/Screen%20Shot%202022-04-18%20at%209.17.10%20PM.png)
