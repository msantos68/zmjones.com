set.seed(1987)
CORES <- 8

pkgs <- c("multicore", "party", "reshape2", "ggplot2", "cshapes", "rgeos")
invisible(lapply(pkgs, require, character.only = TRUE))

df <- read.csv("http://zmjones.com/static/data/polity.csv", na.strings = c("-88", "-77", "-66"))
df <- df[!is.na(df$polity2) & !is.na(df$democ) &
         !is.na(df$autoc), c(2,5,8:9,11,14:18)]

world <- cshp(date = as.Date("2008-1-1"))
world.pts <- fortify(world, region = "COWCODE")
names(world.pts)[7] <- "ccode"
df.latest <- df[df$year == max(df$year), ]
polity.map <- merge(world.pts, df.latest, sort = FALSE,
                    by = "ccode", all.x = TRUE)
polity.map <- polity.map[order(polity.map$order), ]

map.theme <- function() {
  theme_bw() + theme(axis.line = element_blank(),
                     axis.text.x = element_blank(),
                     axis.text.y = element_blank(),
                     axis.title.x = element_blank(),
                     axis.title.y = element_blank(),
                     axis.ticks = element_blank(),
                     panel.border = element_blank(),
                     panel.grid.major = element_blank(),
                     plot.margin = unit(c(.1, .1, .1, .1), "in"))
}

p <- ggplot(data = polity.map, aes(x = long, y = lat,
              group = group, fill = polity2))
p <- p + geom_polygon()
p <- p + geom_path()
p <- p + scale_y_continuous(breaks = (-2:2) * 30)
p <- p + scale_x_continuous(breaks = (-4:4) * 45)
p <- p + scale_fill_gradient2(name = "Polity Scale",
                              breaks = c(-10, -7, 0, 7, 10))
p <- p + labs(title = "2012 Democracy-Autocracy Scores", x = NULL, y = NULL)
p <- p + guides(fill = guide_colorbar(barwidth = .75,
                  barheight = 15, ticks = FALSE))
p <- p + map.theme()
ggsave("polity_map.png", plot = p, height = 4.2, width = 8.25)

df <- lapply(df[, -c(1:2)], switch("ordered", ordered = as.ordered))
df <- as.data.frame(df)

ivars <- vector("list", length = 3)
ivars[["democ"]] <- names(df[, -c(1:3,7)])
ivars[["autoc"]] <- names(df[, -c(1:3)])
ivars[["polity2"]] <- names(df[, -c(1:3)])

imp <- mclapply(names(df[, c(1:3)]), function(x) {
  formula <- as.formula(paste0(x, "~", paste0(ivars[[x]], collapse = "+")))
  varimp(cforest(formula, data = df), conditional = TRUE)
}, mc.cores = CORES)

insert <- function(v, e, pos, name) {
  v <- c(v[1:(pos - 1)], e, v[pos:(length(v))])
  names(v)[pos] <- name
  return(v)
}

imp[[1]] <- insert(imp[[1]], NA, 4, "parreg")
imp <- as.data.frame(do.call("rbind", imp))
imp$depvar <- c("Democracy Score", "Autocracy Score", "Combined Polity Score")
imp$depvar <- factor(imp$depvar, levels = imp$depvar)
imp <- melt(imp, id.vars = "depvar")

p <- ggplot(data = na.omit(imp), aes(x = factor(variable), y = value))
p <- p + facet_wrap(~ depvar, ncol = 1, scales = "free")
p <- p + geom_bar(stat = "identity", width = .75)
p <- p + labs(x = "Component", y = "Permutation Importance")
p <- p + theme_bw()
p <- p + theme(plot.margin = unit(rep(.15, 4), "in"))
ggsave("polity.png", plot = p, width = 6, height = 6)
