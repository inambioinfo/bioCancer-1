> (Linear) Regression :  Ordinary Least Squares

<!--
The data `Clinical_gbm_tcga_pub_CNA_mRNA` used in this example is loaded from The Cancer Genome Atlas project of Glioblastoma (TCGA, Nature 2008). The data consists of 206 primary glioblastoma samples with some relevant clinical data and genetic profiles (mRNA and CNA).

Clinical data of cancerous patients (i.e tumor stage or age) are useful for establish an adequate therapeutic protocol (chemoherapy, radiotherapy, hormonotherapy). It may possible to associate other genetic profiles as gene expression or mutation to will be more accurate during pronostic. 
-->


### Summary

Start by selecting a dependent variables and one or more independents variables. If two or more Independent variables are included in the model we may want to investigate if any interactions are present. An interaction exists when the effect of an independent variable on the dependent variable is determined, at least partially, by the level of another independent variable. For example, the overall survival months may depends on gene expression (mRNA).

### Example 1: Is there a relationship Overall Survival (OS_MONTHS) and mRNA expression?

 We will proceed in two steps:

1. Estimate a regression model using mRNA expression of selected genes and overall survival months. Response variable: `OS_MONTHS` ; explanatory variables: `mRNA` and `Genes`; interpretations: 2-way `Genes:mRNA`.
Interpret each of your estimated coefficients. Also provide a statistical evaluation of the model as a whole.
2. Which genes are significant predictors of OS_MONTHS (use a 95% confidence level)?


![Regression 1 - summary](figures_quant/regression_summary.png)

The F-statistic suggests that the regression model as a whole explains a significant amount of variance in OS\_MONTHS. The calculated F-value is equal to 1.826 and has a  small p-value (< 0.01). The amount of variance in OS\_MONTHS explained by the model is equal to 1.7%

The null and alternate hypothesis for the F-test test can be formulated as follows:
H0: All regression coefficients are equal to 0
Ha: At least one regression coefficient is not equal to zero

The coefficients from the regression can be interpreted as follows (Only for significant p-value <0.05):

- For an **increase** in mRNA expression of `FANCF` we expect, on average, to see a **decrease** in Overall survival of 12.5 months, keeping all other variables constant (other genes).

Various additional outputs and options can be selected:

* RMSE: Root Mean Squared Error (Prediction error)
* Sum of Squares: The total variance in the dependent variable split into the variance explained by the model and the remainder
* VIF: Variance Inflation Factors and Rsq. These are measures of multi-collinearity for the independent variables
* Standardized coefficients: Coefficients may be hard to compare of the independent variables are measured on different scales. By standardizing the data before estimation we can see which variables move-the-needle most
* Step-wise: A data-mining approach to select the best fitting model

We can test if two or more variables together add significantly to the fit of a model. This function can be very useful to test if the overall influence of a variable of type `factor` is significant. for example we would predict if is there a relationship between mRNA expression and CNA of genes (`mRNA ~ Genes + CNA`).

### Predict

The `Prediction input` box allows you to calculate predicted values from a regression model. You must specify at least one variable and value to get a prediction. If you do not specify a value for each variable in the model either the mean value or the most frequent factor level will be used. It is only possible to predict outcomes based on variables in the model (e.g., `Genes` must one of the selected independent variables to predict the `OS_MONTHS` of one or multiple genes)

* To predict the OS\_MONTHS depending on FANCF `Genes = "FANCF` and press return
* To predict the OS\_MONTHS depending on mRNA expression ranging from -2 to 3, type `mRNA = seq(-2,3)` or `mRNA = -2:3`  and press return
* To predict the OS\_MONTHS depending on FANCF,PARP1,BRCA1 expression ranging from -2.7 to 3, type `Genes = c("FANCF","PARP1","BRCA1"), mRNA=-2.7:3` and press return

  ![Regression 1 - Predict](figures_quant/regression_predict.png)
  
  The plot shows the relationships of three gene expressions and OS\_MONTHS. The x-axis shows the mRNA levels and the y-axis indicates the predicted OS\_MONTHS. The details of the linear regression model is displyed below.  
<!--
### Example 2: Ideal data for regression

