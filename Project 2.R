
Question 1: Covariance
1.a) Show that the correlation between random variables 𝑋 and 𝑌 (a feature of their joint distribution) is equivalent when de-meaning one or both variables. Namely, using the notation that 𝔼[𝑋] = 𝜇𝑋 and 𝔼[𝑌 ] = 𝜇𝑌 , show that cov(𝑋, 𝑌 ) = 𝔼[(𝑋 − 𝜇𝑋)(𝑌 − 𝜇𝑌 )] =𝔼[(𝑋 − 𝜇𝑋)𝑌 ]
  
 
 .
1.b) Show that the sample correlation between vectors 𝑋 and 𝑌 is equivalent when demeaning one or both variables. Namely, using the notation that 𝑛 ̄ 𝑋 = ∑𝑛𝑖=1 𝑋𝑖  and 𝑛 ̄𝑌 = ∑𝑛𝑖=1 𝑌𝑖 , show that (𝑛 − 1) cov ̂ (𝑋, 𝑌 ) = ∑𝑛𝑖=1(𝑋𝑖 − ̄𝑋)(𝑌𝑖 − ̄ 𝑌 ) = ∑𝑛𝑖=1(𝑋𝑖 − ̄𝑋)𝑌𝑖 .
 
   .
Question 2: Simpson’s Paradox and the FWL Theorem
2.a) Read 3.16 and 3.18 of BHE. Then, load the multi dataset which has the quantity sold (Sales) and prices (p1) for a product at 100 stores. The dataset also contains and prices (p2) of a competing product at those 100 stores. Create a scatterplot of Sales on the vertical axis and p1 on the horizontal axis. Regress Sales on p1 (ie, use least squares to ﬁnd the estimated coefficients for the model 𝑌 = 𝛽0 + 𝛽1𝑋 +   where Y is Sales and X is p1). Brieﬂy summarize the relationship you have discovered between Sales and p1. What is unusual about your ﬁnding?
  
Code:
install.packages('ggplot2')
library(ggplot2)
load("C:/Users/alex/Downloads/multi.RData")
p1 <- ggplot(multi,aes(p1,Sales)) + geom_point(shape=19) +
  xlab("p1") + ylab("Sales")
print(p1) 
fit<-lm(Sales~p1,data=multi)
summary(fit)

Output:
         Estimate  Std. Error   t     value Pr(>|t|)    
(Intercept)   211.16      66.49   3.176    0.002 ** 
  p1         63.71      13.04   4.886   4.01e-06 ***
Residual standard error: 223.4 on 98 degrees of freedom
Multiple R-squared:  0.1959,	Adjusted R-squared:  0.1877 
F-statistic: 23.87 on 1 and 98 DF,  p-value: 4.015e-06

Summary:
From the output we know: the coefficient of p1 is 63.71, its positive, means the more p1 are, the more sales. The P value of p1 is significant, means p1 is a good variable to explain sales. The F-statistic also significant, means p1 is a good explanation. However, the R-squared is only 0.1959, means the variance of sales hasn’t been explained enough, thus more variables should be added in to the model to fully explain Sales.
Moreover, the positive coefficient between p1 and sales isn’t usual because usually price goes up, sales goes down. Thus there must be other factors influencing it.

2.b) Sort the dataset by p2. Then assign colors to the points in groups of 20 (eg, the ﬁrst 20 data points are red, the second 20 are blue, etc.). Recreate your scatterplot from 1a above, but now color the points. Regress Sales on p1 and p2. What does this plot and the estimated regression coefficients tell you about the relationship between Sales, p1, and p2. See BEH 2.14 for a reminder.
 
