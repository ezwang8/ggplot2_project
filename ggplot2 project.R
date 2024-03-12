library(ggplot2)
library(data.table)
df <- fread('Economist_Assignment_Data.csv',drop=1)

# Checking the head of df
head(df)

# Use ggplot() + geom_point() to create a scatter plot object
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point()
pl

# Change the points to be larger empty circles.
pl <- ggplot(df,aes(x=CPI,y=HDI,color=Region)) + geom_point(size=4,shape=1)
pl

# Add geom_smooth(aes(group=1)) to add a trend line
pl + geom_smooth(aes(group=1))

# Further trend line edits
pl2 <- pl + geom_smooth(aes(group=1),method ='lm',formula = y~log(x),se=FALSE,color='red')
pl2

# Labels for all points
pl2 + geom_text(aes(label=Country))

# Labels to specific points
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3

# Add theme_bw() to your plot
pl4 <- pl3 + theme_bw() 
pl4

# Add scale_x_continuous()
pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                                limits = c(.9, 10.5),breaks=1:10) 
pl5

# Use scale_y_continuous to do similar operations to the y axis
pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                                limits = c(0.2, 1.0))
pl6

# Finally use ggtitle() to add a string as a title and use ggthemes
pl6 + ggtitle("Corruption and Human development")

library(ggthemes)
pl6 + theme_economist_white()

