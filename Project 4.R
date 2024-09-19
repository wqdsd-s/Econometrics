
Question 1. 
Code for loading data:
install.packages('mlbench')
library(mlbench)
data("BostonHousing2")
data=BostonHousing2[!is.na(BostonHousing2$medv),c("medv","rm","age","crim")]
X<-as.matrix(cbind(1, data[,c("rm","age","crim")]))
y<-data[,c("medv")]

1.a)
 .
 ,
Thus  .

Answer:
joint log-likelihood function:
 
link function:
 .

1.b)
Code:
ll<-function(theta,X,y){
n<-nrow(X)
ln<--n/2*(log(2*pi)+log(theta[5]))-1/2/theta[5]*(crossprod(y-X%*%theta[1:4])[1,1])
return(ln)
}

1.c)
Code:
out <- optim(par=c(0,0,0,0,var(y)), fn=ll,
                   X=X, y=y, hessian=TRUE,
                   control=list(fnscale=-1))
est <- out$par
se <- sqrt(diag(-1*solve(out$hessian)))

Answer:
 

1.d)
Code:
data1<-cbind(1, data[,c("rm","age","crim","medv")])
fit<-lm(medv~rm+age+crim,data=data1)
summary(fit)

Answer:
 .

Compare with  ,
The is close to , the first parameter   has more difference than the other 3 betas. However,  and   has huge difference from   and  , for lm() uses analytical expressions for the standard errors, whereas optim() uses numerical approximations to the Hessian matrix.

1.e)
Answer:
Yes, they make sense. , and they are all statistically significant. It means in the model, rm(average number of rooms per dwelling) is positively related with the value of house, the more average number of rooms, the higher house price in a census. More rooms means the house is bigger, thus results in higher median price. Also, age(proportion of older homes) has a negative effect on median house price, because the older the house is, more depreciation and renovation cost should be taken into account. Last, crim(per capita crime rate) has a negative effect on median house price, because higher crime rate reduces the demand of house in the census’s house market, resulting in lower house price. Also higher crime rate means poor living quality and higher poverty rate in the area, which are negatively related with house price.
The value of  is much higher than the other 2 betas, meaning rm(average number of rooms per dwelling) has much more effect on the median house price.

1.f)
Code:
set.seed(1234)
B <- 1000
n <- nrow(X)
res <- matrix(NA_real_, nrow=B, ncol=3)
for(b in 1:B) {
  draws <- sample(1:n, size=n, replace=T)
  res[b,] <- lm(medv~rm+age+crim, data=data1[draws, ])$coef[c(2,3,4)]
}
se <- apply(res, 2, function(x) sqrt(var(x)))

Answer:
 

1.g)
 
Thus all three   are rejected, meaning all three   slope coefficients statistically significantly different from zero at a 95% confidence level.

Check:
fit<-lm(medv~rm+age+crim,data=data1)
summary(fit)

OLS Output:
               Estimate   Std. Error  t value   Pr(>|t|)    
(Intercept)      -23.60556   2.76938  -8.524  < 2e-16 ***
  rm            8.03284   0.40201  19.982  < 2e-16 ***
  age          -0.05224    0.01046  -4.993   8.21e-07 ***
  crim         -0.21102    0.03407  -6.195   1.22e-09 ***
  ---
  Signif. codes:  
  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Thus in a OLS model, all three   slope coefficients are also statistically significantly different from zero at a 95% confidence level. It is the same result as in MLE.

Problem 2.
Code for loading data:
trading_behavior <- read.csv("C:/Users/Downloads/trading_behavior.csv")
trading_behavior<-trading_behavior[!is.na(trading_behavior $numtrades),]
X<-as.matrix(data.frame(one=1,d_MBA=as.numeric(trading_behavior[,'program']=='MBA'),d_MFE=as.numeric(trading_behavior[,'program']=='MFE'),finlittest=trading_behavior[,'finlittest']))
y<-trading_behavior[,'numtrades']

2.a)
Because  ,  ,
 .

2.b)
Code:
ll<-function(beta,X,y){
  ln<- sum(-exp(X%*%beta))+sum((X%*%beta)*y)-sum(log(factorial(y)))
  return(ln)
}

2.c)
Code:
out <- optim(par=c(0,0,0,0), fn=ll,
             X=X, y=y, hessian=TRUE,
             control=list(fnscale=-1))
est <- out$par
se <- sqrt(diag(-1*solve(out$hessian)))

Answer:
 

2.d)
Code:
df<-as.data.frame(cbind(y,X))
out1 <- glm(y ~ d_MBA+d_MFE+finlittest, data=df, family=poisson(link=log))
summary(out1)$coefficients

Answer:
GLM
Estimate   Std. Error   z value   Pr(>|z|)
(Intercept)     -7.0009343  0.8970568 -7.804338 5.981462e-15
d_MBA        1.0838591  0.3582530  3.025402 2.483032e-03
d_MFE        0.3698092  0.4410703  0.838436 4.017859e-01
finlittest       0.0701524  0.0105992  6.618647 3.625010e-11

Compared with 2.c), the answer is the same.

2.e)
Code:
est1<-est
est1[c(3,4)]<-0
LRn<-2*(ll(est,X,y)-ll(est1,X,y))
pvalue<-1-pchisq(LRn,4)
pvalue

Answer:
 
 , 
Thus we reject the null hypothesis  .

Question 3
Code:
yogurt_data <- read.csv("C:/Users/Downloads/yogurt_data.csv")
yogurt_data<-yogurt_data[!is.na(yogurt_data $y1),]

X1<-as.matrix(data.frame(d_1=1,d_2=0,d_3=0,Xf=yogurt_data[,'f1'],Xp=yogurt_data[,'p1']))
X2<-as.matrix(data.frame(d_1=0,d_2=1,d_3=0,Xf=yogurt_data[,'f2'],Xp=yogurt_data[,'p2']))
X3<-as.matrix(data.frame(d_1=0,d_2=0,d_3=1,Xf=yogurt_data[,'f3'],Xp=yogurt_data[,'p3']))
X4<-as.matrix(data.frame(d_1=0,d_2=0,d_3=0,Xf=yogurt_data[,'f4'],Xp=yogurt_data[,'p4']))
delta<-as.matrix(yogurt_data[,c(2,3,4,5)])
ll<-function(beta){
  Xb<-cbind(X1%*%beta,X2%*%beta,X3%*%beta,X4%*%beta)
  p<-exp(Xb)/rowSums(exp(Xb))
  ln<-sum(log(p)*delta)
  return(ln)
}
out <- optim(par=c(0,0,0,0,0), fn=ll,
             control=list(fnscale=-1))
est <- out$par

Answer:
 .