Code:
multi1<-multi[order(multi$p2),]
p2 <- ggplot(multi1[1:20,],aes(p1,Sales)) + geom_point(shape=19,color="red")+xlab("p1") + ylab("Sales")
p3 <- geom_point(data=multi1[21:40,],aes(p1,Sales),shape=19,color="blue")
p4 <- geom_point(data=multi1[41:60,],aes(p1,Sales),shape=19,color="black")
p5 <- geom_point(data=multi1[61:80,],aes(p1,Sales),shape=19,color="yellow")
p6 <- geom_point(data=multi1[81:100,],aes(p1,Sales),shape=19,color="green")
overlay<-p2+p3+p4+p5+p6
print(overlay) 
fit1<-lm(Sales~p1+p2,data=multi)
summary(fit1)

Output:
Estimate  Std. Error  t value   Pr(>|t|)    
(Intercept)  115.717      8.548   13.54   <2e-16 ***
  p1           -97.657      2.669  -36.59   <2e-16 ***
  p2           108.800      1.409   77.20   <2e-16 ***
Residual standard error: 28.42 on 97 degrees of freedom
Multiple R-squared:  0.9871,	Adjusted R-squared:  0.9869 
F-statistic:  3717 on 2 and 97 DF,  p-value: < 2.2e-16

Explanations:
From the scatterplot we find that when p2 goes large, sales goes up no matter what p1 is. However, when p2 is fixed, then when p1 goes large, Sales goes down. Thus when add the p2 variable into the regression, the coefficient of p2 is significantly positive and coefficient of p1 is significantly negative. And the absolute value of the coefficient of p2 is larger than that of p1, because p2 dominates more of the going-up trend of Sales.
From the R2 we know when add both p1 and p2, the model fits much better than when only add p1. Because the two variables works with each other to explain Sales.
2.c) Regress p1 on p2. From this regression and your observations in 2b above, state some sort of economic theory or business decision that might explain the relationship between p1 and p2.
Code: 
fit2<-lm(Sales~p1+p2,data=multi)
summary(fit2)

Output:
  Estimate   Std. Error   t value  Pr(>|t|)    
(Intercept)  1.49261    0.28628   5.214 1.03e-06 ***
  p2       0.41371    0.03316  12.475  < 2e-16 ***
Residual standard error: 1.076 on 98 degrees of freedom
Multiple R-squared:  0.6136,	Adjusted R-squared:  0.6097 
F-statistic: 155.6 on 1 and 98 DF,  p-value: < 2.2e-16

Explanation:
The coefficient of p2 is significantly positive, means when p2 goes up, p1 also goes up. This can be explained that if the price of p2 in the market goes up, p1(the price of competing good) would also goes up because the demand of both goods is larger than its supply. 

2.d) Regress Sales on the residuals from the regression you ran in 2c above. Compare the estimated slope coefficients from this regression to your results in 2b above. Explain what is going on here.
Code:
s<-fit2[["residuals"]]
new<-cbind(multi,s)
fit3<-lm(Sales~s-1,data=new)
summary(fit3)

Output:
  Estimate Std. Error t value  Pr(>|t|)  
s   -97.66      53.17  -1.837   0.0693 .
Explanation:
The coefficient of residual equals to the coefficient of p1 when regress Y on p1 and p2. This is because of FWL theorem.

