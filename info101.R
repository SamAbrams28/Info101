library(ggplot2)
library(marinecs100b)
remotes::install_github('MarineCS-100B/marinecs100b')

# Questionable organization choices ---------------------------------------

# P1 Call the function dir() at the console. This lists the files in your
# project's directory. Do you see woa.csv in the list? (If you don't, move it to
# the right place before proceeding.)
dir()

# P2 Critique the organization of woa.csv according to the characteristics of
# tidy data.
# 2 rows of headers
# Not a rectangle - column names are the depth variable
# header names that are confusing for the computer


# Importing data ----------------------------------------------------------

# P3 P3 Call read.csv() on woa.csv. What error message do you get? What do you
# think that means?
read.csv('woa.csv')
# more columns than column names

# P4 Re-write the call to read.csv() to avoid the error in P3.
data_frame1 <- read.csv('woa.csv', skip = 1)
?read.csv
View
# Skp = 1 instead of header = false because the csv DOES have a header row, it's
# just the second row instead of the first

# Fix the column names ----------------------------------------------------

# P5 Fill in the blanks below to create a vector of the depth values.

depths <- c(
  seq(0, 100, by = 5),
  seq(125, 500, by = 25),
  seq(550, 2000, by = 50),
  seq(2100, 5500, by = 100)
)
?seq

# P6 Create a vector called woa_colnames with clean names for all 104 columns.
# Make them the column names of your WOA data frame.
woa_colnames <- c("Latitude", "Longitude", depths)
data_frame2 <- read.csv('woa.csv', header = FALSE, col.names = woa_colnames)

# Analyzing wide-format data ----------------------------------------------

# P7 What is the mean water temperature globally in the twilight zone (200-1000m
# depth)?

# Make a new data table with just the twilight zone data.

# The indexing wouldn't work if both functions were in the brackets. One was
# fine...but using both didn't get me the right columns. The extra variable
# assignment is a work-around.
first_column <- which(depths == 200)+2
last_column <- which(depths == 1000)+2
woa_twilight <- data_frame2[ , first_column:last_column]
clean_twilight <- woa_twilight[-2, ]
# Headers are showing up as the 2nd row, I can't figure out how to fix it in the
# woa_twilight assignment.

# Grab the sum of the data points and the number of data points
temp_sum <- sum(clean_twilight, na.rm = TRUE) # Add up all of the twilight temps
na_sum <- sum(!is.na(clean_twilight)) # number of data points

# Find the average
wide_mean <- temp_sum/na_sum



# Analyzing long-format data ----------------------------------------------
View(woa_long)
write.csv(woa_long, "woa_long.csv", row.names = FALSE)
# This is a back-up line - I wrote the data I needed into a file on my computer
# because the marincs library has been kinda funky.

# P8 Using woa_long, find the mean water temperature globally in the twilight zone.
long_temp_mean <- mean(woa_long[woa_long$depth_m >= 200 & woa_long$depth_m <= 1000, 4], na.rm = TRUE)


# P9 Compare and contrast your solutions to P8 and P9.
# P8 is one step. P7 is...several. Plus is has a couple weird, inexpiable bugs.

# P10 Create a variable called mariana_temps. Filter woa_long to the rows in the
# location nearest to the coordinates listed in the in-class instructions.

# Check the unique values of the lat and long to figure out what pt is closest to 11°21′N, 142°12′E
unique(woa_long[,1]) # 11.5
unique(woa_long[woa_long$longitude >= 135, 2]) # 142.5
# Longitudes aren't perfectly in order the way latitudes are, this makes it easier to see

mariana_temps <- woa_long[woa_long$latitude == 11.5 & woa_long$longitude == 142.5, 3:4]
# Needs to have depths too because ggplot only takes a data frame.

# P11 Interpret your temperature-depth profile. What's the temperature at the
# surface? How about in the deepest parts? Over what depth range does
# temperature change the most?
# Surface temp: 28.651°C. Deepest (5500) temp: 1.532°C.
# Most change: first few 100 meters


# ggplot is a tool for making figures, you'll learn its details in COMM101
ggplot(mariana_temps, aes(temp_c, depth_m)) +
  geom_path() +
  scale_y_reverse()
