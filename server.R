#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

clean_data<-read.csv("clean.csv")
clean_data$risk <- as.factor(clean_data$risk)

library(caret)
trainIndex=createDataPartition(clean_data$risk, p=0.9)$Resample1
train=clean_data[trainIndex, ]
test=clean_data[-trainIndex, ]

library(e1071)


# create response and feature data
features <- setdiff(names(train), "risk")
x <- train[, features]
y <- train$risk

# set up 10-fold cross validation procedure
train_control <- trainControl(
  method = "cv", 
  number = 10
)

# train model SVM
svm <- svm(clean_data$risk~.,data=clean_data)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  inputValues <- reactive({
    age <- as.numeric(input$age)
    sex <- as.numeric(input$sex)
    oldpeak <- as.numeric(input$oldpeak)
    fbs <- as.numeric(input$fbs)
    exang <- as.numeric(input$exang)
    restecg <- as.numeric(input$restecg)
    slope <- as.numeric(input$slope)
    ca <- as.numeric(input$ca)
    thal <- as.numeric(input$thal)
    
    data.frame(age, sex, oldpeak, fbs, exang, restecg, slope, ca, thal, stringsAsFactors = FALSE)
  })
  
  # vals <- reactiveValues()
  # observe({
  #   vals$a <- as.numeric(input$age)
  #   vals$b <- as.numeric(input$sex)
  #   vals$c <- as.numeric(input$oldpeak)
  #   vals$d <- as.numeric(input$fbs)
  #   vals$e <- as.numeric(input$exang)
  #   vals$f <- as.numeric(input$restecg)
  #   vals$g <- as.numeric(input$slope)
  #   vals$h <- as.numeric(input$ca)
  #   vals$i <- as.numeric(input$thal)
  #   })
  
  output$values <- renderTable({
    inputValues()
  })
  

  pred_result_1 <- reactive({
    predict(svm, inputValues())
  })
 
    
  output$result <- renderUI(
    if (pred_result_1()==0){
      h4(strong(paste("You are being categorized as NO risk.")))
    }
    else if (pred_result_1()==1){
      h4(strong(paste("You are being categorized as LOW risk.")))
    }
    else
      h4(strong(paste("You are being categorized as HIGH risk.")))
  )
})