The data `ideal` contains simulated data that is very useful to demonstrate what data for and residuals from a regression should ideally look like.  The r-data file contains a data-frame with 1000 observations on 4 variables. y is the dependent variable and x1, x2, and x3 are independent variables. The plots shown below can be used as a bench mark for regressions on real world data. We will use Regression > Linear (OLS) to conduct the analysis. First go the the Plots tab and select y as the dependent variable and x1, x2, and x3 as the independent variables.

y, x2, and x3 appear roughly normally distributed whereas x1 appears roughly uniformly distributed. No indication of outliers or severely skewed distributions.

![Regression 2 - ideal histograms](figures_quant/regression_ideal_hist.png)

In the plot of correlations there are clear associations among the dependent and independent variables as well as among the independent variables themselves. Recall that in an experiment the x's of interest would have a zero correlation. The scatter plots in the lower-diagonal part of the plot show that the relationships between the variables are (approximately) linear.

![Regression 2 - ideal correlations](figures_quant/regression_ideal_corr.png)

The scatter plots of y (the dependent variable) against each of the independent variables confirm the insight from the correlation plot. The line fitted through the scatter plots is sufficiently flexible that it would pickup any non-linearities. The lines are, however, very straight suggesting that a basic linear will likely be appropriate.

![Regression 2 - ideal scatter](figures_quant/regression_ideal_scatter.png)

The dashboard of six residual plots looks excellent, as we might expect for these data. True values and predicted values from the regression form a straight line with random scatter, i.e., as the actual values of the dependent variable go up, so do the predicted values from the model. The residuals (i.e., the differences between the values of the dependent variable data and the values predicted by the regression) show no pattern and are randomly scattered around a horizontal axis. Any pattern would suggest that the model is better (or worse) at predicting some parts of the data compared to others. If a pattern were visible in the Residual vs Row order plot we might be concerned about auto-correlation. Again, the residuals are nicely scattered about a horizontal axis. Note that auto-correlation is problem we are concerned about when we have time-series data. The Q-Q plot shows a nice straight and diagonal line, evidence that the residuals are normally distributed. This conclusion is confirmed by the histogram of the residuals and the density plot of the residuals (green) versus the theoretical density of a normally distributed variable (blue line).

![Regression 2 - ideal dashboard](figures_quant/regression_ideal_dashboard.png)

The final diagnostic we will discuss is a set of plots of the residuals versus the independent variables (or predictors). There is no indication of any trends or heteroscedasticity. Any patterns in these plots would be cause for concern. There are also no outliers, i.e., points that are far from the main cloud of data points.

![Regression 2 - ideal residual vs predicted](figures_quant/regression_ideal_res_vs_pred.png)

Since the diagnostics look good, we can draw inferences from the regression. First, the model is significant as a whole: the p-value on the F-statistic is less than 0.05 therefore we reject the null hypothesis that all three variables in the regression have slope equal to zero. Second, each variable is statistically significant: for example, the p-value on the t-statistic for x1 is less than 0.05 therefore we reject the null hypothesis that x1 has slope equal to zero when x2 and x3 are also in the model (i.e., 'holding all other variables constant').

Increases in x1 and x3 are associated with increases in y whereas increases in x2 are associated with decreases in y. Since these are simulated data the exact interpretation of the coefficient is not interesting. However, in the scatterplot it looks like increases in x3 are associated with decreases in y. What explains the difference? Hint: consider the correlation plots.

![Regression 2 - ideal summary](figures_quant/regression_ideal_summary.png)

### Example 3: Linear or log-log regression?

Both linear and log-log regressions are commonly applied to business data. In this example we will look for evidence in the data and residuals that may which model specification is more appropriate for the available data.

The data `diamonds` contains information on prices of 3000 diamonds. A more complete description of the data and variables is available from the Data > Manage page. Select the variable `price` as the dependent variable and `carat` and `clarity` as the independent variables. Before looking at the parameter estimates from the regression go to the Plots tab to take a look at the data and residuals. Below are the set of histograms for the variables in the model. Prices and carats seem skewed to the right. Note that the direction of skew is determined by where the _tail_ is.

![Regression 3 - histograms](figures_quant/regression_diamonds_hist.png)

In the plot of correlations there are clear associations among the dependent and independent variables. The correlation between price and carat is extremely large (i.e., .93). The correlation between carat and clarity of the diamond is significant and negative.

