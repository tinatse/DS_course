library(dplyr)

if(!file.exists("./data")){dir.create("./data")}

fileUrl = "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")

restData = read.csv("./data/restaurants.csv")

#head data
head(restData, 3)
tail(restData, 3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = T)
quantile(restData$councilDistrict, probs = c(0.5,0.7,0.95))


table(restData$zipCode, useNA = "ifany")
#it is important to specify NA, because R by default will not give you NA

table(restData$councilDistrict, restData$zipCode)

#sum number of NAs in councilDistrict
sum(is.na(restData$councilDistrict))
#is there any NA in councilDistrict?
any(is.na(restData$councilDistrict))

#are all zipcodes bigger than zero?
all(restData$zipCode>0)
all(restData$zipCode>=-21226)
#how many NAs can we find in each column in restData?
colSums(is.na(restData))

#check that sum of NAs is zero in every column
all(colSums(is.na(restData))==0)

#how many zipCode are "21212"?
table(restData$zipCode %in% c("21212"))

#how many zipCode are "21212" or "21213"?
table(restData$zipCode %in% c("21212", "21213"))  

#show all data in which zipCode is "21212" or "21213"
restData[restData$zipCode %in% c("21212", "21213"),]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)

summary(DF)

#give me a table with the sum of Freq, by Gender (rows) and Admit (columns)
xt = xtabs(Freq ~ Gender + Admit, data = DF)
xt

#which produces a neater table than this:
DF %>%
  group_by(Gender, Admit) %>%
  summarise(Freq = sum(Freq))


warpbreaks$replicate = rep(1:9, len = 54)

#produces another table using factors, produces a table per each "replicate"
xt = xtabs(breaks ~., data = warpbreaks)
xt

#a neater table for that kind of data
ftable(xt)

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")
