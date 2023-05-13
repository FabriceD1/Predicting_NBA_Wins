install.packages("glmnet", repos = "http://cran.us.r-project.org")

library(glmnet)

nba <-read_csv("merged_data.csv")

attach(nba)

#alpha=1:LASSO (default)
#alpha=0:Ridge
#nlambda set the grid of 100 lambda's (default 100)
#standardize (default) data when fitting. return value back to original scale
#nfolds (default 10) set number of folds for cross validation
#type.measure set the measure for cross validation error (default MSE)


# Define the predictor variables
predictors <- c("FGA", "NRtg", "SRS", "eFG%", "2P%","DRtg","3PAr", "eFG%.1", "TS%", "3PA", "3P", "ORtg", "FG", "FG%", "TRB",  
                "AST", "STL", "TOV", "ORB", "DRB", "TRB", "BLK", "TOV", "PF", "Pace", "PTS")

# Separate the predictors and the response variable
x <- as.matrix(nba[, predictors])
y <- as.matrix(nba$W)



####### LASSO regression
## fit LASSO model with 10-fold CV
cv.lasso<-cv.glmnet(x,y, alpha=1,nlambda=100, nfold=10, standardize=T, type.measure="mse")
#pring the trace of lammbda, crossvalidation error, 
# and standard deviation of cross validation error 
trace.lasso <- cbind(cv.lasso$lambda, cv.lasso$cvm, cv.lasso$cvsd, cv.lasso$nzero)
colnames(trace.lasso) <- c("lambda", "cvm", "cvsd", "nzero" )
#pring out the most useful info. 
print(trace.lasso)
print(cv.lasso)

#plot the 10-fold CV error (MSE)
#lambda.min is the value of λ that gives minimum mean cross-validated error, 
#while lambda.1se is the value of λ that gives the most regularized model 
#such that the cross-validated error is within one standard error of the minimum.
plot(cv.lasso)
best.lambda.lasso<-cv.lasso$lambda.min
best.lambda.lasso
coef(cv.lasso, s=cv.lasso$lambda.min) #coefficients at the smallest MSE
coef(cv.lasso, s=cv.lasso$lambda.1se) #default is at the 1se.

#suppose you want to use the model to new data (assume new data are first 5 rows of X)
predict(cv.lasso, newx=x[1:5,], s=best.lambda.lasso)

## after lambda is determined, use glmnet to obtain coefficient path
#%Dev is the percentage of deviance explained by the model, with more regression coefficient, it will get larger
#Df is the number of predictors in the model. 

fit.lasso<-glmnet(x,y, alpha=1,nlambda=100, standardize=T)
plot(fit.lasso, label=T)
print(fit.lasso)
#obtain coefficient of final LASSO model
# 2 functions return the same result as lambda is chosen
coef(fit.lasso, s=cv.lasso$lambda.1se)
coef(cv.lasso, s=cv.lasso$lambda.1se)


####### Ridge regression
cv.ridge<-cv.glmnet(x,y, alpha=0,nlambda=100, nfold=10, standardize=T, type.measure="mse")
print(cv.ridge)

plot(cv.ridge)
best.lambda.ridge<-cv.ridge$lambda.1se
coef(cv.ridge, s=best.lambda.ridge)

#suppose you want to use the model to new data (assume new data are first 5 rows of X)
predict(cv.ridge, newx=x[1:5,], s=best.lambda.ridge)

## after lambda is determined, use glmnet to obtain coefficient path
fit.ridge<-glmnet(x,y, alpha=0,nlambda=100, standardize=T)
plot(fit.ridge, label=T)
print(fit.ridge)

#obtain coefficient of final Ridge model
# 2 functions return the same result as lambda is chosen
coef(fit.ridge, s=best.lambda.ridge)
coef(cv.ridge, s=best.lambda.ridge)





