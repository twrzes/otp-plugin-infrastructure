# install.packages("TwoSampleMR", repos = c("https://mrcieu.r-universe.dev", "https://cloud.r-project.org"))
# Import packages
library(TwoSampleMR)
library(tidyr)
library(arrow)
library(dplyr)
library(httr)
library(jsonlite)
library(stringr)
library(jsonlite)


# Helper function to retrieve EFO associated with a study. 
# BUG: Only keeps the first EFO term but it is sufficient for demonstration purposes.
get_study_efo <- function(study_id) {

  # Build query string to get general information about AR and genetic constraint and tractability assessments 
  query_string = "
  query StudyTrait($studyId: String!) {
  studies(studyId: $studyId) {
    count
    rows {
      id
      diseases {
        id
        name
      }

    }
  }
}
"

# Set base URL of GraphQL API endpoint
base_url <- "https://api.platform.opentargets.org/api/v4/graphql"

# Set variables object of arguments to be passed to endpoint
variables <- list("studyId" = study_id)

# Construct POST request body object with query string and variables
post_body <- list(query = query_string, variables = variables)

# Perform POST request
r <- POST(url=base_url, body=post_body, encode='json')

# Check request status
if (r$status_code != 200) {
  stop(paste("Request failed with status code", r$status_code))
}

# Add the trait EFO id
# TODO: This could be more robust, quick and dirty way of accessing the value.
trait_id <- content(r)$data$studies$rows[[1]]$diseases[[1]]$id
return(trait_id)

}


# Re-write the data selection and MR calcualtion to return a df
generate_mr_analysis <- function(exposure_study_id, outcome_study_id){
  # Get instruments
  exposure_dat <- extract_instruments(exposure_study_id)
  
  # Get effects of instruments on outcome
  outcome_dat <- extract_outcome_data(snps = exposure_dat$SNP, outcomes = outcome_study_id)
  
  # Harmonise the exposure and outcome data
  dat <- harmonise_data(exposure_dat, outcome_dat)
  
  # Perform MR
  res <- mr(dat)
  
  # Generate OR and 95% CI
  res_odds <- generate_odds_ratios(res)
  return(res_odds)
}


clean_mr_analysis <- function(res_df){
  # Slice the study ids' relevant id
  res_mutate <- res_df %>%
    mutate(exposure_study_id=str_split_i(id.exposure, "-", -1)) %>%
    mutate(outcome_study_id=str_split_i(id.outcome, "-", -1))  %>%
    # Clean the label
    mutate(exposure_label=str_split_i(exposure, " \\|\\| id:", 1)) %>%
    mutate(outcome_label=str_split_i(outcome, " \\|\\| id:", 1))
  
  # Get the study's efo
  # TODO: This calls the API an unnecessary number of times
  res_efo_annot <- res_mutate %>%
    mutate(exposure_efo_id=sapply(exposure_study_id, get_study_efo)) %>%
    mutate(outcome_efo_id=sapply(outcome_study_id, get_study_efo))
  
  # Remove and relocate columns
  res_final <- res_efo_annot %>%
    select(!c(id.exposure, id.outcome, exposure, outcome, lo_ci, up_ci)) %>%
    relocate(exposure_study_id, outcome_study_id, exposure_label, outcome_label,
             exposure_efo_id, outcome_efo_id, method, nsnp, b,se,pval, or, or_lci95, or_uci95)
  
  return(res_final)
}

write_mr_analysis <- function(results_df, exposure_title, outcome_title){
  # Write to json
  filename <- paste0(exposure_title, "_", outcome_title, ".ndjson")
  stream_out(results_df, file(paste0("output/", filename)))
}