![Regression 3 - correlations](figures_quant/regression_diamonds_corr.png)

The scatter plots of price (the dependent variable) against the independent variables are not as clean as for the 'ideal' data in example 2. The line fitted through the scatter plots is sufficiently flexible to pickup non-linearities. The line for carat seems to have some curvature and the points do not look randomly scattered around that line. In fact the points seem to fan-out for higher prices and number of carats. There does not seem to be very much movement in price for different levels of clarity. If anything, the price of the diamond seems to go down as clarity increase. A surprising result we will discuss in more detail below.

![Regression 3 - scatter](figures_quant/regression_diamonds_scatter.png)

The dashboard of six residual plots looks less than stellar. The true values and predicted values from the regression form an S-shaped curve. At higher actual and predicted values the spread of points around the line is wider, consistent with what we saw in the scatter plot of price versus carats. The residuals (i.e., the differences between the actual data and the values predicted by the regression) show an even more distinct pattern as they are clearly not randomly scattered around a horizontal axis. The Residual vs Row order plot looks perfectly straight indicating that auto-correlation is not a concern. Finally, while for the `ideal` data in example 2 the Q-Q plot showed a nice straight diagonal line, here dots clearly separate from the line at the right extreme, evidence that the residuals are not normally distributed. This conclusions is confirmed by the histogram and density plots of the residuals that show a more spiked appearance than a truly normally distributed variable would.

![Regression 3 - dashboard](figures_quant/regression_diamonds_dashboard.png)

The final diagnostic we will discuss is a set of plots of the residuals versus the independent variables (or predictors). The residuals fan-out from left to right in the plot of residuals vs carats. The box-plot of clarity versus residuals shows outliers with strong negative values for lower levels of clarity and outliers with strong positive values for diamonds with higher levels of clarity.
![Regression 3 - residual vs predicted](figures_quant/regression_diamonds_res_vs_pred.png)

Since the diagnostics do not look good, we should **not** draw inferences from this regression. A log-log specification may be preferable. A quick way to check the validity of this model change is available through the Data > Visualize tab. Select `price` as the Y-variable and `carat` as the X-variable in a `Scatter` plot. Check the `log X` and `log Y` boxes to produce the plot below. The relationship between log-price and log-carat looks close to linear. Exactly what we are looking for.

![Regression 3 - viz log scatter](figures_quant/regression_log_diamonds_viz_scatter.png)

We will apply a log transformation to both price and carat and rerun the analysis to see if the log-log specification is more appropriate for the data. This transformation can be done in Data > Transform. Select the variables price and carat. Choose `change` from the Transformation type drop-down and choose `Log` from the Apply function drop-down. Make sure to `Save changes` so the new variables are added to the dataset. Note that we cannot apply a log transformation to clarity because it is a <a href="http://en.wikipedia.org/wiki/Categorical_variable" target="_blank">categorical</a> variable.

In Regression > Linear (OLS) select the variable `log_price` as the dependent variable and `log_carat` and `clarity` as the independent variables. Before looking at the parameter estimates from the regression go to the Plots tab to take a look at the data and residuals. Below are the set of histograms for the variables in the model. log_price and log_carat are no longer right skewed, a good sign.

![Regression 3 - log histograms](figures_quant/regression_log_diamonds_hist.png)

In the plot of correlations there are still clear associations among the dependent and independent variables. The correlation between log_price and log_carat is extremely large (i.e., .93). The correlation between log_carat and clarity of the diamond is significant and negative.

![Regression 3 - log correlations](figures_quant/regression_log_diamonds_corr.png)

The scatter plots of log\_price (the dependent variable) against the independent variables are now much cleaner. The line through the scatter plot of log\_price versus log\_carat is (mostly) straight. Although the points do have a bit of a blocked shape around the line the scattering seem mostly random. We no longer see the points fan-out for higher values of log\_price and log\_carat. There seems to be a bit more movement in log\_price for different levels of clarity. However, the log_price of the diamond still goes down as clarity increase which is unexpected. We will discuss this result below.

![Regression 3 - log scatter](figures_quant/regression_log_diamonds_scatter.png)