Question 3: Standard Errors
3.a) Write a function that takes 5 inputs:
1. mu a length-two vector of means for 𝑋1 and 𝑋2 ,
2. sd a length-two vector of standard deviations for 𝑋1 and 𝑋2 ,
3. rho the correlation between 𝑋1 and 𝑋2 ,
4. n the sample size, and
5. beta a length-three vector of coefficients. 
The function should draw n values of 𝑋1 and n values of 𝑋2 from a multivariate normal distribution MVN(𝜇 , Σ) where 𝜇 is the length-two vector of means and Σ is the 2 × 2 variance-covariance matrix that must be constructed from sd and rho (you may ﬁnd the function mvrnorm() from the MASS package to be helpful once you’ve calculated Σ from sd and rho).
The function should then use those 𝑛 draws of 𝑋1 and 𝑋2 along with beta to compute 𝑌 = 𝛽0 + 𝛽1𝑋1 + 𝛽2𝑋2 + 𝑒 where the length- 𝑛 vector 𝑒 is drawn from a N(0, 22 ) distribution.
The function should return an 𝑛 × 3 data.frame where the ﬁrst column is 𝑌 and the next two columns are 𝑋1 and 𝑋2 .
Code:
generate <- function(mu, sd, rho, n, beta) {
  cov<-rho*sd[1]*sd[2]
  var1<-sd[1]**2
  var2<-sd[2]**2
  sigma<-matrix(c(var1,cov,cov,var2),nrow=2)
  X<-mvrnorm(n,mu,sigma)
  Y<-cbind(1, X)%*%beta+rnorm(n,0,2)
  mydata<-as.data.frame(cbind(Y,X))
  names(mydata)<-c("Y","X1","X2")
  return (mydata)
}
3.b) Use your function from 3a above to generate a dataset with mu=c(3,7), sd=c(2,3), rho=0.7, n=1000, and beta=c(0,1,1). Regress 𝑌 on 𝑋1 and 𝑋2 using only the ﬁrst 10 observations and store the value of the standard error of ̂𝛽1 (call this (1)̂𝛽1 ). Then regress 𝑌 on 𝑋1 and 𝑋2 using only the ﬁrst 20 observations and store the value of the standard error of  ̂𝛽1 (call this 𝑠(2)̂𝛽1 ). Repeat this process until you ﬁt your 100th regression, which uses all 1000 observations. Plot 𝑛 on the horizontal axis versus (𝑛)̂𝛽1 on the vertical axis for the 100 stored values of 𝑠(𝑛)̂𝛽1 . What does this exercise demonstrate?
 
Code:
mu<-c(3,7)
sd<-c(2,3)
rho<-0.7
n<-1000
beta<-c(0,1,1)
mydata<-generate(mu, sd, rho, n, beta)
v=vector(length=100)
for (i in seq(10,1000,by=10)){
fit<-lm(Y~X1+X2-1,data=mydata[1:i,])
v[i/10]=summary(fit)$coefficients[1,2]
}
plot(x=seq(10,1000,by=10), y=v, type="o",pch=20,cex=0.7,xlab='n',ylab='standard error')
text(990, 0.1,as.character(round(v[100],3)))

Proof:
Denote  .
The standard error of   is  ,where  ,   is the   error vector with multivariate normal distribution  .
Firstly, segment   by rows we have  ,where   is   i.i.d multivariate normal distribution vector. Thus  ,by applying Khinchin’s law of large numbers we have  . Because  ,  . Then  , .
Secondly,  ,   is the annihilator matrix of X. Because  ,  where   and   is diagonal matrix with trace(Mx)=n-2 of 1 elements and 2 zero elements on the diagonal. Thus 
  is a chi-square distribution with df n-2. Thus  .
Finally,  . Thus when n is large   can be approximated by the function  .
Next we show the approximation using the function above and it works well.
 
plot(x=seq(10,1000,by=10), y=v, type="o",pch=20,cex=0.7,xlab='n',ylab='standard error',lwd=3)
lines(seq(1,1000,by=1),(4*0.4875588/seq(1,1000,by=1))**0.5,col='red',lwd=1)
legend('topright',legend=c('observation','approximation'),col=c('black','red'),lwd=1)

3.c) Write a loop. Each time through the loop:
1.start by setting the seed to 567 (ie, set.seed(567))
2.create a dataset using your function from 3a above where mu=c(3,7), sd=c(2,3), n=1000, and beta=c(0,1,1)
3. regress 𝑌 on 𝑋1 and 𝑋2
4. store the value of the standard error of  ̂𝛽1 (call this 𝑠(𝑛)̂𝛽1 )
Each time through the loop, you will use a diﬀerent value for rho, starting with 0.50, ending with 0.99, and going in increments of 0.01.
Plot rho the correlation of 𝑋1 and 𝑋2 (which ranges from 0.5 to 0.99) on the horizontal axis versus (𝑛)̂𝛽1 on the vertical axis for the 50 stored values of 𝑠(𝑛)̂𝛽1 . What does this exercise demonstrate?
 
