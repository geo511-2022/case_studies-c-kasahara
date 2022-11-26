library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
library(getData)
library(ncdf4)
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc")

# Download monthly WorldClim data
data(world)
tmean=raster("crudata.nc")

# Remove “Antarctica” with filter() because WorldClim does not have data there.
world %>%
  filter(continent != "Antarctica")

# Convert the world object to sp format 
new_world <- as(world,"Spatial")

plot(tmean)

tmax_annual <- max(tmean)
names(tmax_annual) <- "tmax"

tmax_country <- raster::extract(x = tmax_annual, y = new_world, fun=max, na.rm=T, small=T, sp=T) %>%
  st_as_sf(new_world)

ggplot(tmax_country, aes(fill = tmax)) +
  geom_sf() +
  coord_sf(label_graticule = "SW", label_axes = "SW") +
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") +
  theme(legend.position = 'bottom')

hottest_continents <- tmax_country %>% 
  group_by(continent) %>%
  arrange(.by_group = TRUE) %>% 
  select(c(name_long, continent, tmax))%>%
  slice_max(order_by = tmax)%>% 
  st_set_geometry(NULL)
