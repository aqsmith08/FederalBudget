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


# Plot -------------------------------------------------------------
library(ggplot2)
library(scales)
library(ggthemes)

# ggplot is a nightmare compared to R base!
qplot(FY, FY.Budget, data = interior_budget_by_year)  +
  ylab("Annual Budget Total") + xlab("Fiscal Year") + 
  scale_y_continuous(labels = unit_format(unit = "M", scale = 1e-6, digits = 2)) +
  ggtitle("How the Department of Interior Budget has Changed Y/Y") 

# R base
plot(x = interior_budget_by_year$FY,
     y = interior_budget_by_year$FY.Budget,
     xlab = 'Fiscal Year', ylab = 'Annual Budget Total',
     main = 'How the Department of Interior budget has changed Y/Y')