Code:
set.seed(567)
mu<-c(3,7)
sd<-c(2,3)
n<-1000
beta<-c(0,1,1)
v<-vector(length=50)
for (rho in seq(0.5,0.99,by=0.01)){
  mydata<-generate(mu, sd, rho, n, beta)
  fit<-lm(Y~X1+X2-1,data=mydata)
  v[round((rho-0.5)/0.01+1)]=summary(fit)$coefficients[1,2]
}
plot(x=seq(0.5,0.99,by=0.01), y=v, type="o",pch=20,cex=0.7,xlab='rho',ylab='standard error',lwd=3)

Proof:
According to FWL theorem, the estimation of   can be calculated by the following way:
1.	Regress Y on X2, denote residual vector as  .
2.	Regress X1 on X2, denote residual vector as  .
3.	Regress   on  , the estimated parameter of   is  .
Thus,  . Thus .
When rho goes to 1, X1 and X2 become more and more linear correlated, when rho equals to 1, then they are totally linear correlated. Thus when regress X1 on X2, the SSR   approaches zero. Thus   become larger and larger when rho goes to 1.

Question 4: Standard Errors under Homoskedasticity and Heteroskedasticity
Load the Hitters dataset from the ISLR package. Drop any rows where Salary is NA. Assume the model is
𝑌 = 𝛽0 + 𝛽1𝑋1 + 𝛽2𝑋2 + 𝑒 where 𝑌 denotes Salary, 𝑋1 denotes Hits, and 𝑋2 denotes Years. See ?ISLR::Hitters for deﬁnitions of these variables.
4.a) By hand (ie, without using lm() or summary()), calculate the OLS estimates of the 3 beta coefficients.
Denote  ,  .

data(Hitters)
data=Hitters[!is.na(Hitters$Salary),c("Salary","Hits","Years")]
X<-as.matrix(cbind(1, data[,c("Hits","Years")]))
Y<-as.matrix(data[,c("Salary")])
solve(crossprod(X,X))%*%crossprod(X,Y)

4.b) Make the following two plots (1) a scatterplot of residuals on the vertical axis and Hits (𝑋1 ) on the horizontal axis, (2) the same scatterplot but with Years (𝑋2 ) on the horizontal axis instead of Hits (𝑋1 ). What do these plots suggest about an assumption of homoskedasticity or heteroskedasticity?
 
 
Code:
fit<-lm(Y~X-1)
install.packages('ggplot2')
library(ggplot2)
d1=data.frame(Hits=X[,c("Hits")],s=fit[["residuals"]])
p1 <- ggplot(d1,aes(Hits,s)) + geom_point(shape=19) +
  xlab("X1") + ylab("Residuals")
print(p1)
d2=data.frame(Years=X[,c("Years")],s=fit[["residuals"]])
p2 <- ggplot(d2,aes(Years,s)) + geom_point(shape=19) +
  xlab("X2") + ylab("Residuals")
print(p2)

Answer:
From the first plot, when X1 takes different values, the residuals all have an expectation close to zero, however, when X1 grows larger, the variance of the residuals seems to increase, thus it suggests an assumption of heteroskedasticity.
From the second plot, when X2 is below 6, the expectation of residuals is approximately below zero; however when X2 is in (6,10), the expectation is above zero. Thus it also suggests an assumption of heteroskedasticity.

4.c) By hand, calculate the standard errors of the OLS estimates under the assumption of homoskedasticity.
 ,  .
Thus  .

4.d) By hand, calculate the standard errors of the OLS estimates under the assumption of heteroskedasticity (use the HC1 estimated variance-covariance matrix).
 .
 .
Thus  .
4.e) By hand, calculate 𝑅2  and  ̄𝑅2 (the adjusted R-squared).
 ,
 .
 ,
 .

