# Predicting_NBA_Wins


## Introduction
This project aims to predict the likelihood of a National Basketball Association (NBA) team winning a game based on various metrics. We will use statistical techniques such as Principal Component Analysis (PCA) and Regularized Regression, specifically Lasso and Ridge regression, to develop predictive models. The goal is to identify the most important features that contribute to a team's success and create models that accurately predict team performance and have good generalization performance.

## Data Preparation
The data for this project was collected from BasketballReference.com, a website that provides statistics for the NBA. We used web scraping to collect "Per Game Stats" and "Advanced Stats" tables for ten seasons from 2013-2023. The dataset contains a total of 47 variables, including traditional statistics such as Wins, Losses, and Points Per Game, as well as advanced metrics such as Offensive Rating (ORtg), Defensive Rating (DRtg), and True Shooting Percentage (TS%). Other variables included age, Pace, and Free Throw Rate (FTr). We pre-processed the dataset by removing irrelevant columns, resulting in a final set of variables used for further analysis.

## Statistical Models
We used PCA to identify the combination of features that best explain the variation in team performance across different seasons. This technique helps to reduce the dimensionality of large datasets and identify the most important variables. By applying PCA to the NBA team performance data, we were able to determine the factors that contribute most to player/team effectiveness and make informed decisions in player selection and game strategies.

We also explored Regularized Regression, specifically Lasso and Ridge regression, to help with variable selection and prevent overfitting. Regularizations add a penalty term to the loss function, which helps to reduce the complexity of the model by shrinking the coefficients of less important features towards zero, ultimately improving model generalization.
