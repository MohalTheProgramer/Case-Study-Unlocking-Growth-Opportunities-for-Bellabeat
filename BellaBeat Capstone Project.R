## bunisiness Task
#identify potnential opportunities for growth and rocemmendations for the bella beat Marketing strategy imrpovement based on trends in smart device usage

##loading packages needed for the set up
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(skimr)
library(janitor)
library(lubridate)



#importing datasets that will needed
dailyAcitviy <- read_csv("~/R project dataset/dailyActivity_merged.csv")
dailySteps <- read_csv("~/R project dataset/dailySteps_merged.csv")
Sleep <- read_csv("~/R project dataset/sleepDay_merged.csv")
HourlyCalories <- read_csv("~/R project dataset/hourlyCalories_merged.csv")
HourlySteps <- read_csv("~/R project dataset/hourlySteps_merged.csv")

##has a small sample but will be used to see things though involving weight
weightLog <- read_csv("~/R project dataset/weightLogInfo_merged.csv")
##viewing dataset

view(dailyAcitviy)
view(dailySteps)
view(Sleep)
view(weightLog)
view(HourlyCalories)
view(HourlySteps)

##cleaning  the dataset
#checking for unique values
n_unique(dailyAcitviy$Id)#33 users
n_unique(Sleep$Id)#24 users
n_unique(dailySteps$Id)#33 users
n_unique(weightLog$Id)#8 users
n_unique(HourlyCalories$Id)#33 users
n_unique(HourlySteps$Id)#33 users

#checking for duplicates
sum(duplicated(dailyAcitviy))#0 duplicates
sum(duplicated(Sleep))#3 duplicates
sum(duplicated(dailySteps))#0 duplicates
sum(duplicated(weightLog))#0 duplicates
sum(duplicated(HourlyCalories))#0
sum(duplicated(HourlySteps))#0

#removing the duplicates and and NA
dailyActivity <- dailyAcitviy %>%
  distinct() %>%
  drop_na()

dailySleep <- Sleep %>%
  distinct() %>%
  drop_na()

HourlySteps <- HourlySteps %>%
  distinct() %>%
  drop_na()

HourlyCalories <- HourlyCalories %>%
  distinct() %>%
  drop_na()

dailySteps <- dailySteps %>%
  distinct() %>%
  drop_na()
#removing fat columns for weightLog
weightLog <- weightLog %>% 
  select(-Fat)

sum(duplicated(dailySteps))#removed duplicates
#table names are fine so leaving them like this makes them easy to read
#sorting out the date formats
dailyAcitviy <- dailyAcitviy %>% 
  mutate(ActivityDate = as_date(ActivityDate,format = "%m/%d/%Y")) 

dailySteps <- dailySteps %>% 
  mutate(ActivityDay = as_date(ActivityDay,format = "%m/%d/%Y")) 

dailySleep <- dailySleep %>% 
  mutate(SleepDay = as_datetime(SleepDay,format = "%m/%d/%Y %I:%M:%S %p"))

weightLog <- weightLog %>% 
  mutate(Date = as_datetime(Date,format = "%m/%d/%Y %I:%M:%S %p"))

HourlySteps <- HourlySteps %>% 
  mutate(ActivityHour = as_datetime(ActivityHour,format = "%m/%d/%Y %I:%M:%S %p"))

HourlyCalories <- HourlyCalories %>% 
  mutate(ActivityHour = as_datetime(ActivityHour,format = "%m/%d/%Y %I:%M:%S %p"))

head(dailySleep)
head(weightLog)
head(hourlySteps)
head(HourlyCalories)
##changing all date colums to be the same
dailyAcitviy <- dailyAcitviy %>% 
  rename(Date = ActivityDate)
dailySteps <- dailySteps %>% 
  rename(Date = ActivityDay)
dailySleep <- dailySleep %>% 
  rename(Date = SleepDay)
weightLog <- weightLog %>% 
  rename(Date = Date)
HourlySteps <- HourlySteps %>% 
  rename(Date = ActivityHour)
HourlyCalories <- HourlyCalories %>% 
  rename(Date = ActivityHour)
#all date and time sorted
###merging tables the daily activity and sleep can be merged

dailyActivitySleep <- merge(dailyAcitviy, dailySleep, by=c ("Id", "Date"))
glimpse(dailyActivitySleep)
View(dailyActivitySleep)
###datasets that will be used for analysis
#dailyAcitviy
#dailySteps
#dailySleep 
#dailySleep
#weightLog
#HourlySteps
#HourlyCalories
#dailyActivitySleep

