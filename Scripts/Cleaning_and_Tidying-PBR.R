# Libraries ---------------------------------------------------------------

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

# Import Data from White House GitHub site --------------------------------

# import budget authorization using Hadley's readr package
budauth <- tbl_df(read_csv("https://raw.githubusercontent.com/WhiteHouse/2016-budget-data/master/data/budauth.csv"))
outlays <- tbl_df(read_csv("https://raw.githubusercontent.com/WhiteHouse/2016-budget-data/master/data/outlays.csv"))
receipts <- tbl_df(read_csv("https://raw.githubusercontent.com/WhiteHouse/2016-budget-data/master/data/receipts.csv"))

# All names should be made R friendly
colnames(budauth) <- make.names(colnames(budauth))
colnames(outlays) <- make.names(colnames(outlays))
colnames(receipts) <- make.names(colnames(receipts))


# Tidy Data ---------------------------------------------------------------
# Still looking for the best way to tidy. Here's my method:
# Step 1: Save colname subset
# Step 2: Concatenate columns
# Step 3: Gather
# Step 4: De-Concatenate, renaming deconctatenated columns using saved names

# Step 1: Save names of columns that will disappear after concatenating
budauth_names <- colnames(budauth)[1:11]
outlays_names <- colnames(outlays)[1:12]
receipts_names <- colnames(receipts)[1:12]

# Step 2: Concatenate to the left of the value columns (FY)
budauth <- unite(budauth, concat_budauth, 1:11, sep = "COLUMN_SEPARATOR")
outlays <- unite(outlays, concat_outlays, 1:12, sep = "COLUMN_SEPARATOR")
receipts <- unite(receipts, concat_receipts, 1:12, sep = "COLUMN_SEPARATOR")

# Step 3: Gather
budauth <- gather(budauth, FY, amount, -concat_budauth)
outlays <- gather(outlays, FY, amount, -concat_outlays)
receipts <- gather(receipts, FY, amount, -concat_receipts)

# Step 4: Deconcateanate
budauth <- separate(budauth, concat_budauth, into = budauth_names, sep = "COLUMN_SEPARATOR")
outlays <- separate(outlays, concat_outlays, into = outlays_names, sep = "COLUMN_SEPARATOR")
receipts <- separate(receipts, concat_receipts, into = receipts_names, sep = "COLUMN_SEPARATOR")


# Final Cleaning Tasks -------------------------------------------------------------

# FY column is a factor; turn it into a string
budauth$FY <-  as.character(budauth$FY)
outlays$FY <-  as.character(outlays$FY)
receipts$FY <-  as.character(receipts$FY)

# FY data has an extra "X
budauth$FY <- str_replace(budauth$FY, "X", "")
outlays$FY <- str_replace(outlays$FY, "X", "")
receipts$FY <- str_replace(receipts$FY, "X", "")


## Congratulations! Let's take a look.
# take a look
glimpse(budauth)
glimpse(outlays)
glimpse(receipts)


# Export ------------------------------------------------------------------
# write_csv(budauth, "./Data/PBR.FY16_budauth.csv")
# write_csv(outlays, "./Data/PBR.FY16.outlays.csv")
# write_csv(receipts, "./Data/PBR.FY16.receipts.csv")


