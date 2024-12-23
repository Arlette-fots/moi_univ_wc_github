#####preparation of the demodata for the MOI Univ WC###################

#senegal19_dta<- read_dta(here::here("data", "SNG_dta", "SNPR8BFL.DTA"))

senegal19_dta<- read_dta("data/SNG_dta/SNPR8BFL.DTA") 
questionr::lookfor( senegal19_dta, "disability")


demodata<- read_dta("data/SNG_dta/SNPR8BFL.DTA")  %>%  
  select( hhid:hv015,  hv021, hv022, hv024, hv025, hv035,  hv103, hv104, hv105, hv106, hv115, hv270, hc1, hc2, hc3, hc13, hc27, hc61, hc62, hc68, hc72, hc73) %>%  
  filter(hv103 == 1 & ( !is.na(hc1) & hc1 >= 0 & hc1 <= 59) & hc72 < 9990 )  %>% # fiter to defacto chidren aged between 0 to 59 and with valid measurement as stated by DHS
  mutate(
  cluster_number = hv001,
  household_sample_weight = hv005,
  wt = household_sample_weight / 1000000,
  psu = hv021,
  strata = hv022,
  region = hv024,
  type_place_residence = hv025,
  de_facto_resident = hv103,
  gender = hv104,
  age_mth = hc1,
  wealth_quintile = hv270,
  waisted=case_when(hc72 < -200 ~1,
                    hc72 >= -200 ~0)
  
  )

#testing commit and push
save(demodata, file="data/demodata/demodata.RData")
