# Use library(ggplot2); library(gapminder); library(dplyr) to load the necessary packages.
library(gapminder)
library(ggplot2)
library(dplyr)

# Use filter() to remove “Kuwait” from the gapminder dataset for reasons noted in the background
gapm <- filter(gapminder, country != "Kuwait")

# Plot #1 (the first row of plots)
ggplot(gapm, aes(x = lifeExp, y = gdpPercap, color = continent, size = pop/100000)) +
  geom_point() +
  facet_wrap(~year, nrow=1) +
  scale_y_continuous(trans = "sqrt") +
  theme_bw() +
  labs(x = "Life Expectancy", y = "GDP per capita", color = "Continent", size = "Population (100K)")

ggsave("case3_graph1.png", width = 15, units = "in")

# Prepare the data for the second plot
gapminder_continent <- gapm %>%
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), pop = sum(as.numeric(pop)))

# Plot #2 (the second row of plots)
ggplot(gapm, aes(x = year, y = gdpPercap)) +
  geom_line(aes(color = continent, group = country)) +
  geom_point(aes(color = continent, group = country)) +
  geom_line(data = gapminder_continent, aes(year, gdpPercapweighted)) +
  geom_point(data = gapminder_continent, aes(year, gdpPercapweighted, size = pop/100000)) +
  facet_wrap(~continent, nrow=1) +
  theme_bw() +
  labs(x = "Year", y = "GDP per capita", color = "Continent", size = "Population (100K)")

ggsave("case3_graph2.png", width = 15, units = "in")
