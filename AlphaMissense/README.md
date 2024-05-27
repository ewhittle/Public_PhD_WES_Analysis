# AlphaMissense was used to predict pathogenicity of all variants called in my cohort using the model developed be AlphaMissense

Publication: Accurate proteome-wide missense variant effect prediction with AlphaMissense
Avilable: https://www.science.org/doi/10.1126/science.adg7492


# Part 1: Run AlphaMissense plugin in VEP

## To run on STATS3:
## Step 1: Set up
VEP installation using installation guide (author: Constance Maurer): https://www.notion.so/VEP-65a9a2ca4a7c4bc9884752024e608bfe?pvs=4

Directory locations:
VEP environment: /homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/Tools/VEP_setup

Cache directory: /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_resources/GRCh38/vep

Alphamissense file and tab version: 
/homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/alphamissense

Plug ins:
/apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_resources/GRCh38/vep/Plugins/

Input file:
1.	/apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf
2. /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf


## Step 2: Presteps to running


Activate conda environment (created in VEP set up):
conda activate vep-sgul-env

Extra conda packages to install:
1.	pip install bgzip
2.	conda install -c bioconda tabix
3.	conda install -c bioconda perl-dbi


Download alpha sense file and tab it:
1.	Download – see above
2.	Use tabix to index: tabix -s 1 -b 2 -e 2 -f -S 1 AlphaMissense_hg38.tsv.gz

Unzip input vcf file:
1.	bgzip -d Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz


## Step 3: Run AlphaMissense 

Paste command straight into terminal shell...

$ vep --cache --dir_cache /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_resources/GRCh38/vep/ --dir_plugins /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_resources/GRCh38/vep/Plugins/ --plugin AlphaMissense,file=/homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/alphamissense/AlphaMissense_hg38.tsv.gz --species homo_sapiens --input_file /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf --force_overwrite --vcf --output_file /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf_alphamissense.vcf --stats_file /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output/statssummary2.html


# Part 2: Manipulation of VEP AlphaMissense output file

## Step 1: Find out column headers of file 

To find out column headers of output vep vcf file create a new conda environment for bcftools specifically (conda create --name bcftools), as running bcftools in the vep-sgul-env conda environment didn’t work, and install bcftools (conda install -c bioconda bcftools). Now runs and code to get column headers below:

$ bcftools +split-vep -l /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf_alphamissense.vcf > /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output/available_fields2.txt

VEP Column headers:
0       Allele
1       Consequence
2       IMPACT
3       SYMBOL
4       Gene
5       Feature_type
6       Feature
7       BIOTYPE
8       EXON
9       INTRON
10      HGVSc
11      HGVSp
12      cDNA_position
13      CDS_position
14      Protein_position
15      Amino_acids
16      Codons
17      Existing_variation
18      DISTANCE
19      STRAND
20      FLAGS
21      SYMBOL_SOURCE
22      HGNC_ID
23      am_class
24      am_pathogenicity

## Step 2: Convert VEP output into a flat table 
This is an intermediate step between VCF file and SQL database and uses the determined column headers specified in the previous command to accurately manipulate the data.

$ bcftools +split-vep /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf_alphamissense.vcf -d -s worst -f '%CHROM %POS %REF %ALT %Allele %Consequence %IMPACT %SYMBOL %Gene %Feature_type %Feature %BIOTYPE %EXON %INTRON %HGVSc %HGVSp %cDNA_position %CDS_position %Protein_position %Amino_acids %Codons %Existing_variation %DISTANCE %STRAND %FLAGS %SYMBOL_SOURCE %HGNC_ID %am_class %am_pathogenicity\n' -A 'space' >> /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output/Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf_alphamissense_flattable.txt

## Step 3: Convert flat table into SQL database 

In order to manipulate the table in R Studio, the flat table must be converted into a SQL table within an SQL database. The code is uploaded in the file 'sqlconversion.py'. It must be run within the pythonenv conda environment. Once run, the analysis can be transitioned to R and analysed using the script ''. 

