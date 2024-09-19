
1.a)

Because  , where   is the variance-covariance matrix of  ,  .
Thus   .

1.b)
Code:
set.seed(1234)
n<-100
mu<-c(3,2)
sd<-c(2,6**0.5)
rho<-0
beta<-c(5,0.4,0.2)
sigma<-10**0.5
mydata<-simdat(mu, sd, rho, n, beta,sigma)
X<-cbind(1, as.matrix(mydata[,c(2,3)]))
Qxx<-round(crossprod(X)/n,2)
Qxx

Answer:
 .
  is close to  .

1.c)
Code:
set.seed(2345)
n<-1000
mydata<-simdat(mu, sd, rho, n, beta,sigma)
X<-cbind(1, as.matrix(mydata[,c(2,3)]))
Qxx<-round(crossprod(X)/n,2)
Qxx

Answer:
  is closer to   compared with n=100.

1.d)
Code:
Qxx<-matrix(c(1,3,2,3,13,6,2,6,10),nrow=3)
Vbar<-round(solve(Qxx)*10,2)
Vbar

Answer:
 .

1.e)
 ,  Let  , .
 .
Code:
set.seed(2345)
n<-1000
mydata<-simdat(mu, sd, rho, n, beta,sigma)
X<-cbind(1, as.matrix(mydata[,c(2,3)]))
y<-as.matrix(mydata[,1])
beta<-solve(crossprod(X))%*%crossprod(X,y)
residual<-y-X%*%beta
ssquare<-crossprod(residual)[1,1]/997
V<-round(solve(crossprod(X))*ssquare,4)
V

1.f)
 .It is close to .
Explanation:
Firstly, segment   by rows we have  ,where   is   i.i.d multivariate normal distribution vector. Thus  ,by applying Khinchin’s law of large numbers we have  .  .
Secondly,  ,   is the annihilator matrix of X. Because  ,  where   and   is diagonal matrix with trace(Mx)=n-k of 1 elements and zero elements on the diagonal. Thus 
  is a chi-square distribution with df n-k. Thus  .
Thus  
2.a)
 .

 
Code:
mu<-c(1,4)
sd<-c(1,2)
rho<-0.3
n<-100
beta<-c(0.5,1.5,3.0)
sigma<-2
t<-vector(length=100)
CI1<-vector(length=100)
CI2<-vector(length=100)
for (i in seq(1,100,by=1)){
  mydata <- simdat(mu, sd, rho, n, beta, sigma) 
  fit<-lm(y~x1+x2,data=mydata)
  t[i]<-(summary(fit)$coefficients[2,1]-1.5)/summary(fit)$coefficients[2,2]
  CI1[i]<-summary(fit)$coefficients[2,1]-qt(0.9,97)*summary(fit)$coefficients[2,2]
  CI2[i]<-summary(fit)$coefficients[2,1]-qt(0.1,97)*summary(fit)$coefficients[2,2]
  }
df<-data.frame(n=c(1:100),CI1=CI1, CI2=CI2)
yes<-vector(length=100)
for (i in 1:100){
  yes[i]<-(CI1[i]<=1.5)&&(CI2[i]>=1.5)
}

library(ggplot2)
p1 <- ggplot(df[yes,])+geom_errorbar(aes(x=n,ymin=CI1, ymax=CI2), width=0.2) 
print(p1)
p2<-geom_errorbar(data=df[!yes,],aes(x=n,ymin=CI1, ymax=CI2), width=0.2,color="red") 
overlay<-p1+p2
print(overlay)

2.b)
Code:
sum(yes)
Answer:
There are 83 out of 100 contain 1.5, the proportion is 0.83.

2.c)
 , where 1.29034 is the 0.9 quantile number of t(97) distribution. Thus when   is not happening, the Hypothesis   is rejected. 

Code:
yes1<-vector(length=100)
for (i in 1:100){
  yes1[i]<-(t[i]<=qt(0.9,97))&&(t[i]>=qt(0.1,97))
}
sum(!yes1)
Answer:
0.17. (17 test statistics rejects).

3.a)
   .
 
 .
 .

3.b)
 ,
 
 .
 . Where cdf is the cumulative distribution function of t(260) distribution.

3.c)
3.d)
 .
 .
3.e)
 .
 

 ,  >0.05. Thus we do not reject H0, means the hypothesis test is passed and H0 is true.

3.f)
 ,
 
,  . Thus we do not reject H0, H0 is true.
3.g)




