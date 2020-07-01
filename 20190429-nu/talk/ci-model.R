library(ergmito)
library(texreg)
library(magrittr)

suffix <- "leader"
load(sprintf("data/model_data_%s.rda", suffix))


# Covariate models -------------------------------------------------------------

ergmitos_covariates <- list()
for (variable in c("Female", "Age", "NoReligion", "nonwhite", "GPA")) {
  
  # Keeping the ones we can use
  networksf <- networks
  if (variable %in% names(miss))
    networksf <- networksf[ setdiff(names(networks), miss[[variable]]) ]
  
  for (term in c("nodematch", "nodeicov", "nodeocov")) {
    
    # Writing the model
    m <- as.formula(sprintf("networksf ~ edges + %s(\"%s\")", term, variable))
    
    name <- paste0(term,"_",variable)
    # Estimating and saving
    ergmitos_covariates[[name]] <- ergmito(m, maxNumChangeStatVectors = 2^20)
    
    message("Model ", name, " done.")
  }
  
}

saveRDS(ergmitos_covariates, sprintf("model/ergmitos_%s_covariates.rds", suffix))
htmlreg(ergmitos_covariates, sprintf("model/ergmitos_%s_covariates.html", suffix))

# Structural terms models ------------------------------------------------------
ergmitos_structural_terms <- list()

for (term in c("mutual", "balance", "triangle", "ttriad", "ctriad")) {
  
  # Writing the model
  m <- as.formula(sprintf("networks ~ edges + %s", term))
  
  # Estimating and saving
  ergmitos_structural_terms[[term]] <- ergmito(m, maxNumChangeStatVectors = 2^20)
  
  message("Model ", term, " done.")
}

saveRDS(ergmitos_structural_terms, sprintf("model/ergmitos_%s_structural_terms.rds", suffix))
htmlreg(ergmitos_structural_terms, sprintf("model/ergmitos_%s_structural_terms.html", suffix))

# Level 2 models ---------------------------------------------------------------

ergmitos_psych <- list()
for (variable in c("RME", "FLAbRel", "SI3Fac1", "SI3Fac2", "SI3Fac3")) {
  
  # Keeping the ones we can use
  networksf <- networks
  if (variable %in% names(miss))
    networksf <- networksf[ setdiff(names(networks), miss[[variable]]) ]
  
  for (term in c("nodematch", "nodeicov", "nodeocov")) {
    
    # Writing the model
    m <- as.formula(sprintf("networksf ~ edges + %s(\"%s\")", term, variable))
    
    name <- paste0(term,"_",variable)
    # Estimating and saving
    ergmitos_psych[[name]] <- ergmito(m, maxNumChangeStatVectors = 2^20)
    
    message("Model ", name, " done.")
  }
  
}

saveRDS(ergmitos_psych, sprintf("model/ergmitos_%s_psych.rds", suffix))
htmlreg(ergmitos_psych, sprintf("model/ergmitos_%s_psych.html", suffix))

# Joint struct + other ---------------------------------------------------------

# Including structures for sure
ergmito_struct_and_significant <- list()
ergmito_struct_and_significant[["struct_RME"]] <- ergmito(
  networks ~ edges + ttriad + nodeicov("RME")
)

# Still significant
networksf <- networks[setdiff(names(networks), miss$Female)]
ergmito_struct_and_significant[["struct_Female"]] <- ergmito(
  networksf ~ edges + ttriad + nodeocov("Female")
)

# Still significant
networksf <- networks[setdiff(names(networks), miss$GPA)]
ergmito_struct_and_significant[["struct_GPA"]] <- ergmito(
  networksf ~ edges + ttriad + nodeocov("GPA")
)

# Still significant
ergmito_struct_and_significant[["struct_SI3Fac1"]] <- ergmito(
  networks ~ edges + ttriad + nodeocov("SI3Fac1")
)

# Confounded
ergmito_struct_and_significant[["struct_SI3Fac3"]] <- ergmito(
  networks ~ edges + ttriad + nodematch("SI3Fac3")
)


saveRDS(ergmito_struct_and_significant, sprintf("model/ergmito_%s_struct_and_significant.rds", suffix))
htmlreg(ergmito_struct_and_significant, sprintf("model/ergmito_%s_struct_and_significant.html", suffix))

# Final final ------------------------------------------------------------------
ergmito_final <- list()

if (suffix == "leader") {
  
  ergmito_final[["T. Triad"]] <- ergmito(
    networks ~ edges + nodeicov("female"), maxNumChangeStatVectors = 2^20)
  
} else if (suffix == "influence") {
  
  ergmito_final[["T. Triad"]] <- ergmito(
    networks ~ edges + ttriad, maxNumChangeStatVectors = 2^20)
  
} else if (suffix == "advice") {
  ergmito_final[["nodeicov(RME)"]] <- ergmito(
    networks ~ edges + ttriad + nodeicov("RME"), maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["nodematch(RME)"]] <- ergmito(
    networks ~ edges + ttriad + nodematch("RME"), maxNumChangeStatVectors = 2^20)
  
  networksf <- networks[setdiff(names(networks), miss$Female)]
  ergmito_final[["nodeocov(Female)"]] <- ergmito(
    networksf ~ edges + ttriad + nodeocov("Female"), maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["nodeocov(SI3Fac1)"]] <- ergmito(
    networks ~ edges + ttriad + nodeocov("SI3Fac1"), maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["nodeocov(SI3Fac2)"]] <- ergmito(
    networks ~ edges + ttriad + nodeocov("SI3Fac2"), maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["nodematch(SI3Fac3)"]] <- ergmito(
    networks ~ edges + ttriad + nodematch("SI3Fac3"), maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["RME+Female"]] <- ergmito(
    networksf ~ edges + ttriad + nodeicov("RME") + nodeocov("Female"),
    maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["RME+SI3Fac1"]] <- ergmito(
    networks ~ edges + ttriad + nodeicov("RME") + nodeocov("SI3Fac1"),
    maxNumChangeStatVectors = 2^20)
  
  ergmito_final[["RME+Female+SI3Fac1"]] <- ergmito(
    networksf ~ edges + ttriad + nodeicov("RME") + nodeocov("Female") + nodeocov("SI3Fac1"),
    maxNumChangeStatVectors = 2^20)
  
  networksf <- networks[setdiff(names(networks), miss$Female)]
  ergmito_final[["All"]] <- 
    ergmito(networksf ~ edges + ttriad +
              nodeicov("RME") +
              nodematch("RME") +
              nodeocov("Female") +
              nodeocov("SI3Fac1") +
              nodeocov("SI3Fac2") +
              nodematch("SI3Fac3"),
            maxNumChangeStatVectors = 2^20)
}



# Not significant  
saveRDS(ergmito_final, sprintf("model/ergmito_%s_final.rds", suffix))
htmlreg(ergmito_final, sprintf("model/ergmito_%s_final.html", suffix))



#                        2.5 %     97.5 %
# mutual             0.5189490  1.6565678
# edges             -1.8222775 -1.2372315
# triangle           0.1092005  0.3229077
# nodematch("male") -0.4343255  0.2584731