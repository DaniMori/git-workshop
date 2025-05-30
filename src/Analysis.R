## ----packages----
library(here)
library(readr)
library(dplyr)
library(forcats)
library(stringr)
library(tidyr)
library(labelled)
# library(gtsummary) ## TODO: Un comment (& install {gtsummary} if necessary)
library(survival)

## ----config----

# Set working directory to the project root (reprodubibly):
here()

## ----main----

# Data preprocessing: ----

## Read dataset:
study_data <- read_csv(
  "dat/breslow_chatterjee_1999.csv",
  col_types      = cols(
    instit       = col_factor(),
    histol       = col_factor(),
    stage        = col_factor(levels = as.character(1:4), ordered = TRUE),
    study        = col_factor(),
    in.subcohort = col_logical(),
    .default     = col_integer()
  )
)

## Recode values:
study_data <- study_data |> mutate(
  instit = instit |>
    factor(levels = 1:2, labels = c("Favourable", "Unfavourable")),
  histol = histol |>
    factor(levels = 1:2, labels = c("Favourable", "Unfavourable")),
  stage  = stage  |>
    factor(levels = 1:4, labels = c('I', 'II', 'III', 'IV'))
)

## Assign labels:
# (see https://www.rdocumentation.org/packages/survival/versions/3.5-5/topics/nwtco
#   for more info):
study_data <- study_data |> set_variable_labels(
  instit = "Histology (from local institution)",
  histol = "Histology (from central lab)",
  stage  = "Disease stage",
  study  = "Study",
  rel    = "Relapse", # As a 0/1 integer for compatibility with {survival}
  edrel  = "Time to relapse (days)",
  age    = "Age (months)"
  ## TODO: Transform `edrel` and `age` to years?
)


## Filter only cases in the example in Breslow & Chatterjee (1999):
study_data <- study_data |>
  filter(in.subcohort)   |>
  select(-in.subcohort)


# Descriptive analysis: ----

# NOTE: Descriptives not computed, as `gtsummary` package is too heavy

## Create descriptive statistics table:
## TODO: Uncomment next line if using {gtsummary}
# descriptive_table <- study_data |> tbl_summary(include = -seqno)

## Create contingency table of the histologies:
## TODO: Uncomment next line if using {ºgtsummary}
# contingency_table <- study_data |> tbl_cross(row = instit, col = histol)


# Statistical modeling and inference: ----

survival_fit <- coxph(Surv(edrel, rel) ~ histol + instit, data = study_data)
## TODO: Add covariates?

# survival_coef_table <- survival_fit |> tbl_regression()
## TODO: Uncomment if using {gtsummary}
