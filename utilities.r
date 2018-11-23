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

#gather() from wide to long
mydata <- read_csv('gather.csv')
a<-gather(mydata, 2:13, key = "mes", value = "cases")

#spread() from long to wide
mydata <- read_csv('spread.csv')
a<-spread(mydata,key=variable,casos)
print(a)

#separate() split cell by delimiter
mydata <- read_csv('separate.csv')
a<-separate(mydata, region, into = c("country", "continent"))
print(a)

#separate_rows() split cell by delimiter and create new row
mydata <- read_csv('separate_rows.csv')
a<-separate_rows(mydata, metrica, sep = "/", convert = FALSE)

#unite() Collapse cells across several columns make a single column
mydata<-read_csv('unite.csv')
a<-unite(mydata, year, month, col = "year_month", sep = "_")