The dashboard of six residual plots looks much better than for the linear model. The true values and predicted values from the regression (almost) form a straight line. At higher and lower actual and predicted values the line is perhaps still slightly curved. The residuals are much closer to a random scatter around a horizontal axis. The Residual vs Row order plot still looks perfectly straight indicating that auto-correlation is not a concern. Finally, the Q-Q plot shows a nice straight and diagonal line, just like we saw for the `ideal` data in example 2, Evidence that the residuals are now normally distributed. This conclusion is confirmed by the histogram and density plot of the residuals.

![Regression 3 - log dashboard](figures_quant/regression_log_diamonds_dashboard.png)

The final diagnostic we will discuss is a set of plots of the residuals versus the independent variables (or predictors). The residuals look much closer to random scatter around a horizontal line compared to the linear model, although for low (high) values of log_carat the residuals may be a bit higher (lower). The box-plot of clarity versus residuals now only shows a few outliers.

![Regression 3 - log residual vs predicted](figures_quant/regression_log_diamonds_res_vs_pred.png)

Since the diagnostics now look much better, we can feel more confident about drawing inferences from this regression. The regression results are available in the Summary tab. Note that we get 7 coefficients for the variable clarity compared to only one for `log_carat`. How come? If you look at the data description (Data > Manage) you will see that clarity is a categorical variables with levels that go from IF (worst clarity) to I1 (best clarity). Categorical variables must be converted to a set of dummy (or indicator) variables before we can apply numerical analysis tools like regression. Each dummy indicates if a particular diamond has a particular clarity level (=1) or not (=0). Interestingly, to capture all information in the 8-level clarity variable we only need 7 dummy variables. Note there is no dummy variable for the clarity level I1 because we don't actually need it in the regression. When a diamond is **not** of clarity SI2, SI1, VS2, VS1, VVS2, VVS1 or IF we know that in our data it must therefore be of clarity I1.

The F-statistic suggests that the regression model as a whole explains a significant amount of variance in log\_price. The calculated F-value is very large and has a very small p-value (< 0.001) so we can reject the null hypothesis that all regression coefficients are equal to zero. The amount of variance in log\_price explained by the model is equal to 96.6. It seems likely that prices of diamonds are much easier to predict than demand for diamonds.

The null and alternate hypothesis for the F-test test can be formulated as follows:
H0: All regression coefficients are equal to 0
Ha: At least one regression coefficient is not equal to zero

The coefficients from the regression can be interpreted as follows:

- For a 1% increase in carats we expect, on average, to see a 1.809% increase in the price of a diamond of, keeping all other variables constant
- Compared to a diamond of clarity I1 we expect, on average, to pay 100x(exp(.444)-1) = 55.89% more for a diamond of clarity SI2, keeping all other variables constant
- Compared to a diamond of clarity I1 we expect, on average, to pay 100x(exp(.591)-1) = 80.58% more for a diamond of clarity SI1, keeping all other variables constant
- Compared to a diamond of clarity I1 we expect, on average, to pay 100x(exp(1.080)-1) = 194.47% more for a diamond of clarity IF, keeping all other variables constant

The coefficients for each of the levels of clarity imply that an increase in clarity will increase the price of diamond. Why then did the boxplot of clarity versus (log) price show price decreasing with clarity? The difference is that in a regression we can determine the effect of a change in one variable (e.g., clarity) keeping all else constant (e.g., carat). Bigger, heavier, diamonds are more likely to have flaws compared to small diamonds so when we look at the boxplot we are really seeing the effect of not only improving clarity on price but also the effect of carats which are negatively correlated with clarity. In a regression we can compare the effects of different levels of clarity on (log) price for a diamond of **the same size** (i.e., keeping carat constant). Without (log) carat in the model the estimated effect of clarity would be incorrect due to <a href="http://en.wikipedia.org/wiki/Omitted-variable_bias" target="_blank">omitted variable bias</a>. In fact, from a regression of log_price on clarity we would conclude that a diamond of the highest clarity in the data (IF) would cost 59.22% less compared to a diamond of the lowest clarity (I1). Clearly this is not a sensible conclusion.

For each of the independent variables the following null and alternate hypotheses can be formulated:
H0: The coefficient associated with independent variable X is equal to 0
Ha: The coefficient associated with independent variable X is not equal to 0

All coefficients in this regression are highly significant.

