## 7. discriminant : lda, qda 

colSums(is.na(iris))

## ������ �ҷ����� �� Ȯ��
iris %>% head()
str(iris)

## ����ġ Ȯ��
colSums(is.na(iris))


## train-test split

library(caTools)

set.seed(1710)
split <- sample.split(iris$Species, SplitRatio = 0.7)
split %>% head(15)

train <- subset(iris, split == T)
test <- subset(iris, split == F)
test_y <- test[,5]



## lda modeling
library(MASS)

iris_lda <- lda(Species~., data = train, prior = c(1/3,1/3,1/3))
iris_lda

## ������� lda �Լ��� ������ predict
testpred <- predict(iris_lda, test)
testpred

## misclass error Ȯ��
misclass_error <- mean(test_y != testpred$class)
misclass_error

## cross-table
library(gmodels)
CrossTable(x=test.y, y=testpred$class, prop.chisq = F)


## �л�-���л� ����� �������� üũ
library(biotools)
boxM(iris[1:4], iris$Species)  

## �л�-���л� ����� ������ ���, LDA
## �л�-���л� ����� �������� ���� ���, QDA -> �� ��� p < .05 �̹Ƿ� �� ���̽���

## qda modeling
iris_qda <- qda(Species ~ ., data=train, prior = c(1/3,1/3,1/3))
iris_qda


## ������� qda �Լ��� ������ predict 
testpredq <- predict(iris_qda, test) 
testpredq

## misclass error Ȯ��
misclass_error2 <- mean(test_y != testpredq$class)
misclass_error2

## cross-table
library(gmodels)
CrossTable(x=test_y, y=testpredq$class, prop.chisq = F)
