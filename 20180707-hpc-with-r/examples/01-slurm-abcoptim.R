# Include this to tell where everything will be living at
.libPaths("~/R/x86_64-pc-linux-gnu-library/3.4/")

# Default CRAN mirror from where to download R packages
options(repos =c(CRAN="https://cloud.r-project.org/"))

library(ABCoptim)

fun <- function(x) {
  -cos(x[1])*cos(x[2])*exp(-((x[1] - pi)^2 + (x[2] - pi)^2))
}

ans <- abc_optim(rep(0,2), fun, lb=-10, ub=10, criter=50)

saveRDS(
   ans,
   file = paste0(
      "~/hpc-with-r/examples/01-slurm-abcoptim-",
      Sys.getenv("SLURM_JOB_ID"),                 # SLURM ENV VAR
      "-",
      Sys.getenv("SLURM_ARRAY_TASK_ID"),          # SLURM ENV VAR
      ".rds"
))
