library(tidyverse)
library(dplyr)
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
read_table(dataurl)
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")
temp=read_table(dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))

# Graph the annual mean temperature in June, July and August (JJA) using ggplot
ggplot(temp, aes(YEAR, JJA)) + geom_line() + 
  
  #Add a smooth line with geom_smooth()
  geom_smooth(method = "loess", formula = "y ~ x", color="red") +
  
  # Add informative axis labels using xlab() and ylab() including units
  xlab("Year") + ylab("Mean Summer Temperatures (C)") + 
  
  # Add a graph title with ggtitle()
  ggtitle("Mean Summer Temperatures in Buffalo, NY") +
  labs(subtitle = ("Summer includes June, July, and August Data from the Global Historical Climate Network
  Red line is LOESS smooth")) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))