library(ggvis)
library(lpSolve)
library(lpSolveAPI)
library(shiny)
library(dplyr)
SNAP2 <- read.csv("./data/SNAP2.csv")

  function(input, output, session) {
      
  x <- reactive({
    
  # set up optimization eq maximizing protein given constraints
  maxProt <- lp("min",
                switch(input$select, 
                       "Cost" = SNAP2$costPerServ,
                       "Calories" = SNAP2$calsPerServ,
                       "Fat" = SNAP2$fatPerServ,
                       "Sugar" = SNAP2$sugarPerServ,
                       "Sodium" = SNAP2$sodiumPerServ),
                rbind(SNAP2$protPerServ, SNAP2$protPerServ, SNAP2$fatPerServ, SNAP2$fatPerServ, SNAP2$costPerServ, SNAP2$costPerServ,
                      SNAP2$sodiumPerServ, SNAP2$sodiumPerServ, SNAP2$fiberPerServ, SNAP2$fiberPerServ,
                      SNAP2$sugarPerServ, SNAP2$sugarPerServ, SNAP2$calsPerServ, SNAP2$calsPerServ,
                      SNAP2$fruit, SNAP2$vegs, SNAP2$grains, SNAP2$grains, SNAP2$meatProtein, SNAP2$dairy, SNAP2$V1, SNAP2$V2, SNAP2$V3, SNAP2$V4, SNAP2$V5, SNAP2$V6, SNAP2$V7, SNAP2$V8, SNAP2$V9, SNAP2$V10, SNAP2$V11, SNAP2$V12, SNAP2$V13, SNAP2$V14, SNAP2$V15, SNAP2$V16, SNAP2$V17, SNAP2$V18, SNAP2$V19, SNAP2$V20, SNAP2$V21, SNAP2$V22, SNAP2$V23, SNAP2$V24, SNAP2$V25, SNAP2$V26, SNAP2$V27, SNAP2$V28, SNAP2$V29, SNAP2$V30, SNAP2$V31, SNAP2$V32, SNAP2$V33, SNAP2$V34, SNAP2$V35, SNAP2$V36, SNAP2$V37, SNAP2$V38, SNAP2$V39, SNAP2$V40, SNAP2$V41, SNAP2$V42, SNAP2$V43, SNAP2$V44, SNAP2$V45, SNAP2$V46, SNAP2$V47, SNAP2$V48, SNAP2$V49, SNAP2$V50, SNAP2$V51, SNAP2$V52, SNAP2$V53, SNAP2$V54, SNAP2$V55, SNAP2$V56, SNAP2$V57, SNAP2$V58, SNAP2$V59, SNAP2$V60, SNAP2$V61, SNAP2$V62, SNAP2$V63, SNAP2$V64, SNAP2$V65, SNAP2$V66, SNAP2$V67, SNAP2$V68, SNAP2$V69, SNAP2$V70, SNAP2$V71),
                c(">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", ">=", ">=", "<=", ">=", ">=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<="),
                c(input$prot[1]*7, input$prot[2]*7, input$fat[1]*7, input$fat[2]*7, input$budget[1], input$budget[2],
                  input$sodium[1]*7, input$sodium[2]*7, input$fiber[1]*7, input$fiber[2]*7,
                  input$sugar[1]*7, input$sugar[2]*7, input$cals[1]*7, input$cals[2]*7, 16, 28, 9, 25, 6.4, 24, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv))
    
  # drop any variables that have a 0 coefficient in the model
  x <- data.frame(SNAP2$food, SNAP2$foodGroup, SNAP2$protPerServ, maxProt$solution)
  x <- droplevels(x[!(x$maxProt.solution == 0),])
  })
  
  output$textRecom <- renderText({ 
    paste("We recommend spending about $", signif(input$num[1]*(1/4), 2), "per week on food.
          Enter the range below that you believe reflects this budget:")
  })
  output$textBudget <- renderText({ 
    paste("You have chosen a weekly budget that ranges from $",
          input$budget[1], "to $", input$budget[2], ".")
  })
    
  x %>%
    ggvis(~SNAP2.food, ~maxProt.solution, fill = ~SNAP2.foodGroup) %>%
    layer_points(size := "400", opacity := "0.8") %>%
    add_tooltip(function(x){paste0("Food: ", x$SNAP2.food, "<br>", "Servings: ",
        signif(x$maxProt.solution, 2), "<br>")}, "hover") %>%
    add_axis("x", title = "", ticks = 14,
             properties = axis_props(
               majorTicks = list(strokeWidth = 2),
               labels = list(
                 angle = 50,
                 fontSize = 10,
                 align = "left",
                 baseline = "middle",
                 dx = 3
               ),
               axis = list(stroke = "#333", strokeWidth = 1.5)
             )
    ) %>%
    add_axis("x", orient = "top", ticks = 0, title = "Recommended Servings of
             Food Given Nutritional Constraints",
             properties = axis_props(
               axis = list(stroke = "white"),
               title = list(fontSize = 16),
               labels = list(fontSize = 0))) %>%
    add_axis("y", title = "Servings Per Week") %>%
    add_legend("fill", title = "Food Groups") %>%
    set_options(width = "auto", height = "auto", resizable=FALSE) %>%
    bind_shiny("plot1", "plot_ui")
}