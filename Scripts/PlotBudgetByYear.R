# First Step -------------------------------------------------------------
# Run the Cleaning_and_Tidying-PBR.R file to get a clean dataframe called budauth

PlotBudgetByYear <- function(dataframe = budauth, bureau) {
  # Plot a bureau's budget (y-axis) by year (x-axis)
  #
  # Args:
  #    dataframe: dataframe with budauth as default
  #    bureau: string
  #
  # Returns:
  #   Scatter plot.
  #
  # Prep the data for plotting -------------------------------------------------------------
  #df <- data[data$Bureau.Name == bureau]
  df <- filter(dataframe, Bureau.Name == bureau)
  df_budget_by_year <- summarise(group_by(df, FY), FY.Budget=sum(amount))
  
  # Plot -------------------------------------------------------------
  plot(x = df_budget_by_year$FY,
       y = df_budget_by_year$FY.Budget,
       xlab = 'Fiscal Year',
       ylab = 'Annual Budget Total',
       main = paste('How the', bureau, 'budget changed Y/Y'))
}

# Examples
#   PlotBudgetByYear(dataframe = budauth, bureau = 'Department of the Interior')
#   PlotBudgetByYear(bureau = 'Senate')