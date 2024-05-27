#!/usr/bin/env ./venv/bin/python3

##script to combine automap output files into one dataframe and cross reference this with homozygous variants identified in individuals
##Ella Whittle Sep 2023
##remember to activate conda environment first
##conda activate condaenvname

import os
import pandas as pd

# Step 1: Extract Directory Name
directory_name = os.path.basename(os.path.dirname('/homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/Automap_out/RM032/'))

# Step 2: Create DataFrame 
df = pd.read_csv('/homes/homedirs-pg-research/sghms/student/users/m2007653/Iranian_ES/Automap_out/RM032/RM032.HomRegions.tsv', skipfooter=4, sep="\t")

# Step 3: Add Directory Name as a Column
df.insert(0, 'ID', directory_name)

# Print the modified DataFrame
print(df.head())
