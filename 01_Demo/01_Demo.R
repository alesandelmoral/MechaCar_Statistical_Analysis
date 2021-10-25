# package installations
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
library(tidyr)

demo_table[3,"Year"]
demo_table[3,3]
demo_table$"Vehicle_Class"
demo_table$"Vehicle_Class"[2]
filter_table <- demo_table2[demo_table2$price >10000,]

#Filtering with multiple conditions 
filter_Table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status)
#The next sentence is the same as the previous 
#filter_table3 <- demo_table2[("clean" %in% demo_table2$title_status) & (demo_table2$price > 10000) & (demo_table2$drive == "4wd"),]

#Take a Sample of or data base
#capture the number of rows
num_rows <- 1:nrow(demo_table)
#Choosing 3 of those rows
sample_rows <- sample(num_rows,3)
#print the sample rows
demo_table[sample_rows,]

#If we want to make this in a single line then:
demo_table[sample(1:nrow(demo_table),3),]

#add columns to original data frame
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE)

#Using groupBy funtion
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarise(Mean_Mileage=mean(odometer), .groups = 'keep')

#Adding calculation to our summary
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep')


#Our data is in long format because we have different metrics collected from a single vehicle
#Convert our data in log format with gather function 
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)

#Alternative way to make a long format
long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)


#Making the previos data base into a wide format
wide_table <- long_table %>% spread(key="Metric",value="Score")

#Cheeking if our data transformations are the same as the beginning table
all.equal(demo_table3, long_table)
all.equal(demo_table3, wide_table)


table <-demo_table3[,order(colnames(wide_table))]
all.equal(demo_table3, wide_table)

table <- demo_table3[,(colnames(wide_table))]
all.equal(demo_table3, wide_table)

#-----------------------------------------------------------------
head(mpg)
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=class)) 
plt + geom_bar() #plot a bar plot

#create summary table
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') 
#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) 
#plot a bar plot
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") +
#rotate the x-axis label
theme(axis.text.x=element_text(angle=45,hjust=1)) 

#create summary table
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') 
#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) 
#add line plot with labels
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30))

#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty)) 
#add scatter plot with labels
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)") 

#Adding more customizing to our plot
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) 
#add scatter plot with labels
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class") 

#Adding colors and forms to the graph
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv)) 
#add scatter plot with multiple aesthetics
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive") 

#Box Plot map
#import dataset into ggplot2
plt <- ggplot(mpg,aes(y=hwy))
#add boxplot
plt + geom_boxplot() 

#Multiple Box Plots
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) 
#add boxplot and rotate x-axis labels 45 degree
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) 

#------Creating a Headmap for vehicules
#create summary table
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') 
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
#create heatmap with labels
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)")


#create summary table
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') 
#import dataset into ggplot2
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) 
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") +  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) #rotate x-axis labels 90 degrees


#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) 
#add boxplot
plt + geom_boxplot() + 
theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
geom_point() #overlay scatter plot on top


mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot
  

#Error Bars
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars

#mpg in long format
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
head(mpg_long)

plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees

plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels


#NORMAL DISTRIBUTION
ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot

#Shapirp test
shapiro.test(mtcars$wt)

#-----------------Random sample------------------
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#Taking a sample of the dataset
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#----------------one sample T-test---------------------
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means

#---------------two sample T-test
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points

t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples


#--------------compare two samples----------------------
mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008

t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

#-----------------ANOVA Analisys------------
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor

aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
#Get the p-value
summary(aov(hp ~ cyl,data=mtcars_filt))

#--------------------Correlation between variables------------------
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot

#numerical correlation
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient

#Othe example
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)

plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot

cor(used_cars$Miles_Driven,used_cars$Selling_Price) #calculate correlation coefficient

#-------------Correlation Matrix-------------------------
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)

#-------------------Linear Regretion-------------
lm(qsec ~ hp,mtcars) #create linear model
#Get the p-value
summary(lm(qsec~hp,mtcars)) #summarize linear model

#visualize the linear regretion
model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp +
model$coefficients['(Intercept)'] #determine y-axis values from linear model

#Graph
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter

#Multiple linear regretion
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model

summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics

#Create our continge table
table(mpg$class,mpg$year) #generate contingency table

tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions