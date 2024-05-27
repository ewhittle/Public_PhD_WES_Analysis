# Public_PhD_WES_Analysis
This repository includes a selection of code used in my PhD project to investigate the genetic basis of neurodevelopmental disorders. Non available code has to remain private due to confidentiality issues. Code has been written by myself (Ella Whittle) unless otherwise specified. 

# Problem Statement

What are the unknown genetic pathological mechanisms underlying neurodevelopmental disease?

# Goals

1. Determine the genetic causes of previously unstudied cohorts with neurodevelopmental disorder.
2. Identify variants within candidate novel disease genes.
3. Confirm pathogenicity of genetic variants and elucidate pathological disease mechanism thereby increasing our understanding of neurodevelopmental disease.
4. Focus on novel findings within mitochondrial genes
     - There is a shared genetic background between mitochodnrial and neurodevelopmental disorders
     - Treatments and diagnosis of mitochondrial disease is challenged by genetic and phenotypic heterogeniety plus an incomplete knowledge of pathological mechanisms.

# Methodology Overview

1. Conduct whole exome sequencing on a cohort of genetically undiagnosed patients with neurodevelopmental disease.
2. Prioritise likely pathogenic variants within individuals.
3. Conduct functional characterisation of novel disease genes (not covered here).
4. Report findings in research publications (not covered here).

# Data Collection

For the cohort of indiviuals studies, a collaborating clinician recruited patients and provided blood samples for whole exome sequencing. Ethical consent was obtained.
In total, 188 individuals were recruited for this study; all individuals were paediatric and, for the majority, born from consanguineous marriages. 
Exchange of data and patient material was enacted under a material transfer agreement code.
To further investigate candidate novel disease genes, cohorts were expanded via GeneMatcher (https://genematcher.org/).

# Data Preparation and Processing

Patient genomic samples were predominantly sequenced via Macrogene on the NovaSeq exome sequencing platform, alternatively samples were sequenced via NovoGene on the HiSeq platform. 

Raw whole exome sequencing data was processed by myself through computational pipeline built by my colleagues Dr Alan Pittman and Dionysis Grigoriadis. 

The pipeline follows GATK best practices. 

An overview of our pipeline stages is shown below:
![image](https://github.com/ewhittle/PhD-script-inventory/assets/80473064/79a52ca3-9a12-4584-8229-810df0047c22)

# Variant Prioritisation Strategy

Variant prioritisation was conducted by myself and completed mainly using R. 

My strategy is outlined below:
![image](https://github.com/ewhittle/PhD-script-inventory/assets/80473064/ecc38f47-3521-4c8d-825e-009c39f06031)

# Contents of Repository

## AlphaMissense
Author: Step 1 and 2 Constance Maurer, Step 3 and Part 2 Ella Whittle 

Purpose: install and use of AlphaMissense software to variants called within whole exome sequencing data 

## Automap
Author: Ella Whittle 

Purpose: Use of Automap software to detect Runs of Homozygosity within whole exome sequencing data. Particularly relevant as I am investigating probands with consangiuneous parents and likely enrichment of recessive variants. 

## Variant Filtering
Author: Ella Whittle

Purpose: R scripts to filter whole exome sequencing data for single nucleotide, compound heterozygous and splicing variants. 

## Contact

Ella Whittle m2007653@sgul.ac.uk 

## Quick Acknowledgments and Thanks

Thank you to my computational colleagues at St George's University of London for their guidance and support over the course of this project.

A huge thank you to all the open source resources made available for this project.

Finally, and most importantly, thank you to the patients who  have participated in this research project. 
