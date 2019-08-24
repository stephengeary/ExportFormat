library("dplyr")
library("reshape2")
library("readxl")
library("here")

df <- read_excel(here("Work","ExportFormat","ExampleExport.xlsx")
                 , skip = 2
                 )

df <- df %>%
filter(`Planned cost ($)` > .01) %>%
select(`Estimate name`,
     `Placement name`,
     `Month of service`,
     `Planned cost ($)`)

colnames(df)[colnames(df)=="Estimate name"] <- "Division"
colnames(df)[colnames(df)=="Placement name"] <- "Campaign"
colnames(df)[colnames(df)=="Month of service"] <- "Month"
colnames(df)[colnames(df)=="Planned cost ($)"] <- "PlannedSpend"

levels(df$Month)[levels(df$Month)=="2019/01"] <- "01/2019"
levels(df$Month)[levels(df$Month)=="2019/02"] <- "02/2019"
levels(df$Month)[levels(df$Month)=="2019/03"] <- "03/2019"
levels(df$Month)[levels(df$Month)=="2019/04"] <- "04/2019"
levels(df$Month)[levels(df$Month)=="2019/05"] <- "05/2019"
levels(df$Month)[levels(df$Month)=="2019/06"] <- "06/2019"
levels(df$Month)[levels(df$Month)=="2019/07"] <- "07/2019"
levels(df$Month)[levels(df$Month)=="2019/08"] <- "08/2019"
levels(df$Month)[levels(df$Month)=="2019/09"] <- "09/2019"
levels(df$Month)[levels(df$Month)=="2019/10"] <- "10/2019"
levels(df$Month)[levels(df$Month)=="2019/11"] <- "11/2019"
levels(df$Month)[levels(df$Month)=="2019/12"] <- "12/2019"

df2 <- dcast(df, Division + Campaign ~ Month, value.var = "PlannedSpend", fun.aggregate=mean)
df2[is.na(df2)] <- 0


now <- format(Sys.Date(),"%m%d%Y")
csvFileName <- paste(file.path(here()),"/","Export",now,".csv",sep = "")
write.csv(df2, file=csvFileName, row.names=FALSE)

