require(ggplot2)
require(mgcv)
require(MASS)

#http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3info.txt
load(url('http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.sav'))
titanic3 <- na.omit(titanic3[, c(1:2,4:6)])
titanic3$class_sex <- factor(apply(titanic3, 1, function(x) paste(x[1], x[3], collapse = "_")))
train <- titanic3[sample(row.names(titanic3), size = round(nrow(titanic3) / 2)), ]
test <- titanic3[!(row.names(titanic3) %in% row.names(train)), ]

glm.fit <- glm(survived ~ poly(age, 2) * sex * pclass + sibsp,
               family = "binomial", data = train)

inv.logit <- function(x) exp(x) / (1 + exp(x))

glm.pred <- predict(glm.fit, newdata = test, se.fit = TRUE)

pred <- data.frame(mean = inv.logit(glm.pred$fit),
                   lo = inv.logit(glm.pred$fit - 2 * glm.pred$se.fit),
                   hi = inv.logit(glm.pred$fit + 2 * glm.pred$se.fit),
                   survived = test$survived)
pred <- pred[order(pred$mean), ]
pred$id <- seq_along(pred$mean)
row.names(pred) <- NULL

p <- ggplot(pred, aes(x = id))
p <- p + geom_line(aes(x = id, y = mean))
p <- p + geom_ribbon(aes(y = mean, ymin = lo, ymax = hi), alpha = 0.25)
p <- p + geom_vline(xintercept = which(pred$survived == 1),
                    colour = "red", alpha = .95)
p <- p + scale_x_discrete(breaks = NULL)
p <- p + labs(x = NULL, y = "prediction")
ggsave("titanic-separation-glm.png", width = 8.5, height = 1.5)

sim.data <- expand.grid(sex = c("male", "female"), sibsp = 0,
                        age = seq(1, 80), pclass = c("1st", "2nd", "3rd"))

pred <- predict(glm.fit, newdata = sim.data, se.fit = TRUE)
sim.data$mean <- inv.logit(pred$fit)
sim.data$lo <- inv.logit(pred$fit - 2 * pred$se.fit)
sim.data$hi <- inv.logit(pred$fit + 2 * pred$se.fit)

p <- ggplot(titanic3, aes(x = age, y = survived))
p <- p + geom_rug()
p <- p + facet_grid(sex ~ pclass)
p <- p + geom_line(data = sim.data, aes(y = mean), color = "blue")
p <- p + geom_ribbon(data = sim.data, aes(y = mean, ymin = lo, ymax = hi),
                     alpha = .25)
p <- p + labs(x = "Passenger Age", y = "Probability of Survival")
ggsave("titanic-survival-glm.png", width = 8.5, height = 6)

gam.fit <- gam(survived ~ s(age, by = class_sex) + pclass * sex + sibsp,
               family = "binomial", data = train)

pred <- data.frame(mean = inv.logit(glm.pred$fit),
                   lo = inv.logit(glm.pred$fit - 2 * glm.pred$se.fit),
                   hi = inv.logit(glm.pred$fit + 2 * glm.pred$se.fit),
                   survived = test$survived)
pred <- pred[order(pred$mean), ]
pred$id <- seq_along(pred$mean)
row.names(pred) <- NULL

p <- ggplot(pred, aes(x = id))
p <- p + geom_line(aes(x = id, y = mean))
p <- p + geom_ribbon(aes(y = mean, ymin = lo, ymax = hi), alpha = 0.25)
p <- p + geom_vline(xintercept = which(pred$survived == 1),
                    colour = "red", alpha = .95)
p <- p + scale_x_discrete(breaks = NULL)
p <- p + labs(x = NULL, y = "prediction")
ggsave("titanic-separation-gam.png", width = 8.5, height = 1.5)

sim.data <- expand.grid(sex = c("male", "female"), sibsp = 0,
                        age = seq(1, 80), pclass = c("1st", "2nd", "3rd"))
sim.data$class_sex <- apply(sim.data, 1, function(x) paste(x[4], x[1], collapse = "_"))

br <- mvrnorm(1000, coef(gam.fit), vcov(gam.fit))
xp <- predict(gam.fit, newdata = sim.data, type = "lpmatrix")
ppd <- t(apply(xp %*% t(br), 1, function(x)
               inv.logit(quantile(x, probs = c(.025, .5, .975)))))
colnames(ppd) <- c("lo", "mean", "hi")
sim.data <- cbind(sim.data, ppd)

p <- ggplot(titanic3, aes(x = age, y = survived))
p <- p + geom_rug()
p <- p + facet_grid(sex ~ pclass)
p <- p + geom_line(data = sim.data, aes(y = mean), color = "blue")
p <- p + geom_ribbon(data = sim.data, aes(y = mean, ymin = lo, ymax = hi),
                     alpha = .25)
p <- p + labs(x = "Passenger Age", y = "Probability of Survival")
ggsave("titanic-survival-gam.png", width = 8.5, height = 6)
