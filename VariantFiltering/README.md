
# Variant Filtering 

All filtering conducted in R studio and scripts written under the guidance of Alan Pittman.

## Purpose

To prioritise variants called from whole exome sequencing. Owing to consanguinity of families studies, recessive variants were suspected to be disease causing in most families. Therefore, prioritisation identified recessive single nucleotide variants. However, a brief analysis of heterozygous and compound heterozygous variants was conducted. 

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


This R script begins by setting the working directory and loading necessary libraries, including tidyverse. It connects to an SQLite database containing exome sequencing data. The script defines a list of variant consequence criteria and a minor allele frequency (MAF) threshold for filtering variants. It then queries the variant_data table to select variants meeting these criteria. Additional filtering is performed to exclude variants with a CADD score below 20. The script removes high-frequency variants within both the specific cohort and a larger exome cohort. It reopens the database connection to load genotype data, which is then pivoted to long format for easier analysis. The variant and genotype data are joined, and the script filters for homozygous and heterozygous variants separately, removing any rows with missing data. Finally, the filtered variants are exported to Excel files. The script includes additional commented-out code for further filtering and analysis, such as removing benign clinical significance annotations and examining categories within data columns.


### Compound Heterozygous Script:

R_Filter_Script_Ella_CompoundHet.R

Author: Ella Whittle

This script written used to identify heterozgous compound variants within individuals.

### Splice Variant Script:

R_Filter_Script_Ella_SpliceVariants.R

Author: Ella Whittle 

This script was written to identify splicing variants within individuals.

