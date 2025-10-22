# otp-plugin-infrastructure
OTP Plugin Infrastructure - Open Targets Hackathon 2025

## Objective
**To Develop a modular plugin architecture within the OTP to integrate user-specific datasets and visualisations**

*We have generated mock Mendelian Randomisation analysis data to showcase the new feature. 
This is meant for local installations of OTP only. 

## Highlights
- Implemented new infrastructure to enable custom Plugin widgets in the Profile page
- Users can upload their own data json datasets and visualise them in tabular format or as a forest plot 

## Resources 
### Implementation
We modified the following repos 
[ot-ui-apps-otp-plugin-infrastructure](https://github.com/fedde-s/ot-ui-apps-otp-plugin-infrastructure) & [ot-platform-api-otp-plugin-infrastructure](https://github.com/fedde-s/ot-platform-api-otp-plugin-infrastructure) which correspond to OT's [UI](https://github.com/opentargets/ot-ui-apps) and the [API](https://github.com/opentargets/platform-api) repos. 

### Data Generation
To produce the mock MR data we used the R scripts found in the `src` directory. 










