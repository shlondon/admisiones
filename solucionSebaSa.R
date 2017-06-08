#Leer datos
train <- read.csv("train-set.csv", header = FALSE)
test <- read.csv("test-set.csv", header = FALSE)

#Librerias
library(e1071)
library(ggplot2)

#Gráficos
ggplot(train, aes(x=V1, y =V2, 
                  col = as.factor(V3))) +
        geom_point(alpha=0.3, lwd=50)


#Super vector machine
set.seed(3)
resultado <- tune(svm, as.factor(V3) ~., data = train,
                  kernel = "radial",
                  ranges = list(cost= c(0.1 ,1 ,10 ,100 ,1000),
                                gamma = c(0.5,1,2,3,4)))

#Training precition
p <- predict(resultado$best.model, train)
mean(p==as.factor(train$V3))*100

#Test precition
pt <- predict(resultado$best.model, test)
mean(pt==as.factor(test$V3))*100

