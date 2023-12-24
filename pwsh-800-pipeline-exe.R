
# Windows Powershell, EventId 800 

# library(tidyverse)

setwd(".")

df <- readr::read_csv("pwsh-800-pipeline-exe.csv", col_types = list(
  .default = readr::col_character()
))

# Split message column ----------------------------------------------------

df$Message <- gsub("Pipeline execution details for command line: ","", df$Message)
l <- stringr::str_split(df$Message, "Context Information: ")
df <- df[,-5]

df2 <- data.frame(matrix(unlist(l), nrow = length(l), byrow = T))

# Split remaining column --------------------------------------------------

l2 <- stringr::str_split(df2$X2, "Details: ")
df2 <- data.frame(df2$X1)

names(df2) <- "PipeExeDetail"

df3 <- data.frame(matrix(unlist(l2), nrow = length(l2), byrow = T))
names(df3) <- c("ContextInfo","Details")

# Combine 3 dataframes ----------------------------------------------------

df <- dplyr::bind_cols(df, df2, df3)

rm(df2, df3, l, l2)

# Summarize Pipe Execution column -----------------------------------------

df2 <- dplyr::select(df, PipeExeDetail)
df2 <- dplyr::group_by(df2, PipeExeDetail)
df2 <- dplyr::summarise(df2, cnt=dplyr::n())
df2 <- dplyr::arrange(df2, desc(cnt))

# Summarize ContextInfo ---------------------------------------------------

df3 <- dplyr::select(df, ContextInfo)
df3 <- dplyr::group_by(df3, ContextInfo)
df3 <- dplyr::summarise(df3, cnt=dplyr::n()) 
df3 <- dplyr::arrange(df3, desc(cnt))

# Summarize Details -------------------------------------------------------

df4 <- dplyr::select(df, Details)
df4 <- dplyr::group_by(df4, Details) 
df4 <- dplyr::summarise(df4, cnt=dplyr::n())
df4 <- dplyr::arrange(df4, desc(cnt))

# Rearrange columns -------------------------------------------------------

df5 <- dplyr::bind_cols(df4$cnt, df4$Details)
names(df5) <- c("cnt", "cmd")
df5 <- dplyr::arrange(df5, desc(cnt))

# Print Out-GridView entries ----------------------------------------------

# View with pwsh: ipcsv .\ogv.csv | ogv

# Get column widths
colwds <- nchar(df5$cmd)
hitL <- (colwds > 220)

# Filter by column widths
df5_fl <- df5[hitL,]
df5_ogv <- df5[!hitL,]

write.csv(df5_ogv, "ogv.csv", row.names = F)

# Print out Format List entries -------------------------------------------

# View with text editor or less: fl.txt

myfile <- file('fl.txt', 'w')

i <- 1 
while (i < dim(df5_fl)[1]) {
  writeLines(as.character(df5_fl[i, 1]), myfile)
  writeLines(as.character(df5_fl[i, 2]), myfile)
  
  writeLines("\n***\n", myfile)
  
  i <- i + 1
}

close(myfile)
rm(myfile)

rm(colwds, hitL, i)
rm(df5, df5_fl, df5_ogv)

# Output message ----------------------------------------------------------

range(df$TimeGenerated)
print("Files 'ogv.csv' and 'fl.txt' generated")
head(df4)