![Regression 3 - log summary](figures_quant/regression_log_diamonds_summary.png)


### Technical notes

#### Coefficient interpretation for linear model

To illustrate the interpretation of coefficients in a regression model we start with the following equation:

$$
  S_t = a + b P_t + c D_t + \epsilon_t
$$

where $S_t$ is sales in units at time $t$, $P_t$ is the price in \$ at time $t$, $D_t$ is a dummy variable that indicates if a product is on display in a given week, and $\epsilon_t$ is the error term.

For a continuous variable such as price we can determine the effect of a \$1 change, while keeping all other variables constant, by taking the partial derivative of the sales equation with respect to $P$.

$$
  \frac{ \partial S_t }{ \partial P_t } = b
$$

So $b$ is the marginal effect on sales of a \$1 change in price. Because a dummy variable such as $D$ is not continuous we cannot use differentiation and the approach needed to determine the marginal effect is a little different. If we compare sales levels when $D = 1$ to sales levels when $D = 0$ we see that

$$
  a + b P_t + c \times 1 - a + b P_t + c \times 0 = c
$$

For a linear model $c$ is the marginal effect on sales when the product is on display.

#### Coefficient interpretation for a semi-log model

To illustrate the interpretation of coefficients in a semi-log regression model we start with the following equation:

$$
  ln S_t = a + b P_t + c D_t + \epsilon_t
$$

where $ln S_t$ is the (natural) log of sales at time $t$. For a continuous variable such as price we can again determine the effect of a \$1 change, while keeping all other variables constant, by taking the partial derivative of the sales equation with respect to $P$. For the left-hand side of the equation we can use the chain-rule to get

$$
  \frac {\partial ln S_t}{\partial P_t} = \frac{1}{S_t} \frac{\partial S_t}{\partial P_t}
$$

In words, the derivative of the natural logarithm of a variable is the reciprocal of that variable, times the derivative of that variable. From the discussion on the linear model above we know that

$$
	\frac{ \partial a + b P_t + c D_t}{ \partial P_t } = b
$$

Combining these two equations gives

$$
  \frac {1}{S_t} \frac{\partial S_t}{\partial P_t} = b \; \text{or} \; \frac {\Delta S_t}{S_t} \approx b
$$

So a \$1 change in price leads to a $b$% change in sales. Because a dummy variable such as $D$ is not continuous we cannot use differentiation and will again compare sales levels when $D = 1$ to sales levels when $D = 0$ to get $\frac {\Delta S_t}{S_t}$. To get $S_t$ rather than $ln S_t$ on the left hand side we take the exponent of both sides. This gives $S_t = e^{a + b P_t + c D_t}$. The percentage change in $S_t$ when $D_t$ changes from 0 to 1 is then given by:

$$
  \begin{aligned}
  \frac {\Delta S_t}{S_t} &\approx \frac{ e^{a + b P_t + c\times 1} - e^{a + b P_t + c \times 0} } {e^{a + b P_t + c \times 0} }\\
  &= \frac{ e^{a + b P_t} e^c - e^{a + b P_t} }{ e^{a + b P_t} }\\
  &= e^c - 1
  \end{aligned}
$$

For the semi-log model 100 $\times\:c$ is the percentage change in sales when the product is on display.

#### Coefficient interpretation for a log-log model

To illustrate the interpretation of coefficients in a log-log regression model we start with the following equation:

$$
  ln S_t = a + b ln P_t + \epsilon_t
$$

where $ln P_t$ is the (natural) log of sales at time $t$. Ignoring the error term for simplicity we can rewrite this model in its multiplicative form by taking the exponent on both sides:

$$
  \begin{aligned}
  S_t &= e^a + e^{b ln P_t}\\
  S_t &= a^* P^b_t
  \end{aligned}
$$

where $a^* = e^a$ For a continuous variable such as price we can again take the partial derivative of the sales equation with respect to $P_t$ to get the marginal effect.

$$
  \begin{aligned}
  \frac{\partial S_t}{\partial P_t} &= b a^* P^{b-1}_t\\
  &= b S_t P^{-1}_t\\
  &= b \frac{S_t}{P_t}
  \end{aligned}
$$

The general formula for an elasticity is $\frac{\partial S_t}{\partial P_