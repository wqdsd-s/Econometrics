Question 1: Expectations
1.a) Deﬁne both and explain the diﬀerence between (1) the expectation of a random variable and (2) the sample average.
Definition:
(1)	the expectation of a random variable:
Consider a random variable  , the expectation of   was defined as:
	if   is a discrete random variable with distribution  , where   and  , then the expectation of  is  .
	if   is a continuous random variable with density function  where   and  , then then the expectation of  is  .
(2)	sample average:
If we have N observations of a random variable   by sampling method, denote as  , then the sample mean(average) is defined as  .

Difference:
(1)	the expectation of a random variable is derived from its distribution feature, it’s unique for a certain distribution; however a sample average is derived from a multiple sampling process, it’s based on observations, thus a sample average could vary when repeating the sampling process.
(2)	Under some certain assumption (for example i.i.d sampling), the sample average would converge to the expectation in probability as the number of samples N goes to infinite, according to the law of large numbers. Thus when the sampling times is large, the sample average could be used as an estimator of the expectation in some estimation methods like moment estimation.
Question 2: LLN & CLT
2.a) Plot the density of a Beta(5,2) distribution over it’s domain [0,1]. Make a publication-quality plot by changing any unwanted default plotting behavior and by adding relevant titles and labels. The ﬁrst parameter of the Beta distribution is often labeled 𝛼 and the second 𝛽.The dbeta() and related functions in R label these parameters as shape1 and shape2.
 
R code:
set.seed(1)
x<-seq(0,1,length.out=10000)
plot(0,0,main='beta probability density function',xlim=c(0,1),ylim=c(0,2.5),ylab='PDF')
lines(x,dbeta(x,5,2),col='red')
legend('topleft',legend=c('α=5,β=2'),col=c('red'),lwd=1)

2.b) State the Law of Large Numbers as simply as you can.
The Law of Large Number states that under some certain assumptions, the sample average(mean) converges to a certain value(the expectation) when n goes to infinite. This convergence can be convergence in probability  ( weak law of large numbers) or convergence almost surely   ( strong law of large numbers). There are different weak law of large numbers suitable for different scenarios, for example: Chebyshev law of large numbers for independent random variable sequence with finite expectation and bounded variance;  Khinchin's law of large numbers for i.i.d random variable sequence with only finite expectations , and so on.

2.c) Set the seed to the value 1234 (set.seed(1234)). Then take 1,000 random draws from the Beta(5,2) distribution using rbeta(). Calculate a running sample average.Speciﬁcally: calculate 𝑋1 = 𝑥1, then calculatē 𝑋2 = (1/2) ∑2𝑖=1 𝑋𝑖, then calculate ̄𝑋3 =(1/3) ∑3𝑖=1 𝑋𝑖. Continue until you have calculated̄𝑋1000 = (1/1000) ∑1000𝑖=1 𝑋 . Create a scatterplot with the values 1–1,000 on the horizontal axis and the 1,000 cumulative average values of 𝑋𝑖 for 𝑖 = 1, … , 1000 you calculated on the vertical axis. Compare your value for ̄𝑋1000 to the [𝑋] = 𝛼/(𝛼 + 𝛽) = 5/7 = 0.7143.

  
R code:
set.seed(1234)
x<-rbeta(1000,5,2)
c<-cumsum(x)
n=c(1:1000)
c<-c/n
plot(0,0,main='cummulative average',xlim=c(1,1000),ylim=c(0.5,1),xlab='n',ylab='cum_average')
lines(n,c,col='black',lwd=3)
x=seq(1,1,length=1000)
lines(n,0.7143*x,col='red',lwd=1)
legend('topright',legend=c('cum_average','expectation'),col=c('black','red'),lwd=1)

Compare and explanation:
As n grows large, the cumulative average of samples converges towards
the expectation of Beta(5,2) distribution. This can be explained by Law of
Large Number since the sample is i.i.d distributed with finite expectation.
Thus  .

2.d) State the Central Limit Theorem as simply as you can.
Central limit theorem shows that the sample average(mean) under independent sampling process converges in distribution to a normal distribution when n goes to infinite.. It shows the distribution feature of the sample average when  . There are usually two widely used kinds of CLTs, one is Lindeberg–Lévy CLT used in i.i.d scenario with finite expectation and variance:
 

