library("ggvis")

shinyUI(fluidPage(theme = "bootstrap.css",
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
      @import url('http://fonts.googleapis.com/css?family=Roboto+Condensed');
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
                min = 0, max = 200, value = c(50, 100)), uiOutput("plot_ui"),
    sliderInput("cals", 
                label = h5("What would you like your daily caloric intake to be?:"),
                min = 0, max = 4000, value = c(2000, 3200)),
    sliderInput("fat", 
                label = h5("What would you like your daily fat intake (in g) to be?:"),
                min = 0, max = 80, value = c(25, 35)),
    sliderInput("prot", 
                label = h5("What would you like your daily protein intake (in g) to be?:"),
                min = 0, max = 100, value = c(52, 100)),
    sliderInput("sugar", 
                label = h5("What would you like your daily sugar intake (in g) to be?:"),
                min = 0, max = 100, value = c(0, 37.5)),
    sliderInput("fiber", 
                label = h5("What would you like your daily fiber intake (in g) to be?:"),
                min = 0, max = 100, value = c(31, 100)),
    sliderInput("sodium", 
                label = h5("What would you like your daily sodium intake (in mg) to be?:"),
                min = 0, max = 4000, value = c(1500, 2300)),
    sliderInput("serv", 
                label = h5("What is the maximum # of servings of a single food you would
                be willing to eat per week?:"),
                min = 0, max = 50, value = 10)
  ),
    mainPanel(
      navbarPage("",
        tabPanel("Interactive Graph",
                 selectInput("select", label = "I am primarily trying to minimize:",
                    choices = list("Cost", "Calories", "Fat", "Sugar", "Sodium"),
                    selected = "Cost",),
                 br(),
                 div(style = "width:800px; height:600px;",
                     ggvisOutput("plot1")
                 )),
        
        tabPanel("Nutritional Recommendations",
                 fluidRow(
                   column(10,
                 h5("The default values to the left are the nutritional guidelines that the USDA and AHA recommend the average 14-18 year old male
                  consume. The graph is constrained by their further recommendations--that Americans
                  consume at least 16 oz fruit, 28 oz vegetables, 9 oz grain,
                  and 24 oz dairy per week. The chart in the 'Interactive Graph' tab allows you
                  to optimize your diet according to your budget. Hover over points for exact serving
                  sizes.", style = "color:black;"),
                 br(),
                 h5("The table below provides recommended nutritional values based on
                  age and sex. The calorie range's lower bound is for the most
                  sedentary individuals, while the upper bound is for the most
                  active individuals. It reflects the number of calories to consume
                  if one intends to remain at a constant weight.", style = "color:black;"),
                 br(),
                 dataTableOutput('nutrients'),
                 tags$head(tags$style("#nutrients table {background:lightpink; color:black;}", type="text/css"))
                 ))
        ),
        tabPanel("SNAP Information",
                 column(10,
                 h3("About SNAP",
                    style = "color:#66CCFF; font-family: 'Lobster', cursive; font-weight:500;"),
                 h5("The Supplemental Nutrition Assistance Program (SNAP) provides a contribution
                    towards food for in-need households. The average SNAP recipient receives $1.39
                    per meal. Nine out of ten Americans receiving SNAP benefits live with children,
                    elderly, or disabled persons, and forty percent live in households below half
                    the poverty line."),
                 h3("Do I Qualify?",
                    style = "color:#66CCFF; font-family: 'Lobster', cursive; font-weight:500;"),
                 h5("If you are unsure as to whether you qualify, click",
                    a("here.", href = "http://www.snap-step1.usda.gov/fns/"),
                  "If you qualify, you will have to fill out an application and submit it to your
                  local SNAP office. Applications can be found",
                    a("here.", href = "http://www.fns.usda.gov/snap/outreach/map.htm"),
                  "Call 1-800-221-5689 for more information."),
                 h3("Why participate?",
                    style = "color:#66CCFF; font-family: 'Lobster', cursive; font-weight:500;"),
                 h5("The Supplemental Nutrition Assistance Program (SNAP) provides a contribution
                  towards food for in-need households. It allows families with unemployed adults
                  to focus on finding work, rather than stressing about putting food on the table.
                  Participating in SNAP is correlated with a higher level of employment:"),
                 div(img(src = "employment.png"), style = "text-align: center;"),
                 h5("Additionally, SNAP almost completely covers the benefits for which all
                    eligible Americans qualify. As such, participation rates are high across
                    the nation. However, the elderly and working-poor are still underserved."),
                 div(img(src = "eligibility.png"), style = "text-align: center;"),
                 div(img(src = "participation.png"), style = "text-align: center;"),
                 h5("SNAP is an important stimulus during economic recessions, since SNAP
                    recipients are quick to redeem their benefits, thereby boosting local
                    economies. The number of SNAP retailers is at an all-time high--more
                    than a quarter million retailers across the nation as of 2013. SNAP
                    benefits can be redeemed at supermarkets/superstores, grocery stores,
                    and convenience stores, among other places. To learn more about the SNAP
                    program, visit the",
                      a("Center on Budget and Policy Priorities.",
                        href = "http://www.cbpp.org/research/food-assistance/chart-book-snap-helps-struggling-families-put-food-on-the-table#part7")
                 ),
                 br())
          )
      )
  )
))
