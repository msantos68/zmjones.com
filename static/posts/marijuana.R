pkgs <- c("ggplot2", "mgcv", "data.table", "maps", "maptools",
          "lubridate", "grid", "mapproj")
invisible(lapply(pkgs, require, character.only = TRUE))

changeQuality <- function(sim.df, level) {
    sim.df$quality <- level
    return(sim.df)
}

changeDate <- function(sim.df, orig.df, date) {
    sim.df$time <- unique(orig.df$time[orig.df$date == date])
    return(sim.df)
}

df <- read.csv("../data/mj-clean.csv")
df <- data.table(df)
df <- df[, time := .GRP, by = "date"]
df$state <- as.factor(df$state)
df$quality <- as.factor(df$quality)

space.fit <- gam(ppg ~ -1 + quality + s(amount) + state +
                 te(lon, lat, time, by = quality, d = c(2, 1)),
                 select = TRUE, data = df)

us.map <- map("state", fill = TRUE, plot = FALSE)
us.points <- spsample(map2SpatialPolygons(us.map, IDs = us.map$names),
                      n = 50000, type = "regular")
us.points <- as.data.frame(us.points)
us.map <- fortify(us.map)
sim.data <- data.frame(quality = "high", amount = median(df$amount),
                       time = 1, lat = us.points$x2,
                       lon = us.points$x1, state = "GA")
sim.data <- do.call("rbind", lapply(levels(df$quality),
                                    function(x) changeQuality(sim.data, x)))
s.date <- seq.Date(as.Date("2011-01-01", "%Y-%m-%d"),
                   as.Date(max(df$date), "%Y-%m-%d"), by = "1 year")
sim.data <- do.call("rbind", lapply(s.date, function(x)
                                    changeDate(sim.data, df, x)))
pred <- predict(space.fit, newdata = sim.data, type = "terms")
pred <- pred[, grepl("lon,lat,time", colnames(pred))]
sim.data$pred <- apply(pred, 1, function(x) x[x != 0])
sim.data <- sim.data[, grepl("quality|time|lat|lon|pred", colnames(sim.data))]
sim.data$pred <- sim.data$pred * 100
sim.data$quality <- factor(sim.data$quality,
                           levels = c("high", "medium", "low"))
sim.data$time <- factor(sim.data$time, levels = unique(sim.data$time),
                        labels = year(s.date))
p <- ggplot(us.map)
p <- p + geom_tile(data = sim.data, aes(x = lon, y = lat, fill = pred))
p <- p + stat_contour(data = sim.data, aes(x = lon, y = lat, z = pred),
                      alpha = .25)
p <- p + scale_fill_gradient2(space = "Lab", name = "% change\n in $/gram")
p <- p + guides(fill = guide_colorbar(barwidth = .75, barheight = 10,
                    ticks = FALSE))
p <- p + borders("state", colour = "black", size = .25)
p <- p + facet_grid(time ~ quality)
p <- p + labs(x = NULL, y = NULL)
p <- p + coord_map("albers", 29.5, 45.5)
p <- p + theme_bw()
p <- p + theme(axis.line = element_blank(),
               axis.text.x = element_blank(), axis.text.y = element_blank(),
               axis.title.x = element_blank(), axis.title.y = element_blank(),
               axis.ticks = element_blank(), panel.border = element_blank(),
               panel.grid.major = element_blank(),
               plot.margin = unit(rep(.1, 4), "in"))
ggsave("space-time-map.png", plot = p, height = 4, width = 7, dpi = 600)
