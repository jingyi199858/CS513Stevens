library(caret)
library(data.table)
library(tidyverse)
library(glmnet)
library(randomForest)
library(xgboost)

data = fread("~/Downloads/attrition_data.csv")
data = data %>% select(-c(EMP_ID, JOBCODE, TERMINATION_YEAR))
data[data==""] = "Unknown"

trainIndex = createDataPartition(data$STATUS, p = 0.8, list = FALSE)
train = data[trainIndex,]
test = data[-trainIndex,]

whole = model.matrix(STATUS~., data)[,-1]
# Dumy code categorical predictor variables
x = whole[trainIndex,]
# Convert the outcome (class) to a numerical variable
y = ifelse(train$STATUS == "T", 1, 0)

## logistic regression with LASSO
set.seed(123) 
cv.lasso = cv.glmnet(x, y, alpha = 1, family = "binomial")
# Fit the final model on the training data
model = glmnet(x, y, alpha = 1, family = "binomial",
                lambda = cv.lasso$lambda.min)
# Display regression coefficients
coef(model)
# Make predictions on the test data
x.test = whole[-trainIndex,]
probabilities = model %>% predict(newx = x.test)
predicted.classes = ifelse(probabilities > 0.5, "T", "A")
# Model test accuracy
observed.classes = test$STATUS
mean(predicted.classes == observed.classes)
# Model train accuracy
probabilities = model %>% predict(newx = x)
predicted.classes = ifelse(probabilities > 0.5, "T", "A")
observed.classes = train$STATUS
mean(predicted.classes == observed.classes)


## Random Forest
train.x = data.frame(x)
train.x['STATUS'] = y
model1 = randomForest(as.factor(STATUS) ~ ., data = train.x, ntree = 100, nodesize = 5, maxnodes = 10)
# Predicting on train set
predTrain <- predict(model1, train.x, type = "class")
# Checking classification accuracy
table(predTrain, train.x$STATUS)  
mean(predTrain == train.x$STATUS)  

test.x = data.frame(x.test)
test.x['STATUS'] = ifelse(test$STATUS == 'A', 0, 1)
predTest <- predict(model1, test.x, type = "class")
# Checking classification accuracy
table(predTest, test.x$STATUS)
mean(predTest == test.x$STATUS)

# xgboost
model2 = xgboost(data = x, label = y, nrounds = 2, objective = "binary:logistic")
# train accuracy
preds = predict(model2, x)
mean(round(preds) == y)
# test accuracy
preds = predict(model2, x.test)
mean(round(preds) == ifelse(test$STATUS == 'A', 0, 1))


