library(shiny)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("cerulean"),
  titlePanel("Cardiovascular Diseases"),
  
  tabsetPanel(
    tabPanel("Introduction", fluid = TRUE,
             mainPanel(
               HTML(
                 paste(
                   br(),
                   p(("Cardiovascular diseases (CVDs also known as heart diseases) remain as the biggest cause for mortality rate throughout the world for past decades. The world Health Organization (WHO) estimated 17.9 million people died from CVDs in 2016 which representing 31% of all global deaths. 85% of these deaths are due to heart attack and stroke. Most of people are unsure the risk factor that trigger the Cardiovascular diseases. Thus, the objective of this application creation is to provide doctors a platform to use existing dataset to predict the presence cardiovascular diseases based on selected risk factor for advance verification and precaution. Let's go through a bit of the background of cardiovascular diseases before starting cardiovascular diseases prediction.")),
                   br(),
                   p("Heart attacks and strokes are usually acute events and are mainly caused by a blockage that prevents blood from flowing to the heart or brain. According to WHO article in 2017, the most common reason for this acute event to happen is because of the build-up of fatty deposits on the inner walls of the blood vessels that supply the heart or brain. Strokes can also be caused by bleeding from a blood vessel in the brain or from blood clots."),
                   br(),
                   tags$img(src='http://lookgoodfeelgreatalways.com/wp-content/uploads/2012/04/Blog-post-10Apr12-Hear-AttacK-There-is-no-warning.png'),
                   h2("Risk factors for cardiovascular disease"),
                   h4("Behavioural risk factors:"),
                   p("-	unhealthy diet"),
                   p("-	physical inactivity"),
                   p("-	tobacco use "),
                   p("-	harmful use of alcohol "),
                   br(),
                   h4("The effects:"),
                   p("- raised blood  pressure"),
                   p("- raised blood glucose"),
                   p("-	raised blood lipid"),
                   p("- overweight and obesit"),
                   br(),
                   p("These", "intermediate risks factors", "indicate an increased risk of developing a heart attack, stroke, heart failure and other complications."),
                   p("Other determinants of CVDs include poverty, stress and hereditary factors."),
                   h2("Common symptoms of cardiovascular diseases"),
                   h5("Often, there are no symptoms of the underlying disease of the blood vessels. A heart attack or stroke may be the first warning of underlying disease. Symptoms of a heart attack include:"),
                   p(em(".	pain or discomfort in the centre of the chest")),
                   p(em(".	pain or discomfort in the arms, the left shoulder, elbows, jaw, or back")),
                   p("In addition the person may experience difficulty in breathing or shortness of breath; feeling sick or vomiting; feeling light-headed or faint; breaking into a cold sweat; and becoming pale. Women are more likely to have shortness of breath, nausea, vomiting, and back or jaw pain."),
                   br(),
                   h5("The most common symptom of a stroke is sudden weakness of the face, arm, or leg, most often on one side of the body. Other symptoms include sudden onset of:"),
                   p(em(".	numbness of the face, arm, or leg, especially on one side of the body;")),
                   p(em(".	confusion, difficulty speaking or understanding speech")),
                   p(em(".	difficulty seeing with one or both eyes")),
                   p(em(".	difficulty walking, dizziness, loss of balance or coordination")),
                   p(em(".	severe headache with no known cause")),
                   p(em(".	fainting or unconsciousness")),
                   br(),
                   p(strong(("People experiencing these symptoms should seek medical care immediately.")),
                   br(),
                   h6("Reference sources:"),
                   a("https://www.who.int/news-room/fact-sheets/detail/cardiovascular-diseases-(cvds)")
                 )
               )
             )
             )
    ),
    tabPanel("Result", fluid = TRUE,
             sidebarLayout(
               sidebarPanel(h2("Please select your input"),
                            numericInput("age", "Age in years",
                                         62, min = 1, max = 100),
                            
                            radioButtons("sex", "Sex",
                                         c("Male"= 0,
                                           "Female"= 1)),
                            
                            sliderInput("oldpeak", "ST depression induced by exercise relative to rest",
                                        min = 0, max = 7.0, value = 3.6, step = 0.1),
                            
                            radioButtons("fbs", "Fasting blood sugar (>120 mg/dl)",
                                         c("Yes"=1,
                                           "No"=0)),
                            
                            radioButtons("exang", "Exercise induced angina",
                                         c("Yes"=1,
                                           "No"=0)),
                            
                            selectInput("restecg", "Resting electrocardiographic results",
                                        c("Normal" = 0,
                                          "Having ST-T wave abnormality" = 1,
                                          "Showing probable or definite left ventricular hypertrophy by Estes' criteria" = 2)),
                            
                            selectInput("slope", "Slope of the peak exercise ST segment",
                                        c("Upsloping" = 1,
                                          "Flat" = 2,
                                          "Downsloping" = 3)),
                            
                            selectInput("ca", "Number of major vessels (0-3) colored by flourosopy",
                                        c("0" = 0,
                                          "1" = 1,
                                          "2" = 2,
                                          "3" = 3)),
                            
                            selectInput("thal", "Thal",
                                        c("Normal" = 3,
                                          "Fixed defect" = 6,
                                          "Reversable defect" = 7))
                            ),
               mainPanel(
                 h2("Patient Info"),
                 tableOutput("values"),
                 uiOutput("result")
               )
               )
    ),
    # tabPanel("Visualisation", fluid = TRUE,
    #          mainPanel = " "
    # ),
    
    tabPanel("Documentation", fluid = TRUE,
             mainPanel(
               HTML(
                 paste(
                   h4("The objective of this application creation is to provide doctors a platform to use existing dataset to predict the presence cardiovascular diseases based on selected risk factor for advance verification and precaution. To implement machine learning in our application, we are using Cleveland heart disease dataset which obtained from UCI machine learning repository. There are 9 significant attributes are considered in our prediction model.")
                   )
               ),
               tags$img(src="http://imagizer.imageshack.us/a/img923/159/z4ilhu.png")
             )
    )
  )
)