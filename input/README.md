## Schema
- id.exposure: str -> ID of exposure/risk factor 
- id.outcome: str -> ID of outcome
- outcome: str -> outcome label || outcome id
- exposure: str -> exposure label || exposure id
- method: str ->  MR analysis method
- nspn: int -> number of SNPs used as instruments
- b: float -> causal estimate (beta)
- s: float -> standard error
- pval: float -> p-value

## Credit
Simple Mendelian Randomisation analysis file produced with [TwoSampleMR ](https://mrcieu.github.io/TwoSampleMR/articles/introduction.html).
