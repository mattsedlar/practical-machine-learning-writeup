source('raw/exploratory.R')

library(randomForest)

set.seed(1234)
trees <- randomForest(classe ~., data=train)
importance(trees)

pred <- predict(trees,test[,-1])
acc_table <- table(test$classe,pred)

accuracy <- sum(diag(acc_table))/margin.table(acc_table)

plot(trees, log="y")
varImpPlot(trees)