Another is Lyapunov CLT used in only independent random variable scenario with different finite expectation and variance:

 

2.e) Make two plots. For the ﬁrst plot, take D=10 draws from the Beta(5,2) distribution and calculate the sample average. Repeat the process of taking D=10 draws and ﬁnding the sample average R=10,000 times. Plot a histogram of the 10,000 sample averages. For the second plot, repeat the process with D=100 draws. These two histograms are called “sampling distributions.”
 
r <- 10000
n <- 10
mat <- matrix(rbeta(n*r, 5,2),nrow=r, ncol=n)
xbar <- apply(mat, 1, mean)
hist(xbar, col="dodgerblue4", yaxt="n", ylab="",main="", xlab="", xlim=c(0,1))
legend('topleft',legend=c('D=10'),box.lty = 0)
 

r <- 10000
n <- 100
mat <- matrix(rbeta(n*r, 5,2),nrow=r, ncol=n)
xbar <- apply(mat, 1, mean)
hist(xbar, col="dodgerblue4", yaxt="n", ylab="",main="", xlab="", xlim=c(0,1))
legend('topleft',legend=c('D=100'),box.lty = 0)

Question 3: Linear Algebra
Suppose X and Y are deﬁned as follows.
             
3.a) What is the rank of X? Provide a brief (approx 1 sentence) explanation. Check your work via R code using Matrix::rankMatrix().
If  , then  , thus the columns of the
matrix X are linear independent, it’s a column full-rank matrix with rank 
equals to 2. 
R code:
X <- matrix(c(1,1,1,1,1,4,5,8), nrow = 4)
y<-matrix(c(6,5,3,2), nrow = 4)

Output:
> Matrix::rankMatrix(X)
[1] 2
attr(,"method")
[1] "tolNorm2"
attr(,"useGrad")
[1] FALSE
attr(,"tol")
[1] 8.881784e-16

3.b) Calculate X′X. Use the bmatrix environment in Latex to typeset your answer. Check your work via R code.

b)
 
X <- matrix(c(1,1,1,1,1,4,5,8), nrow = 4)
y<-matrix(c(6,5,3,2), nrow = 4)
a<-t(X)%*%X

Output:
> a
[,1] [,2]
[1,]    4   18
[2,]   18  106

3.c) What is the rank of X′X? Provide a brief explanation. Check your work via R code.
Because X is column full-ranked with rank 2, the dimension of the solution space of
equation   equals to k-rank(X)=2-2=0, 
thus it only has solution  . Thus for any  ,  , 
. Thus  is a positive definite matrix. 
Also, because   is a real symmetric matrix ,then can be decomposed as  , 
where   and   is a diagonal matrix with all  ’s eigen value on its diagonal.
Because is a positive definite matrix, then   is also a positive definite matrix, thus its
diagonal must all be positive, then   is full ranked with rank 2. So lastly,
 .

Output:
> Matrix::rankMatrix(a)
[1] 2
attr(,"method")
[1] "tolNorm2"
attr(,"useGrad")
[1] FALSE
attr(,"tol")
[1] 4.440892e-16

3.d) Find “by hand” (as you would with paper and pencil) using the approach outlined on slide 47 of the Class 1 slides. Check your work via R code.
 ,
 .
Output:
> solve(a)
[,1]  [,2]
[1,]  1.06 -0.18
[2,] -0.18  0.04

3.e) What is the rank of  ? Provide a brief explanation. Check your work via R code. 
Because  ,thus its nonsingular matrix, its invertible,  , 
thus  , thus   is also nonsingular matrix,  .
Output:
> Matrix::rankMatrix(solve(a))
[1] 2
attr(,"method")
[1] "tolNorm2"
attr(,"useGrad")
[1] FALSE
attr(,"tol")
[1] 4.440892e-16

3.f) Calculate X′y. Check your work via R code.
 .
Check:
> t(X)%*%y
[,1]
[1,]   16
[2,]   57

3.g) Use your results from 3d and 3f to calculate “by hand”  . Check your work via R code.
 .



Check:
> (solve(t(X)%*%X))%*%t(X)%*%y
[,1]
[1,]  6.7
[2,] -0.6
