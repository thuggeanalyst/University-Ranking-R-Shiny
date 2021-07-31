#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#




library(readr)
shanghaiData <- read_csv("~/Freelancer/RShinyApp/Universities World Ranking/shanghaiData.csv")
timesData <- read_csv("~/Freelancer/RShinyApp/Universities World Ranking/timesData.csv")
cwurData <- read_csv("~/Freelancer/RShinyApp/Universities World Ranking/cwurData.csv")
 timesData$world_rank<-as.numeric(timesData$world_rank)
timesData$total_score<-as.numeric(timesData$total_score)
# timesData<-na.omit(timesData)
timesData$year<-factor(timesData$year)
attach(timesData)


library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
shinyUI(
    dashboardPage(
        dashboardHeader(title = "UNIVERSITIES RANKING DASHBOARD",titleWidth = 400),
        
    
        dashboardSidebar(width = 250,
           
            sidebarMenu(
                menuItem("BAR CHART",tabName = "dashboard"),
                
                menuItem("BOX PLOTS",tabName = "boxplot"),
                
                menuItem("DENSITY PLOT",tabName = "sales"),
                
                menuItem("SCATTER PLOT", tabName = "scatterplot")
                
            
                
            )),
        
        
        
        dashboardBody(
            tabItems(
                tabItem(tabName = "dashboard",
                        fluidRow(
                                box(textOutput("textoutput"),width = 3,status = "primary",title = paste("POT EXPLANATION"), solidHeader = T
                                    ),
                                
                                 
                                box(plotOutput("Bar_Chart"),width = 6,
                                         solidHeader = T,status = "primary",title = paste("UNIVERSITIES WORLD RANKING FROM YEAR 2011 TO YEAR 2016")),
                                
                                box(title = "Plot Controls",width = 3,status = "primary", solidHeader = T,
                                    selectInput("university","Choose University",choices = timesData$university_name,selected = "Havard University"),
                                    selectInput("color", "Choose Color for Bars",multiple =F,  choices =c(Color1="blue",Color2="#C4961A",Color3="#00AFBB",
                                                                                                          Color4="#000000"))
                                    
                                    ))
                ),
                
                
                
                tabItem(tabName = "boxplot",
                                             fluidRow(
                                                 box(textOutput("textoutput1"),width = 3,status = "primary",title = paste("POT EXPLANATION"), solidHeader = T
                                                 ),
                                                   box(plotOutput("Box_plot"),width = 6,
                                                       solidHeader = T,status = "primary",title = "Box PLOT"),
                                                   box(title = "Plot Controls",width = 3, status = "primary", solidHeader = T,
                                                       selectInput("Color", "Choose Color for the boxes", choices = c(Color1="blue",Color2="#C4961A",Color3="#00AFBB",
                                                                                                                 Color4="#000000"))
                                                       )
                )
                
            ),
            tabItem(tabName = "sales",
                    fluidRow(
                        box(textOutput("textoutput2"),width = 3,status = "primary",title = paste("POT EXPLANATION"), solidHeader = T
                        ),
                        box(plotOutput("density_plot"),width = 6,
                            solidHeader = T,status = "primary",title = "DENSITY PLOT"),
                        box(title = "Plot Controls",width = 3, status = "primary", solidHeader = T,
                            selectInput("my_color", "Choose Color for curves", choices = c(Color1="blue",Color2="#C4961A",Color3="#00AFBB",
                                                                                      Color4="#000000","#999999", "#E69F00")),
                            selectInput("features","Features",choices = c("world_rank","teaching","research","citations",
                                                                          "income","total_score","num_students","student_staff_ratio",
                                                                          "international_students"))
                            )
                    )
                    
            ),
            tabItem(tabName = "scatterplot",
                    fluidRow(
                        box(textOutput("textoutput3"),width = 3,status = "primary",title = paste("POT EXPLANATION"), solidHeader = T
                        ),
                        box(plotOutput("scatter_plot"),width = 6,
                            solidHeader = T,status = "primary",title = "SCATTER PLOT"),
                        box(title = "Plot Controls",width = 3, status = "primary", solidHeader = T,
                            selectInput("Features","Features",choices = c("world_rank","teaching","research","citations",
                                                                          "income","total_score","num_students","student_staff_ratio",
                                                                          "international_students")),
                            selectInput("Features_color","Color Feature",choices = c("year","country"))))
                    )
                    
            )
            
        )
        
    )
)

