setwd("~/Desktop/cheatR/data/")

#0.LIBRARIES
library(tidyverse)

#1.DATA IMPORT

#tabular data

read_csv("titanic.csv")  #Comma Delimited Files  
read_csv2("file2.csv") #Semi-colon Delimited Files 
read_delim("file.txt", delim = "|") #Files with Any Delimiter
read_tsv("file.tsv") #Tab Delimited Files

#useful arguments
read_csv(f, col_names = FALSE) #No header
read_csv(f, col_names = c("x", "y", "z")) #Provide header
read_csv(f, skip = 1) #Skip lines

#2.DATA TYPES

#example
col_character()
col_double() 
col_euro_double() 
col_datetime(format = "") 
col_date(format = "") 
col_time(format = "")
col_factor(levels, ordered = FALSE)
col_integer()
col_logical()
col_number() 
col_numeric()
col_skip()

x <- read_csv("titanic.csv", col_types = cols( Survived = col_character(),
                                                Pclass = col_character(),
                                                Sex = col_character(),
                                                Age = col_character()
                                                ))


#tibble
a = tibble(x = 1:3, y = c("a", "b", "c"))
a = tribble( ~x, ~y,
              1, "a",
              2, "b",
              3, "c")
as_tibble(x) #convert dataframe to tibble


#3.SAVE DATA
write_csv(x, path, na = "NA", append = FALSE, col_names = !append) #Comma delimited file
write_delim(x, path, delim = " ", na = "NA", append = FALSE, col_names = !append)#File with arbitrary delimiter


#4.RESHAPE DATA

#gather() moves column names into a key column, gathering the column values into a single value column.
mydata <- read_csv('gather.csv')
a<-gather(mydata, 2:13, key = "mes", value = "cases")




