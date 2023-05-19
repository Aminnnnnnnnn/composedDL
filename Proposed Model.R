rm(list = ls())
#install.packages('devtools', repos='http://cran.rstudio.com/')
library(devtools)
#pkgbuild::check_build_tools(debug = TRUE)
#devtools::install_github("bnosac/image", subdir = "image.darknet", build_vignettes = TRUE)
library(tensorflow)
#BiocManager::install("EBImage")
#install.packages("tensorflow")
# Load Pakages
library(EBImage)
library(keras)
#Read Images
a<-Sys.time()
setwd('D:/Animal classification/Animal classification/Animal classification')
pics <- c('A1.jpg','A2.jpg','A3.jpg','A4.jpg','A5.jpg','A6.jpg','A7.jpg','A8.jpg','A9.jpg','A10.jpg','A11.jpg','A12.jpg','A13.jpg','A14.jpg','A15.jpg','A16.jpg','A17.jpg','A18.jpg','A19.jpg',

'A20.jpg','A21.jpg','A22.jpg','A23.jpg','A24.jpg','A25.jpg','A26.jpg','A27.jpg','A28.jpg','A29.jpg','A30.jpg','A31.jpg','A32.jpg','A33.jpg','A34.jpg','A35.jpg','A36.jpg','A37.jpg','A38.jpg','A39.jpg','A40.jpg',

'A41.jpg','A42.jpg','A43.jpg','A44.jpg','A45.jpg','A46.jpg','A47.jpg','A48.jpg','A49.jpg','A50.jpg','A51.jpg','A52.jpg','A53.jpg','A54.jpg','A55.jpg','A56.jpg','A57.jpg','A58.jpg','A59.jpg','A60.jpg','A61.jpg',

'A62.jpg','A63.jpg','A64.jpg','A65.jpg','A66.jpg','A67.jpg','A68.jpg','A69.jpg','A70.jpg','A71.jpg','A72.jpg','A73.jpg','A74.jpg','A75.jpg','A76.jpg','A77.jpg','A78.jpg','A79.jpg','A80.jpg','A81.jpg','A82.jpg',

'A83.jpg','A84.jpg','A85.jpg','A86.jpg','A87.jpg','A88.jpg','A89.jpg','A90.jpg','A91.jpg','A92.jpg','A93.jpg','A94.jpg','A95.jpg','A96.jpg','A97.jpg','A98.jpg','A99.jpg','A100.jpg',

'H1.jpg','H2.jpg','H3.jpg','H4.jpg','H5.jpg','H6.jpg','H7.jpg','H8.jpg','H9.jpg','H10.jpg','H11.jpg','H12.jpg','H13.jpg','H14.jpg','H15.jpg','H16.jpg','H17.jpg','H18.jpg','H19.jpg','H20.jpg','H21.jpg','H22.jpg',

'H23.jpg','H24.jpg','H25.jpg','H26.jpg','H27.jpg','H28.jpg','H29.jpg','H30.jpg','H31.jpg','H32.jpg','H33.jpg','H34.jpg','H35.jpg','H36.jpg','H37.jpg','H38.jpg','H39.jpg','H40.jpg', 

'H41.jpg','H42.jpg','H43.jpg','H44.jpg','H44.jpg','H45.jpg','H46.jpg','H47.jpg','H48.jpg','H49.jpg','H50.jpg','H51.jpg','H52.jpg',

'H53.jpg','H54.jpg','H55.jpg','H56.jpg','H57.jpg','H58.jpg','H59.jpg','H60.jpg','H61.jpg','H62.jpg','H63.jpg','H64.jpg','H65.jpg','H66.jpg','H67.jpg','H68.jpg','H69.jpg','H70.jpg','H71.jpg','H72.jpg','H73.jpg',

'H74.jpg','H75.jpg','H76.jpg','H76.jpg','H77.jpg','H78.jpg','H79.jpg','H80.jpg','H81.jpg','H82.jpg','H83.jpg','H84.jpg','H85.jpg','H86.jpg','H87.jpg','H88.jpg','H89.jpg','H90.jpg','H91.jpg','H92.jpg','H93.jpg',

'H94.jpg','H95.jpg','H96.jpg','H97.jpg','H98.jpg','H99.jpg','H100.jpg')

mypic <- list()
for (i in 1:200) {mypic[[i]] <- readImage(pics[i])}
#Explore
#print(mypic[[1]])
#display(mypic[[1]])
#str(mypic)
#Risize Images
for(i in 1:200){mypic[[i]]<-resize(mypic[[i]],28,28)}
#print(mypic[[1]])
#str(mypic)
#Reshape
for (i in 1:200){mypic[[i]]<-array_reshape(mypic[[i]],c(28,28,3))}    
#str(mypic)
#length(mypic)
# row bind
trainx<-NULL
for (i in 1:80){trainx<-rbind(trainx,mypic[[i]])}
for (i in 101:180){trainx<-rbind(trainx,mypic[[i]])}
testx<-NULL
for (i in 81:100){testx<-rbind(testx,mypic[[i]])}
for (i in 181:200){testx<-rbind(testx,mypic[[i]])}
#str(testx)
trainy<-rep(c(0,1),each=80)
testy<-rep(c(0,1),each=20)
# one Hot Encoding
trainLabels<-to_categorical(trainy)
testLabels<-to_categorical(testy)
# Model
a<-Sys.time()
model<-keras_model_sequential()
model%>%
  layer_dense(units=256,activation='relu',input_shape = c(2352))%>%
  layer_dense(units=128,activation='relu')%>%
  layer_dense(units=2,activation = 'softmax')
#summary(model)
#complile
model%>%
  compile(loss='binary_crossentropy',
          optimizer=optimizer_rmsprop(),
          metrics=c('accuracy'))
# Fit model
histrory<-model%>%
  fit(trainx,trainLabels,epoch=64,batch_size=32)
#plot(histrory)
#Evaluation & Prediction-train data
model%>%evaluate (trainx,trainLabels)
pred<-model%>% predi ct(trainx) %>% k_argmax()
pred<-np_array(pred)
pred <- reticulate::py_to_r(pred)
trainx21<-NULL
trainx11<-NULL
for (i in 1:160){
  if (pred[i]==1){
      
      trainx21<-rbind(trainx21,mypic[[i]])
      
  }else{
    
    trainx11<-rbind(trainx11,mypic[[i]])
    
  }
}
pred1<-model1%>% predict(trainx21)%>% k_argmax()
pred2<-model2%>% predict(trainx11)%>% k_argmax()
Sys.time()-a
pred<-np_array(pred)
pred <- reticulate::py_to_r(pred) 
table(predicted=pred,Actual=trainy)
