### �ֿ��� library 
# https://statkclee.github.io/data-science/data-science-library.html




### �Ǻ��м�

# ## ������ �ҷ����� �� Ȯ��
library(magrittr)
iris %>% head()

str(iris)

## ����ġ Ȯ��
colSums(is.na(iris))


# ## train-test split
# install.packages("caTools")

library(caTools)

# install.packages("tidyverse")
library(tidyverse)

set.seed(123)
sam <- sample.split(iris$Species, SplitRatio = 0.7)
sam %>% head(15)


### error 

train <- subset(iris, split == T)
test <- subset(iris, split == F)
test.y <- test[,5]

# ## lda modeling
library(MASS)
iris_lda <- lda(Species~., data = train, prior = c(1/3,1/3,1/3))
iris_lda

## ������� lda �Լ��� ������ predict
testpred <- predict(iris_lda, test)
testpred

## misclass error Ȯ��
misclass.error <- mean(test.y != testpred$class)
misclass.error

## cross-table
library(gmodels)
CrossTable(x=test.y, y=testpred$class, prop.chisq = F)

## Discriminant modeling: QDA (Quadratic DA)

## �л�-���л� ����� �������� üũ

library(biotools)
boxM(iris[1:4], iris$Species)  

## �л�-���л� ����� ������ ���, LDA
## �л�-���л� ����� �������� ���� ���, QDA -> �� ��� p < .05 �̹Ƿ� �� ���̽���

## qda modeling
iris.qda <- qda(Species ~ ., data=train, prior = c(1/3,1/3,1/3))
iris.qda

## ������� qda �Լ��� ������ predict 
testpredq <- predict(iris.qda, test) 
testpredq

## misclass error Ȯ��
misclass.error2 <- mean(test.y != testpredq$class)
misclass.error2

## cross-table
library(gmodels)
CrossTable(x=test.y, y=testpredq$class, prop.chisq = F)


