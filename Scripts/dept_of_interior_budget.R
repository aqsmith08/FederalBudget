# First Step -------------------------------------------------------------
# Run the Cleaning_and_Tidying-PBR.R file to get a clean dataframe called budauth

# Find an interesting bureau -------------------------------------------------------------

# dplyr method
budauth %>%
  group_by(Bureau.Name) %>%
  tally(sort=TRUE)
  
# Alternate: R base method
# bureau_name_freq <- as.data.frame(table(budauth$Bureau.Name))
# head(arrange(bureau_name_freq, -Freq), n = 10)


# Prep the data for plotting -------------------------------------------------------------
# Create Department of Interior Subset
interior <- filter(budauth, Bureau.Name == 'Department of the Interior')

# Summarise budget authorization by year
interior_budget_by_year <- summarise(group_by(interior, FY), FY.Budget=sum(amount))
View(interior_budget_by_year)

# Plot -------------------------------------------------------------
library(ggplot2)
library(scales)
library(ggthemes)


# ggplot is a nightmare compared to R base!
# Or maybe I'm just using it nightmarishly?

theme_set(theme_gray(base_size = 20))
ggplot(interior_budget_by_year, aes(FY, FY.Budget)) + 
  geom_bar(stat = "identity", color="red")+
  ylab("Annual Budget Total") + 
  xlab("Fiscal Year") + 
  scale_x_discrete(breaks = c("1976", "1980", "1984", "1988", "1992", "1996", "2000", "2004", "2008", "2012", "2016", "2020"))+
  scale_y_continuous(labels = unit_format(unit = "M", scale = 1e-6, digits = 2)) +
  theme(axis.ticks.y = element_blank(), axis.ticks.y = element_blank()) +
  ggtitle("How the Department of Interior Budget has Changed Y/Y") 

qplot(FY, FY.Budget, data = interior_budget_by_year, geom = "point") +
  scale_x_discrete(breaks = c("1976", "1980", "1984", "1988", "1992", "1996", "2000", "2004", "2008", "2012", "2016", "2020"))


# R base
plot(x = interior_budget_by_year$FY,
     y = interior_budget_by_year$FY.Budget,
     xlab = 'Fiscal Year', ylab = 'Annual Budget Total',
     main = 'How the Department of Interior budget has changed Y/Y')
