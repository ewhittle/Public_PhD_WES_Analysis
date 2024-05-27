
# Variant Filtering 

All filtering conducted in R studio.

## Purpose

To prioritise variants called from whole exome sequencing. Owing to consanguinity of families studies, recessive variants were suspected to be disease causing in most families. Therefore, prioritisation identified recessive single nucleotide variants. However, a brief analysis of de novo and compound heterozygous variants was conducted. 

## To use scripts, the following are required:

#Load necessary libraries
install_packages <- function() {
  install.packages("tidyverse")
  install.packages("dplyr")
  install.packages("writexl")
  library(tidyverse)
  library(dplyr)
  library(writexl)
}

## Methodology

Post VEP annotation (final stage of raw processing of whole exome sequencing), SQL dataframes within databases were created and loaded into R for analysis. The scripts used to analyse these files are uploaded here. 

Variant prioritisation overview as follows:
![image](https://github.com/ewhittle/Public_PhD_WES_Analysis/assets/80473064/d56d98f7-d662-4b21-bed3-54fe510174f5)

## Contents

### General Filtering Script:

General_R_Filtering.R

Author: Ella Whittle

This script was used as base for all other filtering scripts developed.

### Compound Heterozygous Script:

R_Filter_Script_Ella_CompoundHet.R

Author: Ella Whittle

This script written used to identify heterozgous compound variants within individuals.

### Splice Variant Script:

R_Filter_Script_Ella_SpliceVariants.R

Author: Ella Whittle 

This script was written to identify splicing variants within individuals.

