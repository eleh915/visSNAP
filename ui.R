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
    numericInput("num", label = h4("Enter your household monthly SNAP allotment (in $) to receive
                 a recommended weekly expenditure on groceries:"), value = 125),
    h4(textOutput("textRecom")),
    sliderInput("Price", 
                label = "",
                min = 0, max = 200, value = c(78, 100)), uiOutput("plot_ui"),
    sliderInput("Cals", 
                label = h4("What would you like your daily caloric intake to be?:"),
                min = 0, max = 4000, value = c(2000, 3200)),
    sliderInput("SatFat", 
                label = h4("What would you like your daily saturated fat intake (in g) to be?:"),
                min = 0, max = 80, value = c(5, 15)),
    sliderInput("Prot", 
                label = h4("What would you like your daily protein intake (in g) to be?:"),
                min = 0, max = 200, value = c(52, 100)),
    sliderInput("Sugar", 
                label = h4("What would you like your daily sugar intake (in g) to be?:"),
                min = 0, max = 100, value = c(0, 37.5)),
    sliderInput("Fiber", 
                label = h4("What would you like your daily fiber intake (in g) to be?:"),
                min = 0, max = 100, value = c(31, 100)),
    sliderInput("Sodium", 
                label = h4("What would you like your daily sodium intake (in mg) to be?:"),
                min = 0, max = 4000, value = c(1500, 2300)),
    sliderInput("serv", 
                label = h4("What is the maximum # of servings of a single food you would
                be willing to eat per week?:"),
                min = 0, max = 6, value = 6)
  ),
    mainPanel(
      navbarPage("",
        tabPanel("Interactive Graph",
                 selectInput("select", label = h4("I am primarily trying to minimize:"),
                    choices = list("Cost", "Calories", "Saturated Fat", "Sugar", "Sodium"),
                    selected = "Cost",),
                 h4("Hover over points to find out how many servings of each ingredients you should use to
                    prepare dishes each week. Toggle the bars on the left to adjust to your dietary needs.",
                    style = "color:#006699;"),
                 div(ggvisOutput("plot1")
                 )),
        tabPanel("Nutritional Recommendations",
                 fluidRow(
                   column(10,
                 h4("The default values to the left are the nutritional guidelines that the USDA and AHA recommend the average 14-18 year old male
                  consume. The graph is further constrained by MyPlate.gov's recommendations--that Americans
                  consume at least 14 cups fruit, 17.5 cups vegetables, 42 oz grains, 38.5 oz protein foods,
                  and 21 cups dairy per week. The chart in the 'Interactive Graph' tab allows you
                  to optimize your diet according to your budget. All foods and prices are based
                  off of the",
                    a("USDA National Nutrient Database",
                      href = "http://ndb.nal.usda.gov/ndb/foods"),
                    "and",
                    a("CNPP Prices Database",
                      href = "http://www.cnpp.usda.gov/data"),
                    "(adjusted for inflation).",
                    style = "color:black;"),
                 h4("The table below provides recommended nutritional values based on
                  age and sex. The calorie range's lower bound is for the most
                  sedentary individuals, while the upper bound is for the most
                  active individuals. It reflects the number of calories to consume
                  if one plans to remain at a constant weight.", style = "color:black;"),
                 h4("To figure out what recipes you can make with your weekly combination
                    of foods, head on over to",
                    a("SuperCook.", href = "http://www.supercook.com/#/recipes/All%2520recipes"),
                    style = "color:black;"),
                 br(),
                 dataTableOutput('nutrients'),
                 tags$head(tags$style("#nutrients table {background:lightpink; color:black;}", type="text/css"))
                 ))
        ),
        tabPanel("Food Database",
                 fluidRow(
                   column(10,
                   h4("The database below is drawn from the USDA's National Nutrient Database, and provides an easy way to look up a given food. All data--including price--are based on one serving of the food."),
                 dataTableOutput('usdaTable'),
                 tags$head(tags$style("#usdaTable table {background:lightblue; color:black;}", type="text/css"))
                 ))
        ),
        tabPanel("SNAP Information",
                 column(10,
                 h3("About SNAP",
                    style = "color:#66CCFF; font-family: 'Lobster', cursive; font-weight:500;"),
                 h4("The Supplemental Nutrition Assistance Program (SNAP) provides a contribution
                    towards food for in-need households. The average SNAP recipient receives $1.39
                    per meal. Nine out of ten Americans receiving SNAP benefits live with children,
                    elderly, or disabled persons, and 40% live in households below half
                    the poverty line."),
                 h3("Do I Qualify?",
                    style = "color:#66CCFF; font-family: 'Lobster', cursive; font-weight:500;"),
                 h4("If you are unsure as to whether you qualify, click",
                    a("here.", href = "http://www.snap-step1.usda.gov/fns/"),
                  "If you qualify, you will have to fill out an application and submit it to your
                  local SNAP office. Applications can be found",
                    a("here.", href = "http://www.fns.usda.gov/snap/outreach/map.htm"),
                  "Call 1-800-221-5689 for more information."),
                 h3("Why participate?",
                    style = "color:#66CCFF; font-family: 'Lobster', cursive; font-weight:500;"),
                 h4("SNAP allows families with unemployed adults
                  to focus on finding work, rather than stressing about putting food on the table.
                  Participating in SNAP is correlated with a higher level of employment:"),
                 div(img(src = "employment.png"), style = "text-align: center;"),
                 h4("Additionally, SNAP almost completely covers the benefits for which all
                    eligible Americans qualify. For this reason, participation rates are high across
                    the nation. However, the elderly and working-poor are still underserved."),
                 div(img(src = "eligibility.png"), style = "text-align: center;"),
                 div(img(src = "participation.png"), style = "text-align: center;"),
                 h4("SNAP is an important stimulus during economic recessions, since SNAP
                    recipients are quick to redeem their benefits, thereby boosting local
                    economies. The number of SNAP retailers is at an all-time high--there are more
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
