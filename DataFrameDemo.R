# how to create data frames manually
noaa_survey <- data.frame(latitude = c(45, 45, 30,30),
                          depth_m = c(5, 100, 5, 100),
                          temp_c = c(10.6, 7.1, 21.8, 18.3))

# print directly to console
noaa_survey

# View() use Rstudio's viewer
View(noaa_survey)

# Import using a .csv
write.csv(noaa_survey, "noaa_survey.csv", row.names = FALSE)

# check the conents of your directory
dir()

# read a data frame from a csv file
noaa_survey2 <- read.csv("noaa_survey.csv")
noaa_survey2

# How to see and modify column names
colnames(noaa_survey2)
colnames(noaa_survey2) <- c("Latitude","DepthM","TempC")
noaa_survey2