###creating a summary for each dataset

dailyActivitySleep %>% 
  select(TotalSteps,TotalDistance,Calories,TotalTimeInBed,TotalMinutesAsleep) %>% 
  summary()

weightLog %>% 
  select(WeightPounds,WeightKg,BMI) %>% 
  summary()


##Visualization

  ggplot(data = dailyActivitySleep)+
    geom_jitter(mapping = aes(x=TotalSteps,y=Calories,colour = "red"))+
    geom_smooth(mapping = aes(x=TotalSteps,y=Calories))+
    labs(title = "Total Steps VS. Calories")
  
  ggplot(data = dailyActivitySleep)+
    geom_point(mapping = aes(x=TotalMinutesAsleep,y=TotalTimeInBed,colour = "red"))+
    geom_smooth(mapping = aes(x=TotalMinutesAsleep,y=TotalTimeInBed))+
    labs(title = "Total Minutes Asleep VS. Total Time in Bed")


##creating deeper visualizations
#creating a histogram showing the avarage callaries burnt throughout the day
hourly_Calories <- HourlyCalories %>% 
  separate(Date,into = c("Date","Time"),sep = " ") %>% 
  mutate(Date = ymd(Date))

hourly_Calories <- hourly_Calories %>% 
  drop_na()

head(hourly_Calories)

hourly_Calories %>% 
  group_by(Time) %>% 
  summarise(average_Calories = mean(Calories)) %>% 
  ggplot()+
  geom_col(mapping = aes(x=Time,y= average_Calories,fill = average_Calories))+
  labs(title = "Hourly Calories throughout the day",x="",y="")+
  scale_fill_gradient(low = "pink",high = "red")+
  theme(axis.text.x = element_text(angle = 90))

##histogram for average hourly steps
hourly_Steps <- HourlySteps %>%
  separate(Date,into = c("Date", "Time"), sep= " ") %>%
  mutate(Date = ymd(Date)) %>% 
  drop_na()

head(hourly_Steps)

hourly_Steps %>% 
  group_by(Time) %>% 
  summarise(average_Steps = mean(StepTotal)) %>% 
  ggplot()+
  geom_col(mapping = aes(x=Time,y= average_Steps,fill = average_Steps))+
  labs(title = "Hourly Steps throughout the day",x="",y="")+
  scale_fill_gradient(low = "pink",high = "red")+
  theme(axis.text.x = element_text(angle = 90))

##creatinga graph to showcase user types
#high use, moderate use and low use

dailyUserType <- dailyActivitySleep %>% 
  group_by(Id) %>% 
  summarise(daysUsed=sum(n())) %>% 
  mutate(usage = case_when(
    daysUsed >= 1 & daysUsed <= 10 ~"Low Use",
    daysUsed >= 11 & daysUsed <= 20 ~"Moderate Use",
    daysUsed >= 21 & daysUsed <= 31 ~"High Use",
  ))
head(dailyUserType)

##creating a percentage dataframe that will be used to creat a barchart
dailyUserTypePercent <- dailyUserType %>% 
  group_by(usage) %>% 
  summarise(total = n()) %>% 
  mutate(totals = sum(total)) %>% 
  group_by(usage) %>% 
  summarise(totalPercent = total/totals) %>% 
  mutate(labels = scales :: percent(totalPercent))

dailyUserTypePercent$usage <- factor(dailyUserTypePercent$usage,levels 
                                     =c("High Use","Moderate Use","Low Use"))
head(dailyUserTypePercent)
##creating the pie chart
dailyUserTypePercent %>%
  ggplot(aes(x="",y=totalPercent, fill=usage)) +
  geom_bar(stat = "identity", width = 1)+
  coord_polar("y", start=0)+
  theme_minimal()+
  theme(axis.title.x= element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(), 
        panel.grid = element_blank(), 
        axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        plot.title = element_text(hjust = 0.5, size=14, face = "bold")) +
  geom_text(aes(label = labels),
            position = position_stack(vjust = 0.5))+
  scale_fill_manual(values = c("#F81458","#CC3366","#F83D80"),
                    labels = c("High use - 21 to 31 days",
                               "Moderate use - 11 to 20 days",
                               "Low use - 1 to 10 days"))+
  labs(title="Daily use of smart device")

#graphs are completed analysis will be done and documented
