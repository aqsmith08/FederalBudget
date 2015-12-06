# First Step -------------------------------------------------------------
# Run the Cleaning_and_Tidying-PBR.R file to get a clean dataframe called budauth

# Find an interesting bureau -------------------------------------------------------------
bureau_name_freq <- as.data.frame(table(budauth$Bureau.Name))
head(arrange(bureau_name_freq, -Freq), n = 10)

# Prep the data for plotting -------------------------------------------------------------
interior <- filter(budauth, Bureau.Name == 'Department of the Interior')
interior_budget_by_year <- summarise(group_by(interior, FY), FY.Budget=sum(amount))

# Plot -------------------------------------------------------------
plot(x = interior_budget_by_year$FY,
     y = interior_budget_by_year$FY.Budget,
     xlab = 'Fiscal Year', ylab = 'Annual Budget Total',
     main = 'How the Department of Interior budget has changed Y/Y')
