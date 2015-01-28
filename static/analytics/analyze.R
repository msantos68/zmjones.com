pkgs <- c("dplyr", "lubridate", "reshape2", "ggplot2", "scales")
invisible(lapply(pkgs, function(x) suppressMessages(library(x, character.only = TRUE))))

path <- "/Users/zmjones/Sites/zmjones.com/static/analytics/"

df <- read.csv(paste0(path, "logs.csv"))
colnames(df) <- tolower(colnames(df))

total <- paste(comma_format()(length(unique(df$remote_ip))), "total")
paste(length(unique(df$remote_ip[df$key == "cv"])), "cv views")

recent <- df[as.Date(df$date, format = "%m-%d-%Y") >= Sys.Date() - 7, ]
paste(length(unique(recent$remote_ip)), "unique views last week")
recently_popular <- recent %>% group_by(key) %>%
    summarize("views" = sum(length(unique(remote_ip)))) %>%
    filter(key != "index.html" & key != "")
recently_popular <- recently_popular[order(recently_popular$views, decreasing = TRUE), ]
head(recently_popular)

total_views <- df %>% group_by(date) %>%
    summarize("views" = sum(length(unique(remote_ip)))) %>%
    mutate("date" = as.Date(date, format = "%m-%d-%Y"))
p <- ggplot(total_views, aes(date, views))
p <- p + geom_point()
p <- p + geom_smooth(method = "loess")
p <- p + scale_x_date(labels = date_format("%m-%y"))
p <- p + labs(x = "date (aggregated to day)", y = "unique viewers",
              title = paste0("unique viewers by day (", total, ")"))
p <- p + theme_bw()
ggsave(paste0(path, "daily_views.png"), plot = p, width = 10, height = 5)

views_by_key <- df %>% group_by(key) %>%
    summarize("views" = sum(length(unique(remote_ip)))) %>%
    filter(key != "index.html" & key != "")
views_by_key <- views_by_key[order(views_by_key$views, decreasing = TRUE), ]
views_by_key$key <- factor(views_by_key$key, levels = views_by_key$key[order(views_by_key$views)])
write.csv(views_by_key, paste0(path, "views_by_key.csv"), row.names = FALSE)

p <- ggplot(views_by_key[1:30, ], aes(key, views))
p <- p + geom_bar(stat = "identity")
p <- p + scale_y_continuous(breaks = pretty_breaks())
p <- p + labs(x = NULL, y = NULL)
p <- p + coord_flip()
p <- p + theme_bw()
ggsave(paste0(path, "top_keys.png"), plot = p, width = 6, height = 8)
