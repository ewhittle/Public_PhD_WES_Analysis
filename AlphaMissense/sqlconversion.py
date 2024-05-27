#!/usr/bin/env ./venv/bin/python3

##script to convert flat txt table into a SQL dataframe
##Ella Whittle Sep 2023
##remember to activate conda environment first
##conda activate pythonenv
##run in command line as: python3 sqlconversion.py

#directory to run: /apittman-aramis/sgul/shares/aramis/ewhittle/alphamissense/vep_output

print('script started')
print('importing pandas and sqlite3')

import pandas as pd
import sqlite3

print('reading in text file...')

#Read text file using pandas
df_alphamissense_sql = pd.read_csv('Joint_call_Ella_NDD_IR_July_2023.joint-called_split.vcf.gz.anno.P2.vcf_alphamissense_flattable.txt', sep=' ', low_memory=False)
print('flat table read into pandas dataframe')

df_alphamissense_sql.columns = ['CHROM', 'POS', 'REF', 'ALT', 'Allele', 'Consequence', 'IMPACT', 'SYMBOL', 'Gene', 'Feature_type', 'Feature', 'BIOTYPE', 'EXON', 'INTRON', 'HGVSc', 'HGVSp', 'cDNA_position', 'CDS_position', 'Protein_position', 'Amino_acids', 'Codons', 'Existing_variation', 'DISTANCE', 'STRAND', 'FLAGS', 'SYMBOL_SOURCE', 'HGNC_ID', 'am_class', 'am_pathogenicity']
print('column headers added')

print('connecting to database...')
#Connect to a database - create an empty sql database
conn = sqlite3.connect('alphamissense_sql.db')
print('SQL connection created')

#Save pandas dataframe into SQL database
df_alphamissense_sql.to_sql('vcf_alphamissense_sql', conn, if_exists='replace', index=False)
print('dataframe converted to SQL')

#describe summary data of table
cursor = conn.cursor()
#should list tables
print('listing tables..')
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor.fetchall()
print("Tables in the database:")
for table in tables:
    print(table[0])

#should describe table structure
print('describing table structure..')
cursor.execute("PRAGMA table_info(vcf_alphamissense_sql);")
table_info = cursor.fetchall()
print("\nTable Structure of your_table:")
for col in table_info:
    print(col[1], col[2])

#show sample of table
cursor.execute("SELECT * FROM vcf_alphamissense_sql LIMIT 5;")
sample_data = cursor.fetchall()
print("\nSample Data from your_table:")
for row in sample_data:
    print(row)

#to get column names of table
cursor.execute("PRAGMA table_info(vcf_alphamissense_sql);")
columns = cursor.fetchall()
print("Column Names:")
for column in columns:
    print(column[1])

conn.close()

print('Script finished')

exit
exit
