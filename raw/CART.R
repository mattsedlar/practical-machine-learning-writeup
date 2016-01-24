source("raw/exploratory.R")

set.seed(123)

tree <- rpart(classe ~., data=train, method="class")

png("plots/Original Model Fit.png", width=500, height=500, res=72)
plot(tree, uniform=T)
text(tree, use.n=T, all=T, cex=.8)
dev.off()



# OVERFIT NEED TO PRUNE

printcp(tree)

plotcp(tree)

ptree <- prune(tree,cp=tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"])

png("plots/Pruned Model Fit.png", width=500, height=500, res=72)
plot(ptree, uniform=T)
text(ptree, use.n=T, all=T, cex=.8)
dev.off()

pred <- predict(ptree, test[,-1], type="class")
acc_table <- table(test$classe, pred)

accuracy <- sum(diag(acc_table))/margin.table(acc_table)
