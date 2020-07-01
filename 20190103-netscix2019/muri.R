library(lergm)
library(dplyr)
library(magrittr)

dat     <- haven::read_sav("data-raw/MURI_AllSurveys - FINAL_073018.sav")
group   <- haven::read_sav("data-raw/MURI_AllSurveys - FINAL - Group level data_11-9-18.sav")
adjmats <- readRDS("data/networks_truth.rds")
adjmats <- adjmats[[2]]$advice
# adjmats <- readRDS("data/networks_advice_las.rds")

# Normalizing soc skill
dat$Empathy_norm <- (dat$Empathy - min(dat$Empathy))/
  diff(range(dat$Empathy))

dat$Empathy_norm <- case_when(
  dat$Empathy_norm < 1/3 ~ 1/3,
  dat$Empathy_norm < 2/3~ 2/3,
  TRUE ~ 1
)

# Creating networks
networks <- vector("list", length(adjmats))
names(networks) <- names(adjmats)
for (i in names(adjmats)) {
  
  # Participant's ids
  ids <- sprintf("%02i%s", as.integer(i), rownames(adjmats[[i]]))
  
  # Pulling data
  gender <- filter(dat, PID %in% ids) %>%
    select(PID, GenderMvsF, Ethnicity, racenonwhite, Empathy_norm) %>%
    transmute(
      name     = PID,
      male     = as.integer(GenderMvsF == 1),
      hispanic = as.integer(Ethnicity == 1),
      nonwhite = as.integer(racenonwhite == 1),
      Empathy = as.integer(Empathy_norm)
    ) %>%
    mutate(name = gsub("^[0-9]+", "", name)) %>%
    as.list()
  
  networks[[i]] <- network::network(adjmats[[i]], gender[-1])
  
}

# Summary stats
staistics <- dat %>%
  group_by(Group) %>%
  summarize(
    Size = n(),
    male = mean(GenderMvsF == 1),
    age  = mean(Age),
    emp  = diff(range(Empathy_norm))
  ) %>%
  ungroup() %>% group_by(Size) %>%
  summarise(
    Count   = n(),
    Male    = mean(male, na.rm = TRUE),
    Age     = mean(age, na.rm = TRUE),
    Empathy = mean(emp, na.rm = TRUE)
  )

saveRDS(staistics, "muri_staistics.rds")

# Filtering
networks_less3 <- networks[sapply(networks, nvertex) > 3]

# Fitting the lergm
ans <- lergm(networks ~ mutual + edges + triangle + nodematch("male") +
               diff("Empathy") + nodematch("nonwhite"))
ans_less3 <- lergm(networks_less3 ~ mutual + edges + triangle + nodematch("male") +
               diff("Empathy") + nodematch("nonwhite"))
confint(ans)
confint(ans_less3)

saveRDS(ans, "muri_estimates.rds")
saveRDS(ans_less3, "muri_estimates_less3.rds")
#                        2.5 %     97.5 %
# mutual             0.5189490  1.6565678
# edges             -1.8222775 -1.2372315
# triangle           0.1092005  0.3229077
# nodematch("male") -0.4343255  0.2584731