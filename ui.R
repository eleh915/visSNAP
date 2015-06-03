library("ggvis")


shinyUI(fluidPage(theme = "bootstrap.css",
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
    "))
  ),
  
  titlePanel(title = h1("Visualizing SNAP", align = "center", style = "color:mediumseagreen;
                        font-size: 100; font-family: 'Lobster', cursive; font-weight:500;
                        line-height: 1.1;")),
  sidebarPanel(
    numericInput("num", label = h5("Enter your household monthly SNAP allotment (in $) to receive
                 a recommended weekly expenditure on groceries:"), value = 250),
    h5(textOutput("textRecom")),
    sliderInput("budget", 
                label = "",
                min = 0, max = 200, value = c(50, 70)), uiOutput("plot_ui"),
    sliderInput("cals", 
                label = h5("What would you like your daily caloric intake to be?:"),
                min = 0, max = 4000, value = c(1800, 2550)),
    sliderInput("fat", 
                label = h5("What would you like your daily fat intake (in g) to be?:"),
                min = 0, max = 80, value = c(20, 35)),
    sliderInput("prot", 
                label = h5("What would you like your daily protein intake (in g) to be?:"),
                min = 0, max = 100, value = c(54, 70)),
    sliderInput("sugar", 
                label = h5("What would you like your daily sugar intake (in g) to be?:"),
                min = 0, max = 100, value = c(0, 37.5)),
    sliderInput("fiber", 
                label = h5("What would you like your daily fiber intake (in g) to be?:"),
                min = 0, max = 100, value = c(25, 38)),
    sliderInput("sodium", 
                label = h5("What would you like your daily sodium intake (in mg) to be?:"),
                min = 0, max = 4000, value = c(0, 2300)),
    sliderInput("serv", 
                label = h5("What is the maximum # of servings of a single food you would
                be willing to eat per week?:"),
                min = 0, max = 50, value = 10)
  ),
    mainPanel(
      navbarPage("",
        tabPanel("Interactive Graph",
                 selectInput("select", label = "I am primarily trying to minimize:", 
                                     choices = list("Cost", "Calories", "Fat", "Sugar", "Sodium"), selected = "Cost",),
                 br(),
                 div(style = "width:800px; height:600px;",
                     ggvisOutput("plot1")
                 )),
        
        tabPanel("SNAP Information",
                 fluidRow(
                   column(10,
                 helpText("The default values to the left are the nutritional guidelines
        that the USDA and AHA recommend the average 31-50 year old male
        consume. The graph is constrained by their further recommendations--that Americans
        consume at least 16 oz fruit, 28 oz vegetables, 9 oz grain,
        and 24 oz dairy per week. The chart allows you to optimize your
        diet according to your budget.")))
        )
      )
  )
))