
Question 1
1.a)

Code:
x<-seq(0,5,length.out=50000)
plot(0,0,main='probability density function',xlim=c(0,5),ylim=c(0,5),xlab='x',ylab='PDF')
lines(x,exp(-x),col='red')
lines(x,3*exp(-3*x),col='blue')
lines(x,5*exp(-5*x),col='green')
legend('topright',legend=c('lambda=1','lambda=3','lambda=5'),col=c('red','blue','green'),lwd=1)

 
1.b)
Code:
set.seed(3344) 
y_rexp <- rexp(100, rate = 1.5)
hist(y_rexp, breaks = 50)

 

1.c)
 .
Code:
ll<-function(lamda,x){
  n=length(x)
  ln<- n*log(lamda)-lamda*sum(x)
  return(ln)
}
out <- optim(par=0.5, fn=ll,
              x=y_rexp,
              control=list(fnscale=-1),method="BFGS")
est <- out$par

Answer:
 .

1.d)
Code:
x<-seq(0.1,4,length.out=40000)
plot(0,0,xlim=c(0,4),ylim=c(-200,-30),xlab='lamda',ylab='ll')
lines(x,ll(x,y_rexp))
abline(v=1.5,col="red")
abline(v=est,col="green")
legend('bottomright',legend=c('lamda= 1.5',paste("est=", round(est,3))),col=c('red','green'),lwd=1)

 

1.e)
Because  ,
 . Thus
 .

Answer:
 .
 .

Question 2
2.a)
Code:
x<-seq(0,5,length.out=50000)
plot(0,0,main='probability density function',xlim=c(0,5),ylim=c(0,0.5),xlab='x',ylab='PDF')
lines(x,dgamma(x,2,1))
legend('topright',legend=c('alpha=2, beta=1'),lwd=1)
 
2.b)
 , 
thus   .

2.c)
Code:
set.seed(3344) 
y_rexp <- rexp(100, rate = 1.5)
x<-seq(0.01,4,length.out=40000)
plot(0,0,main='probability density function',xlim=c(0,4),ylim=c(0,3),xlab='lamda',ylab='PDF')
lines(x,dgamma(x,102,1+sum(y_rexp)))
legend('topright',legend=c('alpha=102, beta=58.889'),lwd=1)
 
2.d)
Code:
down=qgamma(0.025,102,1+sum(y_rexp))
up=qgamma(1-0.025,102,1+sum(y_rexp))

Answer:
 .

2.e)



Code:
set.seed(3344) 
y_rexp <- rexp(100, rate = 1.5)
n<-length(y_rexp)

likeli<-function(lamda){
  p<- (lamda**n)*exp(-lamda*sum(y_rexp))
  return(p)
}

draw_lamda<-function(lamda_old){
  while(T){
    lamda_new<-rnorm(1,lamda_old,0.2)
    if (lamda_new > 0) break
  }
  return(lamda_new)
}

whether_move<-function(ap){
  r<-runif(1,0,1)
  if(r>=ap) return(F)
  else return(T)
}
  
sample<-vector(l=10000)
sample[1]<-4
for(t in 2:10000) {
  candidate<-draw_lamda(sample[t-1])
  ap<-min(likeli(candidate)*dgamma(candidate,2,1)
          /likeli(sample[t-1])/dgamma(sample[t-1],2,1), 1)
  if(whether_move(ap)) {sample[t]<-candidate}
  else {sample[t]<-sample[t-1]}
}

hist(sample, breaks = 2000)
x<-seq(0.01,4,length.out=40000)
lines(x,dgamma(x,102,1+sum(y_rexp))*20,col="red")

Answer:
 
The red line is the density plotted in 2.c), we find that the histogram approximate the density perfectly.

2.f)
Code: mean(sample)
Answer: 1.736975.

2.g)
Code: s_sample<-sort(sample)
c(s_sample[250],s_sample[9750])
Answer:
 .
Question 3
3.a)
Set up DID model  , where  .
Matching the table given:  , thus
 

Answer:
 .  represents the expected outcome(employment) given time
equals to Feb and non-treatment group(pa state).
  represents the employment difference between treatment group(nj state) and non-treatment group(pa state), given time is Feb. (The initial group employment difference)
  represents the employment difference before and after treatment, given non-treatment group(pa state). (Time effect on non-treatment group).
  represents the ATT, the average treatment effect on the treated. 

3.b)
Code:
load("C:/Users/Downloads/card_krueger.Rdata")
ckdata1<-ckdata
ckdata['t']<-0
ckdata['d']<-2-as.numeric(ckdata[,'state'])
ckdata['Y']<-ckdata[,'emp_pre']
ckdata1['t']<-1
ckdata1['d']<-2-as.numeric(ckdata[,'state'])
ckdata1['Y']<-ckdata[,'emp_post']
data<-rbind(ckdata,ckdata1)
data['dt']<-data['d']*data['t']
model=lm(Y~d+t+dt,data=data)
down<-summary(model)$coefficients[,1]+qt(0.025,790)*summary(model)$coefficients[,2]
up<-summary(model)$coefficients[,1]-qt(0.025,790)*summary(model)$coefficients[,2]
interval<-cbind(down,up)

Answer:
   Estimate    Std. Error  t value   Pr(>|t|)    
(Intercept)     23.331     1.072   21.767   <2e-16 ***
  d           -2.892     1.194    -2.423   0.0156 *  
  t           -2.166      1.516   -1.429    0.1535    
dt           2.754      1.688    1.631    0.1033    
  Signif. codes:  
  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Estimates:
 .

Intervals:
down       up
beta0   21.227119  25.4352185
beta1   -5.234614  -0.5489079
beta2   -5.141160   0.8099912
beta3   -0.560693   6.0679046

 .

Interpretion:
From the result above, we know that the estimated ATT is 2.75, the P-value of it is 0.1033, meaning the ATT (average treatment effect on the treated) is positive, however it’s not statistically significantly positive. Increase in minimum wage has positive effect on teenage employment, however the effect is not significant.
  is 23.33, meaning the average employment of pa state in Feb 1992 is 23.33.
  is significantly negative under alpha=0.05, meaning when time is Feb, nj state’s average employment is significantly smaller than pa state.
  is negative but not significant, meaning the average employment in pa state decreased in 1992, however the time effect on non-treatment group (pa state) is not significant.
