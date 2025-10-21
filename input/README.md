## Schema

- **exposure_study_id**: str -> Exposure study ID from GWAS catalog
- **outcome_study_id**: str -> Outcome study ID from GWAS catalog
- **exposure_label**: str -> Exposure EFO label annotated in the exposure study
- **outcome_label**: str -> Outcome EFO label annotated in the outcome study
- **exposure_efo_id**: str -> Exposure EFO id annotated in the exposure study
- **outcome_efo_id**: str -> Outcome EFO id annotated in the outcome study
- **method**: str ->  MR analysis method
- **nspn**: int -> number of SNPs used as instruments
- **b**: float -> causal estimate (beta)
- **s**: float -> standard error
- **pval**: float -> p-value

## Credit
Simple Mendelian Randomisation analysis file produced with [TwoSampleMR ](https://mrcieu.github.io/TwoSampleMR/articles/introduction.html).
