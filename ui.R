library("ggvis")

shinyUI(fluidPage(
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }
    "))
  ),
  
  titlePanel(title = h1("Visualizing SNAP", align = "center", style = "color:darkgreen")),
  sidebarPanel(  
    sliderInput("budget", 
                label = "What is your weekly grocery budget?:",
                min = 0, max = 100, value = c(35, 70)), uiOutput("plot_ui"),
    sliderInput("cals", 
                label = "What would you like your daily caloric intake to be?:",
                min = 0, max = 4000, value = c(1800, 2550)),
    sliderInput("fat", 
                label = "What would you like your daily fat intake (in g) to be?:",
                min = 0, max = 80, value = c(20, 35)),
    sliderInput("prot", 
                label = "What would you like your daily protein intake (in g) to be?:",
                min = 0, max = 100, value = c(54, 70)),
    sliderInput("sugar", 
                label = "What would you like your daily sugar intake (in g) to be?:",
                min = 0, max = 100, value = c(0, 37.5)),
    sliderInput("fiber", 
                label = "What would you like your daily fiber intake (in g) to be?:",
                min = 0, max = 100, value = c(25, 38)),
    sliderInput("sodium", 
                label = "What would you like your daily sodium intake (in mg) to be?:",
                min = 0, max = 4000, value = c(0, 2300)),
    sliderInput("serv", 
                label = "What is the maximum # of servings of a single food you would
                be willing to eat per week?:",
                min = 0, max = 50, value = 10)
  ),
    mainPanel(
      selectInput("select", label = "What are you primarily trying to minimize?", 
                  choices = list("Cost", "Calories", "Fat", "Sugar", "Sodium"), selected = "Cost"),
      br(),
      div(style = "width:800px; height:600px;",
      ggvisOutput("plot1")
      ),
      br(),
      helpText("The default values to the left are the nutritional guidelines
        that USDA and AHA recommend the average 31-50 year old male
        consume. The graph is constrained by their further recommendations:
        that Americans consume at least 16 oz fruit, 28 oz vegetables, 9 oz grain,
        and 24 oz dairy per week. The following chart allows you to optimize your
        diet according to your budget. SNAP benefits are designed to cover about
        one third of your total food expenditure."),
      br(),
      helpText(h6("(c) Erica Leh, 2015."))
  )
))