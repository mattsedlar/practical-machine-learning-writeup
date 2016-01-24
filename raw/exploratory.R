train.original <- read.csv("data/pml-training.csv", stringsAsFactors = F, na.strings=c("NA",""))
test.final <- read.csv("data/pml-testing.csv", stringsAsFactors = F, na.strings=c("NA",""))

require(dplyr)
require(caret)
require(rpart)
require(rattle)

train.original <- tbl_df(train.original)

trainIndex <- createDataPartition(train.original$classe, p=.6, list=F)

train <- train.original[trainIndex,]
test <- train.original[-trainIndex, ]

# MUST REPRODUCE ALL STEPS BELOW FOR TEST

train <- tbl_df(train)

train <- train %>% select(classe, matches("belt|arm|forearm|dumbbell"))

# REMOVING COLUMNS THAT HAVE MORE THAN 75% NAs

train <- train[,colSums(is.na(train)) < nrow(train) * .75]

train$classe <- as.factor(train$classe)

# LOOKING FOR NEAR ZERO VARIABLES
nsv <- nearZeroVar(train, saveMetrics = T)

# CLEAN UP TESTING

test <- tbl_df(test)

test <- test %>% select(classe, matches("belt|arm|forearm|dumbbell"))

# REMOVING COLUMNS THAT HAVE MORE THAN 75% NAs

test <- test[,colSums(is.na(test)) < nrow(test) * .75]

test$classe <- as.factor(test$classe)
