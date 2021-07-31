#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(scales)
library(viridis)
library(readr)
library(dplyr)
library(dplyrExtras)
library(ggplot2)
library(shinydashboard)
library(gapminder)
library(hrbrthemes)
library(ggplot2)
library(gifski)
library(gganimate)









shinyServer(function(input, output) {
    
    
    output$Bar_Chart<-renderPlot({
        
        timesDataUniversity <- dplyr::filter(timesData, university_name == input$university)
         shanghaiDataUniversity <- dplyr::filter(shanghaiData, university_name == input$university)
        cwurDataUniversity <- dplyr::filter(cwurData, institution == input$university)
        ggplot(timesDataUniversity, aes(x=year, y=world_rank)) + 
            geom_bar(stat = "identity",fill=input$color)+
            ylab("Wordl Ranking")+
            xlab("Year")+
            ggtitle(paste("University of ", input$university, "World Ranking"))+
            theme(plot.title = element_text(hjust = 0.5))+
            theme(legend.position="none")
        
    })
    
    output$textoutput <- renderText({
        paste("The bar chart displays the universities world
              rankign by respective years. The change in ranking of 
              the respective universities can also be identified by 
              following the ranking by years")
    })
    output$textoutput1 <- renderText({
        paste("Box and whiskers plot wwere constructed to display the 
        distribution of world rank across the yeras. The year 2016 world rank
        if diffrent from the years since its mean is way less as comapred to
              the other yeras. Therefore the world ranking for year 2016
              does not agree with the rest of the years")
    })
    output$textoutput2 <- renderText({
        paste("To access if university world ranking agree across the years, a density plot of the 
              world ranking was plotted across the yeras. The plot display a similar shape for the 
              yeras except for the year 2016 that is a bit diffrent from the other as depicted by its
              density distribution.")
    })
    output$textoutput3 <- renderText({
        paste("A scatter plot investigates the relatiosnhip between two continous variables
        if their relationshi is liner, the data points are plotted along a straight line.
        if otherwise, other patterns are depicted on the plot. For instance, the relatiosnhip 
              between world ranking and research can be described a roughly staright line, while
              world ranking a total scores can be describes by a polynominal function.")
    })

    

    
    
    
    output$Box_plot<-renderPlot({
       
        timesDataUniversity <- dplyr::filter(timesData, university_name == input$university)
        
        ggplot(timesData, 
               aes(x = year, 
                   y =as.numeric(world_rank),
                   color = factor(year))) +
            geom_boxplot(size=1,
                         outlier.shape = 1,
                         outlier.color = "black",
                         col=input$Color,
                         outlier.size  = 3) +
            geom_jitter(alpha = 0.5,width=.2) +
            
            labs(title = "Box plot of universities world rank by years",
                 y = "World Rank",
                 x = "Year") +
            theme_minimal() +
            theme(legend.position = "none") +
            theme(plot.title = element_text(hjust = 0.5))+
            coord_flip()
           
    })
    
    output$density_plot<-renderPlot({
    
        ggplot(timesData, 
               aes(x =timesData[[input$features]], 
                   fill = year)) +
            xlab("Year")+
            geom_density(alpha = 0.4,colour=input$my_color) +
            labs(title =paste("Density plot of ", input$features))
        
        
    })
    output$scatter_plot<-renderPlot({
        ggplot(timesData, aes(x=world_rank,y=timesData[[input$Features]],
                         color=timesData[[input$Features_color]])) +
            ylab(input$features)+
            geom_point()+
            labs(color=input$Features_color) +
            ggtitle(paste("A scatter plot of world rank and ",input$features))+
            theme(plot.title = element_text(hjust = 0.5))+
            geom_point()
            
        
    })
    
   
    
})
