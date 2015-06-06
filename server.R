library(ggvis)
library(lpSolve)
library(lpSolveAPI)
library(shiny)
library(dplyr)

SNAP <- read.csv("./data/SNAP.csv")
nutrients <- read.csv("./data/nutrientByDemoT.csv")

  function(input, output, session) {
    
  # feed in user input to create model
  x <- reactive({
    
  # set up optimization eq maximizing protein given constraints
  maxProt <- lp("min",
                switch(input$select, 
                       "Cost" = SNAP$costPerServ,
                       "Calories" = SNAP$calsPerServ,
                       "Fat" = SNAP$fatPerServ,
                       "Sugar" = SNAP$sugarPerServ,
                       "Sodium" = SNAP$sodiumPerServ),
                rbind(SNAP$protPerServ, SNAP$protPerServ, SNAP$fatPerServ, SNAP$fatPerServ, SNAP$costPerServ, SNAP$costPerServ,
                      SNAP$sodiumPerServ, SNAP$sodiumPerServ, SNAP$fiberPerServ, SNAP$fiberPerServ,
                      SNAP$sugarPerServ, SNAP$sugarPerServ, SNAP$calsPerServ, SNAP$calsPerServ,
                      SNAP$fruit, SNAP$vegs, SNAP$grains, SNAP$grains, SNAP$meatProtein, SNAP$dairy,
                      SNAP$X1, SNAP$X2, SNAP$X3, SNAP$X4, SNAP$X5, SNAP$X6, SNAP$X7, SNAP$V8, SNAP$V9,
                      SNAP$X10, SNAP$X11, SNAP$X12, SNAP$X13, SNAP$X14, SNAP$X15, SNAP$X16, SNAP$X17, SNAP$X18, SNAP$X19,
                      SNAP$X20, SNAP$X21, SNAP$X22, SNAP$X23, SNAP$X24, SNAP$X25, SNAP$X26, SNAP$X27, SNAP$X28, SNAP$X29,
                      SNAP$X30, SNAP$X31, SNAP$X32, SNAP$X33, SNAP$X34, SNAP$X35, SNAP$X36, SNAP$X37, SNAP$X38, SNAP$X39,
                      SNAP$X40, SNAP$X41, SNAP$X42, SNAP$X43, SNAP$X44, SNAP$X45, SNAP$X46, SNAP$X47, SNAP$X48, SNAP$X49,
                      SNAP$X50, SNAP$X51, SNAP$X52, SNAP$X53, SNAP$X54, SNAP$X55, SNAP$X56, SNAP$X57, SNAP$X58, SNAP$X59,
                      SNAP$X60, SNAP$X61, SNAP$X62, SNAP$X63, SNAP$X64, SNAP$X65, SNAP$X66, SNAP$X67, SNAP$X68, SNAP$X69,
                      SNAP$X70, SNAP$X71, SNAP$X72, SNAP$X73, SNAP$X74, SNAP$X75, SNAP$X76, SNAP$X77, SNAP$X78, SNAP$X79,
                      SNAP$X80, SNAP$X81, SNAP$X82, SNAP$X83, SNAP$X84, SNAP$X85, SNAP$X86, SNAP$X87, SNAP$X88, SNAP$X89,
                      SNAP$X90, SNAP$X91, SNAP$X92, SNAP$X93, SNAP$X94, SNAP$X95, SNAP$X96, SNAP$X97, SNAP$X98, SNAP$X99,
                      SNAP$X100, SNAP$X101, SNAP$X102, SNAP$X103, SNAP$X104, SNAP$X105, SNAP$X106, SNAP$X107, SNAP$X108, SNAP$X109,
                      SNAP$X110, SNAP$X111, SNAP$X112, SNAP$X113, SNAP$X114, SNAP$X115, SNAP$X116, SNAP$X117, SNAP$X118, SNAP$X119,
                      SNAP$X120, SNAP$X121, SNAP$X122, SNAP$X123, SNAP$X124, SNAP$X125, SNAP$X126, SNAP$X127, SNAP$X128, SNAP$X129,
                      SNAP$X130, SNAP$X131, SNAP$X132, SNAP$X133, SNAP$X134, SNAP$X135),
                c(">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", "<=", ">=", ">=", ">=", "<=", ">=", ">=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=",
                  "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<=", "<="),
                c(input$prot[1]*7, input$prot[2]*7, input$fat[1]*7, input$fat[2]*7, input$budget[1], input$budget[2],
                  input$sodium[1]*7, input$sodium[2]*7, input$fiber[1]*7, input$fiber[2]*7,
                  input$sugar[1]*7, input$sugar[2]*7, input$cals[1]*7, input$cals[2]*7, 16, 28, 9, 25, 6.4, 24,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv, input$serv,
                  input$serv, input$serv, input$serv, input$serv, input$serv))
    
  # drop any variables that have a 0 coefficient in the model
  x <- data.frame(SNAP$food, SNAP$foodGroup, SNAP$protPerServ, maxProt$solution, SNAP$ozPerServ)
  x <- droplevels(x[!(x$maxProt.solution < 1),])
  })
  
  output$textRecom <- renderText({ 
    paste("We recommend spending about $", signif(input$num[1]*(1/3), 2), "per week on food.
          Enter the range below that you believe reflects this budget:")
  })
  
  # data chart for nutritional recs based on age/sex
  output$nutrients = renderDataTable({
    nutrients
  })
  
  # graph of recommended servings of food based on optim (lp) eq
  x %>%
    ggvis(~SNAP.food, ~maxProt.solution, fill = ~SNAP.foodGroup, stroke = ~SNAP.ozPerServ, strokeWidth := "2") %>%
    layer_points(size := "400", opacity := "0.8") %>%
    add_tooltip(function(x){paste0("Food: ", x$SNAP.food, "<br>", "Servings: ",
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
    add_axis("x", orient = "top", ticks = 0, title = "What Foods Should I Buy?",
             properties = axis_props(
               axis = list(stroke = "white"),
               title = list(fontSize = 16),
               labels = list(fontSize = 0))) %>%
    add_axis("y", title = "Servings Per Week") %>%
    add_relative_scales() %>%
    add_legend("fill", title = "Food Groups") %>%
    add_legend("stroke", title = "Oz. Per Serving", properties = legend_props(legend = list(y = 120))) %>%
    set_options(width = "auto", height = "auto", resizable=FALSE, duration = 0) %>%
    bind_shiny("plot1", "plot_ui")
}