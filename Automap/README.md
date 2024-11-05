# Automap script to detect Runs of Homozygosity (RoH) in VCF files using the Automap tool 
We can then cross reference homozygous variants of interest with RoH to see if they align, either adding supporting evidence to a variant or deprioritising a variant


Publication: AutoMap is a high performance homozygosity mapping tool using next-generation sequencing data

Available at: https://www.nature.com/articles/s41467-020-20584-4


Tools required to run package:

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


This Bash script, named AutoMap, facilitates the analysis of variant call format (VCF) files for the detection of regions of homozygosity (ROH) in genomic data. It begins by checking the versions of necessary tools like bcftools, bedtools, Perl, and R. After parsing user-defined command-line arguments, it validates the input parameters and files. If multiple VCF files are provided, it checks if they are single-sample VCFs and then processes each sample individually. The script filters variants based on quality metrics like read depth (DP), allele balance, and variant calling confidence. It also handles X chromosome analysis and computes ROH regions with sliding windows, trimming, and optional extension. Finally, it generates graphical outputs and text reports summarizing the identified ROH regions, considering parameters such as minimum size, variants, and percentage threshold. If multiple VCFs are provided, it computes common ROH regions across all samples.


# Step 2: Cross referencing variants
2 dataframes as input:
                    1. Automap output
                    2. Suspected homozygous variants in patients 

Script to cross reference (crossref_automap_homo.py) uses pandas and so is written in python - executed within a conda environment.

Note: other cross reference scripts have been uploaded, there were scripts written to understand the process.

