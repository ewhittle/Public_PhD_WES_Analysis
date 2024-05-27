# Automap script to detect Runs of Homozygosity (RoH) in VCF files using the Automap tool 
We can then cross reference homozygous variants of interest with RoH to see if they align, either adding supporting evidence to a variant or deprioritising a variant


Publication: AutoMap is a high performance homozygosity mapping tool using next-generation sequencing data

Available at: https://www.nature.com/articles/s41467-020-20584-4


Tools requireed to run package:

bcftools higher or equal to v1.9

bedtools higher or equal to v2.24.0

perl higher or equal to v5.22.0

R higher or equal to v3.2.0


Note: Conda packages on Stats3 are not updated enough versions and so cannot use. Versions have been updated manually.

Script to collect VCF files and index files to be used for automap: fetch_VCF2_AP.bash

# Step 1: Running Automap
bash script
Executable directory: /homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/VCF_files
Full script with all sample names saved in AutoMap_script.txt file then copy and pasted into terminal whilst in bash and executed.
This script calls in the prewritten (published) automap script - AutoMap_v1.2.sh

# Step 2: Cross referencing variants
2 dataframes as input:
                    1. Automap output
                    2. Suspected homozygous variants in patients 

Script to cross reference (crossref_automap_homo.py) uses pandas and so is written in python - executed within a conda environment.

Note: other cross reference scripts have been uploaded, there were scripts written to understand the process.

