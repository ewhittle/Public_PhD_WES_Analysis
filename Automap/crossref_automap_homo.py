#!/usr/bin/env ./venv/bin/python3

##script to cross reference suspected homozygous variants identified in individuals with runs of homozygosity called in individuals by automap
##Ella Whittle Sep 2023
##remember to activate conda environment first
##conda activate pythonenv
##run in command line as: python3 crossref_automap_homo.py

import os
import pandas as pd

print('script started')

#read in files
df = pd.read_csv('am_combined_output.csv')
homovar = pd.read_excel('suspected_homo_variants.xlsx', sheet_name='Sheet1')

print('files converted to dataframes')

# Merge DataFrames on 'ID'
merged_df = pd.merge(df, homovar, on='ID', how='inner')

print("dataframes merged")

#to test that the merged dataframe included all data in a way to allow the filtering crtiera to be applied
#merged_df.to_csv('/homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/Automap_out/test.csv', index=False)

# Filter rows based on the condition
result = merged_df[(merged_df['POS'] >= merged_df['Begin']) & (merged_df['POS'] <= merged_df['End']) & (merged_df['#Chr'] == merged_df['CHROM'])]

print("variants filtered to include only those within homozygous regions")

result.to_csv('/homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/Automap_out/variants_in_homoregion.csv', index=False)

print("result file written to csv in Automap_out directory")
print("script complete!")
