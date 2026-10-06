# BIOL8230
Macroevolutionary Methods


### Data

jbi14547-sup-0003-appendixs3 "Aus_Sphen_dataset"

#### Focal clades

Name | Limb-reduced genera included | Limbed representatives
--- | --- | ---
Anomalopus group| Anomalopus, Calyptotis, Coeranoscincus, Coggeria,  Ophioscincus |	Concinnia, Nangura, Silvascincus
Glaphyromorphus | Glaphyromorphus, Eulamprus | Glaphyromorphus, Eulamprus
Hemiergis | Hemiergis, Eremiascincus | Hemiergis, Eremiascincus
Lerista | Lerista, Ctenotus	| Lerista, Ctenotus |
Other | |


#### Descriptors in dataframe
Abbr | Description | Unit
--- | --- | ---
species | | *chr*
focal_clade | genera (or above) with at least 3 limb-reduced and 3 fully limbed representatives | *chr*
subfamily | *Sphenomorphinae*: Australian subfamily of skinks  | *chr*
substrate_category | classification of four categories from poorest to richest organic content ('sand' < 'sandy soil' < 'soil' < 'humus'), else non-fossorial species are 'terrestrial' | *chr*
man | number of fingers | *int*
pes	|  number of toes | *int*
disparity | value from -1 (sp. with only forelimbs) to 1 (sp. with only hindlimbs) | *num*
hd_l | head length | 
fll	| forelimb length |
hll	 | hindlimb length |
svl	| snout-vent length | mm
ps_vn | presacral vertebrae numbers | *int*
fl_presence | presence of front limbs | *binary*
hl_presence | presence of back limbs | *binary*
awc | available water capacity | %
bdw | bulk density of the whole soil | g/cm^3
cl_y | clay: <2um mass fraction of the soil | %
slt | silt: 2-20um mass fraction of the soil | %
sn_d | sand: 20um-2mm mass fraction of the soil | %
so_c | soil organic carbon
soil_temp | temperature | C
t | air temperature (1cm above soil) | C 
rain | rainfall | mm
soilmoist | | 
soilhum | | 
rh | soil relative humidity | %
soilwet | wetness index (2.5 cm in soil column) | %


#### Added field values
Abbr | Full name
--- | ---
lnHdL |	log head length
lnFLL	| log forelimb length
lnHLL	 | log hindlimb length
lnSVL	| log snout-vent length


#### References

Camaiti, M., Evans, A. R., Hipsley, C. A., Hutchinson, M. N., Meiri, S., de Oliveira Anderson, R., Slavenko, A., & Chapple, D. G. (2023). Macroecological and biogeographical patterns of limb reduction in the world's skinks. Journal of Biogeography, 50, 428–440. https://doi.org/10.1111/jbi.14547
