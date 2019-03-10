### �ֿ��� library 
# https://statkclee.github.io/data-science/data-science-library.html


### �Ǻ��м�

# 1. dataset ����

set.seed(123)

aa_length <- sample(seq(15,22.5,by=0.5), 50, replace=T)
aa_weight <- sample(seq(0.2,0.8,by=0.05), 50, replace=T)
bb_length <- sample(seq(46,61,by=0.5), 50, replace=T)
bb_weight <- sample(seq(1.36,3.2,by=0.5), 50, replace=T)
cc_length <- sample(seq(30,75.5,by=1), 50, replace=T)
cc_weight <- sample(seq(0.2,3.5,by=0.1), 50, replace=T)
dd_length <- sample(seq(25,38,by=0.5), 50, replace=T)
dd_weight <- sample(seq(0.4,0.54,by=0.01), 50, replace=T)
ee_length <- sample(seq(22,55,by=0.5), 50, replace=T)
ee_weight <- sample(seq(0.68,1.8,by=0.01), 50, replace=T)

length <- c(aa_length, bb_length, cc_length, dd_length, ee_length)
weight <- c(aa_weight, bb_weight, cc_weight, dd_weight, ee_weight)
speed <- rnorm(50*5, 7.2, sd=1.8)
fish <- c(rep("aa",50), rep("bb", 50), rep("cc", 50), rep("dd", 50), rep("ee", 50))
fish_data <- data.frame(length, weight, speed, fish)

## 2. lda 

library(MASS)
str(fish_data)

fish_lda <- lda(fish ~., data=fish_data, prior=c(1,1,1,1,1)/5)
fish.lda

# 

fish.lda$counts


# ���ο� �����ͼ� �з� ��� �� Ŭ������ ����Ȯ��: predict() �Լ�

# fish_data�� 100������ ������ �����Ǻ������ �н�(train)


set.seed(123)
train100 <- sample(1:nrow(fish_data),100)
table(fish_data$fish[train100])



fish100_lda <- lda(fish ~., data=fish_data, prior=c(1,1,1,1,1)/5, subset=train100)


## predict() �Լ��� ����� ǥ���� ���Ե� 100������ ���� �з� ����� ���� ������ ����.

predict_fish100 <- predict(fish100_lda)
table(fish_data$fish[train100], predict_fish100$class)


# ggplot() �Լ��� ������ �ð�ȭ����.
library(ggplot2)

p <- ggplot(as.data.frame(predict_fish100$x), aes(x=LD1, y=LD2, col-fish_data$fish[train100]))
p <- p + geom_point() + geom_text(aes(label=as.character(predict_fish100$class)))
# Adjust legend size
p <- p + theme(legend.title=element_blank(), legend.text=element_text(size=20, face="bold"))
# Adjust axis labels
p <- p + theme(axis.title=element_text(face="bold", size=20), axis.text=element_text(size=18))
# Display plot
p


## �з����(class), ����Ȯ��(posterior), ���з���(misclassficaiotn rate)�� ����غ���.
predict_new <- predict(fish100_lda, newdata=fish_data[-train100,])
table(fish_data$fish[-train100], predict_new$class)


## 

tab <- table(fish_data$fish[-train100], predict_new$class)
tab

## error rate 

tab_sum <- 1-sum(diag(tab))/sum(tab)
tab_sum

sum(diag(tab))
sum(tab)




