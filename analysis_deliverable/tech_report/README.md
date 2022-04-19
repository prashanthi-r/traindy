# Tech Report
This is where you can type out your tech report.

### A defined hypothesis or prediction task, with clearly stated metrics for success.

A defined hypothesis or prediction task, with clearly stated metrics for success.

One of the hypotheses we considered was the following:

We want to know whether the average day gap between transactions (ADGT) for digital customers are different from that of store customers.

In order to perform this statistical analysis, we define a metric, which we call “avg_freq” (for average frequency) as follows:

$$avg_freq = \frac{(date of last purchase - data of first purchase)}{total number of purchases in this period}$$

We populated a dataframe with all the customer IDs and each customer’s avg_freq value for each sales channel (store and digital). We then performed an independent T-test on these two dataframes to obtain a T-statistic of 26.187 and a p-value of 4.106e-151. Since the p-value is significantly small (<0.05), we can safely reject the null hypothesis. This leads us to the conclusion that the purchase patterns of digital customers are significantly different from the purchase patterns of store customers.


### Why did you use this statistical test or ML algorithm? 

We used the T-test because we wanted to compare two distributions to determine whether they are statistically different.

### Which other tests did you consider or evaluate? 


### How did you measure success or failure? Why that metric/value? What challenges did you face evaluating the model? Did you have to clean or restructure your data?
For the purposes of this project, we split our data into train (2017 - half of 2018 data) and test (remaining half of 2018 - 2019). We first converted the train data into a user purchase history matrix for each customer. This matrix would contain “1” if a user has purchased that product and “0” otherwise. We then trained our CVAE on this user purchase history matrix to obtain a latent space that our CVAE would use to generate new samples for a customer of a given category from the same distribution. In order to validate our model, we will calculate the precision and recall of the prediction on the train and test data. We alternatively consider using the cosine similarity between the predicted user history and the actual user history in the test dataset for returning users. 

On further discussion, we figured that precision and recall may be harsh metrics to evaluate the model with because the purchase patterns of a customer may not depend solely on the recommendations. There are several other ways to figure out the impact of the recommendation on the customer, such as their engagement time with that recommendation and number of clicks, etc. However, in the absence of this information, we cannot penalize the model for not predicting all of the customer’s future purchases. Therefore, we have decided to go with a new thresholded metric, that we call recall_30.   

One of the major challenges we faced while evaluating the model was because of the highly sparse nature of the user purchase history matrix. In other words, since customers end up purchasing a very small percentage of the total number of products, a lot of the entries in the matrix for each user are “0”. As a result, initially when we used these metrics to evaluate the model, we recognized that the model could simply produce a matrix with all 0’s and the loss would still be very low. As an extension of this catch, we also observed this behavior during training, where the model started “cheating” by learning to output all zeroes. However, we could fix this by replacing the loss function, which was originally MSE, with a cosine similarity-based loss function which pushes the model to produce outputs with some ones indicating possible predicted recommendations. 


### What is your interpretation of the results? Do accept or deny the hypothesis, or are you satisfied with your prediction accuracy? For prediction projects, we expect you to argue why you got the accuracy/success metric you have. Intuitively, how do you react to the results? Are you confident in the results?


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

### Full results + graphs (at least 1 stats/ml test and at least 1 visualization). You should push your visualizations to the /analysis_deliverable/visualizations folder in your repo. Depending on your model/test/project we would ideally like you to show us your full process so we can evaluate how you conducted the test!

### If you did a statistics test, are there any confounding trends or variables you might be observing?


### If you did a machine learning model, why did you choose this machine learning technique? Does your data have any sensitive/protected attributes that could affect your machine learning model?

We chose to build a recommendation engine for H & M products. We considered multiple recommendation approaches. Since we work with incredibly sparse matrices, we considered methods such as matrix factorization to represent the product ratings table and used a collaborative filtering approach to get recommendations. However, literature showed that people moved away from rating based approaches to more implicit methods. Ratings don’t make sense from our perspective because it only validates the quality of the product and not what attracted the customer in the first place i.e. the product and the images. Therefore, we decided to represent our data as a big binary matrix where a user can be represented as a long binary string of products they bought and didn't buy (1’s and 0’s). We moved away from linear decompositions and started looking at nonlinear decomposition. 

This led to us to lower dimensional representations of our incredibly sparse user purchase history matrix. We wanted to see if we could capture buying patterns for different types of users within a latent representation, which would later be sampled for a specific type of user to give out predictions on what the user may be interested in the future. We chose to use Conditional VAE’s for this task because we could achieve a smaller dimensional representation of our user purchase history through the use of neural networks where each layer acts as the linear operation that we see in matrix factorization and activation functions provide non linearity to the operation, as we squash the dimensions of the layers. This gives us a tight latent representation of our inputs. Pairing our latent representation with user cluster information provides us with recommended outputs for users. 

To create user clusters we used K-means clustering with cross validation on user specific data such as Average Dollar Spent (year), Active Period (Regularity of users), Age, Club Member Status, Sales Channel usage patterns etc. We tested different K values and created an elbow plot to decide on the ideal K value beyond which the error rate does not see significant difference. The labels of the clusters created form the labels for a given customer which is fed into the model described below to give out recommendations for products based on user cluster groups.

Thus to summarize our ML model uses a 2 model ensemble pipeline to generate recommendations. Here is an illustration:
![alt text](https://github.com/cs1951a-brown-spring-2022/TrainDy/blob/main/analysis_deliverable/Screen%20Shot%202022-04-18%20at%209.17.10%20PM.png)
