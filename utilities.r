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


#Expand tables() Complete a data frame with missing combinations of data
df <- tibble(
  year   = c(2010, 2010, 2010, 2010, 2012, 2012, 2012),
  qtr    = c(   1,    2,    3,    4,    1,    2,    3),
  return = rnorm(7)
  )

a<-df %>% expand(year, qtr)
b<-df %>% expand(year = 2010:2012, qtr)
c<-df %>% expand(year = full_seq(year, 1), qtr)
d<-df %>% complete(year = full_seq(year, 1), qtr)


#Missing values
df <- tibble(
  year   = c(2010, NA, 2010, 2010, 2012, 2012, 2012),
  qtr    = c(   NA,    2,    NA,    4,    1,    2,    3)
)

#drop_na() Drop rows containing NA's in . columns
a<-drop_na(df, year)
a<-drop_na(df, year,qtr)

#fill() Fill in NA's in columns with most recent non-NA values.
a<-fill(df, year)

#replace_na() Replace NA's by column
a<-replace_na(df, list(qtr = 100))


#5.DATA TRANSFORMATION
df<-data.frame(x=c('a','b','c','c','a','a','a'),
               y=c('b','b','c','a','a','a','a'),
               z=c(1,2,3,2,1,2,NA)
)

#Select Rows
a<-df %>% filter(x=='a') #select rows under certain criteria
a<-df %>% distinct() #remove duplicate rows
a<-df %>% sample_n(5, replace = FALSE) #extract a sample of n 
a<-df %>% slice(1:2) #select by position
a<-df %>% filter(x=='a' & y==1) #and 
a<-df %>% filter(x=='a' | y==1) #or conidtion
a<-df %>% filter(is.na(y)) #missing values
a<-df %>% filter(!is.na(y)) #no missing values
a<-df %>% filter(x %in% c('a','b')) # in clause 
a<-df %>% filter_all(any_vars(. == 'a')) #select all columns that any column fit to certain filter
a<-df %>% filter_all(all_vars(. == 'a')) #select all columns that all columns fit to certain filter
a<-df %>% filter_at(vars(x,y),all_vars(.=='a')) #select the columns on wich would be applied the filter


#Select Columns
df<-data.frame(x=c('a','b','c','c','a','a','a'),
               x1=c('a','b','c','c','a','a','a'),
               x2=c('a','b','c','c','a','a','a'),
               y=c('b','b','c','a','a','a','a'),
               z=c(1,2,3,2,1,2,NA)
)

a<-df %>% select(x,y) #select columns by name
a<-df %>% select(x:z) #when we have lot of columns, it is convenient to use ":"
a<-df %>% select(-x) #deselect column
a<-df %>% select(starts_with('x')) #all columns that start with certain character - exact pattern
a<-df %>% select(ends_with('1')) #all columns that end with certain character - exact pattern
a<-df %>% select(contains('x')) #all columns that contains with certain character - exact pattern
a<-df %>% select(matches('[[:digit:]]')) #select columns based on regex
a<-df %>% select_if(is.numeric) #select based on datatype
a<-df %>% select(y,x) #reordering columns
a<-df %>% select_all(toupper) #apply function to all name columns
a<- mtcars %>%tibble::rownames_to_column("car_model") %>% head #row_names to columns

#Summarise Data
a<-df %>% count() #count the number of observations
a<-df %>% add_tally() #adding a column with the number of total observations
a<-df %>% add_count(x) #adding a column with the number of observations of certain variable
a<-df %>% summarise(avg = mean(z, na.rm = TRUE), n=n(), sum=sum(z, na.rm = TRUE)) #Summarise data into single row of values.
a<-df %>% group_by(x) %>% summarise(avg = mean(z, na.rm = TRUE), n=n(), sum=sum(z, na.rm = TRUE)) #with group
n() #gives the number of observations
n_distinct(var) #gives the numbers of unique values of var
sum(var)
max(var)
min(var)
mean(var)
median(var)
sd(var)
IQR(var)


#https://www.r-bloggers.com/aggregation-with-dplyr-summarise-and-summarise_each/
a<-df %>% group_by(x) %>% summarise_all(mean, na.rm=TRUE) #apply one function to all variables
summarise_all() #Apply funs to every column. 
summarise_at() #Apply funs to specific columns. 
summarise_if() #Apply funs to all cols of one type.



#Make new variables
a<- df %>% mutate(new_variable = 5) #make new vairable
a<- df %>%  mutate(acumulado = cumsum(z)) #vector_functions
lag()   #Offset elements by 1 
lead()  #Offset elements by -1
cumall() #Cumulative all() 
cumsum()
a<-df %>% mutate(z_new = ifelse(x=='a',z,'uh')) # ifellse inside mutate


#mutate vs mutate_each


df<-data.frame(x=c('a','b','c','c','a','a','a'),
               x1=c('a','b','c','c','a','a','a'),
               x2=c('a','b','c','c','a','a','a'),
               y=c('b','b','c','a','a','a','a'),
               z1=c(1,2,3,2,1,2,NA),
               z2=c(1,2,3,2,1,2,10)
)


#arrange
#combine data sets





