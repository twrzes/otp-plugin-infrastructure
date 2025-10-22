# Execute helper functions
source("./src/helpers.R")


# Get api key
# Using TwoSampleMR requires authentication. Follow: https://mrcieu.github.io/ieugwasr/articles/guide.html#authentication
# API key is stored in .Renviron
Sys.getenv("R_ENVIRON_USER")


# Producing examples

# Example 1 
# BMI vs CHD
exposure_study_id = "ebi-a-GCST90095039"
outcome_study_id = "ebi-a-GCST005195" 
mr_1 = generate_mr_analysis(exposure_study_id = exposure_study_id, outcome_study_id = outcome_study_id)
mr_1_clean = clean_mr_analysis(mr_1)
write_mr_analysis(mr_1_clean, "BMI", "CHD")

# Example 2
# bread
# Height
exposure_study_id = "ebi-a-GCST90096904"
outcome_study_id = "ebi-a-GCST90018959" 
mr_2 = generate_mr_analysis(exposure_study_id = exposure_study_id, outcome_study_id = outcome_study_id)
mr_2_clean = clean_mr_analysis(mr_1)
write_mr_analysis(mr_2_clean, "Bread", "Height")

# Example 3
# Education
# Dementia-related disorder
exposure_study_id = "ebi-a-GCST90029013"
outcome_study_id = "ebi-a-GCST90001390" 	
mr_3 = generate_mr_analysis(exposure_study_id = exposure_study_id, outcome_study_id = outcome_study_id)
mr_3_clean = clean_mr_analysis(mr_3)
write_mr_analysis(mr_3_clean, "Education", "Dementia")

# Example 4
# Sleep  	
# Cognitive function
exposure_study_id = "ebi-a-GCST003839"
outcome_study_id = "ebi-a-GCST006572" 	
mr_4 = generate_mr_analysis(exposure_study_id = exposure_study_id, outcome_study_id = outcome_study_id)
mr_4_clean = clean_mr_analysis(mr_4)
write_mr_analysis(mr_4_clean, "sleep_duration", "cognitive_performance")








