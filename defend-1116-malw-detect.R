
# Windows Powershell, EventId 800 

options(warn = -1)

setwd(".")

df <- readr::read_csv("defend-1116-malw-detect.csv", col_types = list(
  .default = readr::col_character()
))

# Summarize ProcessName ---------------------------------------------------

df2 <-dplyr::select(df, ProcessName)
df2 <-dplyr::group_by(df2, ProcessName)
df2 <-dplyr::summarise(df2, cnt=dplyr::n())
df2 <-dplyr::arrange(df2, desc(cnt))

# Summarize ThreatName, ProcessName ---------------------------------------

df3 <- dplyr::select(df, ThreatName, ProcessName) 
df3 <- dplyr::group_by(df3, ThreatName, ProcessName)
df3 <- dplyr::summarise(df3, cnt=dplyr::n()) 
df3 <- dplyr::arrange(df3, desc(cnt))

# Output message ----------------------------------------------------------

range(df$TimeGenerated)

head(df2)
head(df3)
