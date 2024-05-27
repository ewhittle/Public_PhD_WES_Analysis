#set working directory to files window on session drop down
setwd("/homes/homedirs-pg-research/sghms/student/users/m2007653/R_Studio/Iranian_Exomes/July2023/Results")

install.packages("tidyverse")
library(tidyverse)
#tidyverse_update() #make sure tidyverse up to date
con <- DBI::dbConnect(RSQLite::SQLite(), 'Ella_NDD_July_2023_sqlite3.db')

#defining variant filter criteria:
#SQL databse tables: variant_data and genotype_data
MAF.threshold = 0.01
selected.consequences = c("non_coding_transcript_exon_variant",                                                                                           
                          "splice_region_variant&splice_polypyrimidine_tract_variant&intron_variant&non_coding_transcript_variant",                       
                          "splice_donor_variant&non_coding_transcript_variant",                                                                         
                          "missense_variant",                                                                                                             
                          "stop_gained",                                                                                                                  
                          "3_prime_UTR_variant",                                                                                                          
                          "downstream_gene_variant",                                                                                                      
                          "splice_donor_5th_base_variant&intron_variant&non_coding_transcript_variant",                                                   
                          "splice_donor_region_variant&intron_variant&non_coding_transcript_variant",                                                     
                          "splice_region_variant&non_coding_transcript_exon_variant",                                                                     
                          "splice_acceptor_variant&non_coding_transcript_variant",                                                                        
                          "mature_miRNA_variant",                                                                                                         
                          "splice_region_variant&intron_variant&non_coding_transcript_variant",                                                           
                          "upstream_gene_variant",                                                                                                        
                          "5_prime_UTR_variant",                                                                                                          
                          "frameshift_variant",                                                                                                           
                          "splice_donor_variant&splice_donor_5th_base_variant&coding_sequence_variant&intron_variant",                                    
                          "inframe_insertion",                                                                                                            
                          "splice_polypyrimidine_tract_variant&intron_variant",                                                                           
                          "splice_region_variant&splice_polypyrimidine_tract_variant&intron_variant",                                                                                                                                         
                          "splice_donor_variant",                                                                                                         
                          "splice_donor_region_variant&intron_variant",                                                                                   
                          "inframe_deletion",                                                                                                             
                          "missense_variant&splice_region_variant",                                                                                       
                          "splice_region_variant&intron_variant",                                                                                         
                          "missense_variant&NMD_transcript_variant",                                                                                                                                                                       
                          "splice_acceptor_variant",                                                                                                      
                          "splice_donor_5th_base_variant&intron_variant",                                                                                 
                          "3_prime_UTR_variant&NMD_transcript_variant",                                                                                   
                          "intron_variant&NMD_transcript_variant",                                                                                        
                          "splice_region_variant&5_prime_UTR_variant",                                                                                    
                          "frameshift_variant&splice_region_variant",                                                                                     
                          "splice_region_variant&3_prime_UTR_variant&NMD_transcript_variant",                                                             
                          "5_prime_UTR_variant&NMD_transcript_variant",                                                                                   
                          "stop_gained&splice_region_variant",                                                                                            
                          "stop_gained&NMD_transcript_variant",                                                                                           
                          "splice_donor_variant&NMD_transcript_variant",                                                                                  
                          "splice_region_variant&splice_polypyrimidine_tract_variant&intron_variant&NMD_transcript_variant",                              
                          "splice_acceptor_variant&splice_polypyrimidine_tract_variant&intron_variant",                                                   
                          "splice_polypyrimidine_tract_variant&intron_variant&NMD_transcript_variant",                                                    
                          "splice_donor_region_variant&intron_variant&NMD_transcript_variant",                                                            
                          "splice_region_variant&intron_variant&NMD_transcript_variant",                                                                  
                          "start_lost&NMD_transcript_variant",                                                                                            
                          "missense_variant&splice_region_variant&NMD_transcript_variant",                                                                
                          "start_lost",                                                                                                                   
                          "splice_acceptor_variant&NMD_transcript_variant",                                                                               
                          "stop_gained&frameshift_variant",                                                                                               
                          "inframe_insertion&splice_region_variant",                                                                                      
                          "splice_acceptor_variant&coding_sequence_variant&intron_variant",                                                               
                          "frameshift_variant&NMD_transcript_variant",                                                                                                                                                                                                                                                          
                          "splice_donor_5th_base_variant&intron_variant&NMD_transcript_variant",                                                          
                          "stop_lost&NMD_transcript_variant",                                                                                             
                          "stop_gained&frameshift_variant&splice_region_variant",                                                                         
                          "splice_acceptor_variant&5_prime_UTR_variant&intron_variant",                                                                   
                          "incomplete_terminal_codon_variant&coding_sequence_variant",                                                                    
                          "stop_lost",                                                                                                                    
                          "intergenic_variant",                                                                                                           
                          "regulatory_region_variant",                                                                                                    
                          "splice_acceptor_variant&splice_polypyrimidine_tract_variant&intron_variant&non_coding_transcript_variant",                     
                          "splice_region_variant&non_coding_transcript_variant",                                                                          
                          "protein_altering_variant",                                                                                                     
                          "frameshift_variant&stop_retained_variant",                                                                                     
                          "splice_region_variant&5_prime_UTR_variant&NMD_transcript_variant",                                                             
                          "splice_region_variant&3_prime_UTR_variant",                                                                                    
                          "inframe_deletion&splice_region_variant",                                                                                       
                          "splice_acceptor_variant&frameshift_variant",                                                                                   
                          "stop_lost&splice_region_variant&NMD_transcript_variant",                                                                       
                          "coding_sequence_variant",                                                                                                      
                          "splice_donor_variant&splice_donor_region_variant&coding_sequence_variant&intron_variant",                                      
                          "splice_donor_variant&splice_donor_region_variant&intron_variant&non_coding_transcript_variant",                                
                          "splice_donor_variant&splice_donor_5th_base_variant&intron_variant&non_coding_transcript_variant",                              
                          "non_coding_transcript_variant",                                                                                              
                          "inframe_deletion&NMD_transcript_variant",                                                                                      
                          "start_lost&splice_region_variant&NMD_transcript_variant",                                                                      
                          "splice_donor_variant&splice_donor_5th_base_variant&non_coding_transcript_exon_variant&intron_variant",                         
                          "splice_donor_variant&non_coding_transcript_exon_variant",                                                                      
                          "coding_sequence_variant&NMD_transcript_variant",                                                                               
                          "inframe_insertion&NMD_transcript_variant",                                                                                     
                          "frameshift_variant&start_lost&start_retained_variant",                                                                         
                          "start_lost&splice_region_variant",                                                                                             
                          "frameshift_variant&splice_region_variant&NMD_transcript_variant",                                                              
                          "start_lost&start_retained_variant&5_prime_UTR_variant",                                                                        
                          "stop_retained_variant&NMD_transcript_variant",                                                                                
                          "stop_gained&splice_region_variant&NMD_transcript_variant",                                                                     
                          "splice_donor_variant&splice_donor_5th_base_variant&5_prime_UTR_variant&intron_variant",                                        
                          "splice_acceptor_variant&non_coding_transcript_exon_variant&intron_variant",                                                    
                          "frameshift_variant&stop_lost",                                                                                                                                                                                   
                          "splice_donor_variant&5_prime_UTR_variant",                                                                                     
                          "splice_donor_variant&splice_donor_region_variant&5_prime_UTR_variant&intron_variant",                                          
                          "splice_donor_variant&splice_donor_region_variant&intron_variant&NMD_transcript_variant",                                       
                          "coding_sequence_variant&5_prime_UTR_variant",                                                                                  
                          "splice_acceptor_variant&coding_sequence_variant",                                                                              
                          "TF_binding_site_variant",                                                                                                      
                          "splice_polypyrimidine_tract_variant&splice_donor_region_variant&intron_variant&non_coding_transcript_variant",                 
                          "frameshift_variant&stop_lost&NMD_transcript_variant",                                                                          
                          "splice_donor_variant&splice_donor_5th_base_variant&intron_variant",                                                            
                          "splice_donor_variant&splice_donor_region_variant&intron_variant",                                                              
                          "splice_donor_variant&splice_donor_5th_base_variant&splice_polypyrimidine_tract_variant&intron_variant",                        
                          "transcript_ablation",                                                                                                          
                          "stop_gained&frameshift_variant&NMD_transcript_variant",                                                                        
                          "frameshift_variant&start_lost",                                                                                                
                          "splice_acceptor_variant&coding_sequence_variant&NMD_transcript_variant",                                                       
                          "start_lost&5_prime_UTR_variant&NMD_transcript_variant",                                                                        
                          "start_lost&5_prime_UTR_variant",                                                                                               
                          "splice_acceptor_variant&5_prime_UTR_variant",                                                                                  
                          "splice_donor_variant&3_prime_UTR_variant&NMD_transcript_variant",                                                              
                          "splice_acceptor_variant&coding_sequence_variant&intron_variant&NMD_transcript_variant",                                        
                          "splice_donor_variant&coding_sequence_variant",                                                                                 
                          "protein_altering_variant&NMD_transcript_variant",                                                                              
                          "stop_lost&3_prime_UTR_variant",                                                                                                
                          "splice_donor_variant&splice_donor_5th_base_variant&3_prime_UTR_variant&intron_variant&NMD_transcript_variant",                 
                          "splice_donor_variant&splice_donor_region_variant&non_coding_transcript_exon_variant&intron_variant",                           
                          "splice_acceptor_variant&non_coding_transcript_exon_variant",                                                                   
                          "splice_donor_variant&5_prime_UTR_variant&NMD_transcript_variant",                                                              
                          "start_lost&inframe_deletion",                                                                                                  
                          "inframe_insertion&splice_region_variant&stop_retained_variant&NMD_transcript_variant",                                         
                          "splice_acceptor_variant&splice_donor_variant&splice_donor_5th_base_variant&splice_polypyrimidine_tract_variant&intron_variant",
                          "splice_donor_variant&splice_donor_5th_base_variant&5_prime_UTR_variant&intron_variant&NMD_transcript_variant",                 
                          "splice_acceptor_variant&coding_sequence_variant&3_prime_UTR_variant&intron_variant",                                           
                          "stop_lost&3_prime_UTR_variant&NMD_transcript_variant",                                                                         
                          "splice_donor_variant&coding_sequence_variant&3_prime_UTR_variant",                                                             
                          "frameshift_variant&stop_retained_variant&NMD_transcript_variant",                                                              
                          "splice_acceptor_variant&splice_donor_region_variant&non_coding_transcript_exon_variant&intron_variant",                        
                          "stop_lost&splice_region_variant",                                                                                              
                          "stop_lost&inframe_deletion",                                                                                                   
                          "splice_acceptor_variant&splice_donor_5th_base_variant&coding_sequence_variant&intron_variant",                                 
                          "stop_gained&inframe_insertion",                                                                                                
                          "splice_acceptor_variant&splice_polypyrimidine_tract_variant&intron_variant&NMD_transcript_variant",                            
                          "splice_donor_5th_base_variant&frameshift_variant",                                                                             
                          "frameshift_variant&splice_region_variant&intron_variant",                                                                      
                          "stop_gained&protein_altering_variant",                                                                                         
                          "stop_gained&protein_altering_variant&splice_region_variant",                                                                   
                          "splice_donor_variant&splice_donor_5th_base_variant&3_prime_UTR_variant&intron_variant",                                        
                          "splice_donor_5th_base_variant&splice_polypyrimidine_tract_variant&intron_variant&NMD_transcript_variant",                      
                          "splice_donor_variant&splice_donor_region_variant&5_prime_UTR_variant&intron_variant&NMD_transcript_variant",                   
                          "splice_acceptor_variant&splice_donor_variant&splice_donor_5th_base_variant&coding_sequence_variant&intron_variant",            
                          "stop_retained_variant&3_prime_UTR_variant&NMD_transcript_variant",                                                             
                          "stop_gained&inframe_insertion&splice_region_variant",                                                                          
                          "inframe_insertion&incomplete_terminal_codon_variant&coding_sequence_variant",                                                  
                          "coding_sequence_variant&3_prime_UTR_variant",                                                                                  
                          "splice_acceptor_variant&5_prime_UTR_variant&NMD_transcript_variant",                                                           
                          "splice_donor_region_variant&non_coding_transcript_exon_variant",                                                               
                          "splice_acceptor_variant&3_prime_UTR_variant&intron_variant&NMD_transcript_variant",                                            
                          "frameshift_variant&splice_donor_region_variant",                                                                               
                          "inframe_insertion&stop_retained_variant",                                                                                      
                          "splice_region_variant&stop_retained_variant&NMD_transcript_variant",                                                           
                          "splice_acceptor_variant&splice_donor_variant&splice_donor_5th_base_variant&non_coding_transcript_exon_variant&intron_variant", 
                          "splice_donor_variant&splice_donor_region_variant&3_prime_UTR_variant&intron_variant&NMD_transcript_variant",                   
                          "splice_acceptor_variant&splice_donor_variant&splice_donor_5th_base_variant&5_prime_UTR_variant&intron_variant",                
                          "frameshift_variant&stop_lost&splice_region_variant",                                                                           
                          "protein_altering_variant&splice_region_variant",                                                                               
                          "splice_donor_variant&splice_donor_5th_base_variant&intron_variant&NMD_transcript_variant",                                     
                          "incomplete_terminal_codon_variant&coding_sequence_variant&3_prime_UTR_variant",                                                
                          "splice_acceptor_variant&splice_donor_5th_base_variant&3_prime_UTR_variant&intron_variant",                                     
                          "splice_acceptor_variant&3_prime_UTR_variant&intron_variant",                                                                   
                          "splice_acceptor_variant&3_prime_UTR_variant&NMD_transcript_variant",                                                           
                          "splice_acceptor_variant&coding_sequence_variant&3_prime_UTR_variant&intron_variant&NMD_transcript_variant",                    
                          "splice_donor_variant&stop_gained&frameshift_variant",                                                                          
                          "splice_acceptor_variant&splice_donor_5th_base_variant&splice_polypyrimidine_tract_variant&intron_variant",                     
                          "splice_acceptor_variant&splice_donor_variant&splice_donor_5th_base_variant&inframe_deletion&intron_variant",                   
                          "start_lost&splice_region_variant&5_prime_UTR_variant")
filtered.variants <- as_tibble(tbl(con, 'variant_data')) %>%
  filter(MAX_AF <= MAF.threshold | MAX_AF <= "."  ) %>%
  filter(Consequence %in% selected.consequences)
DBI::dbDisconnect(con)
#filtered.variants file is long format 

#Remove all variants with CADD below 20, include >20 and '.'
install.packages("dyplr")
library(dplyr)
filtered.variants.cadd <- filtered.variants %>%
  filter(filtered.variants$CADD_PHRED=='.' | as.numeric(filtered.variants$CADD_PHRED) >= 20.000)

#AC filtering - we want to remove any variants at high frequency as either common or artefacts from sequencing 
#2 AC columns - AC (count within our specific cohort) and SGUL_Exomes_AC (count within whole ES cohort)
#AC <10 included 
filtered.variants.cadd.AC <- filtered.variants.cadd %>%
  filter(as.numeric(filtered.variants.cadd$AC) <= 10.000)

filtered.variants.cadd.AC.SGULAC <- filtered.variants.cadd.AC %>%
  filter(as.numeric(filtered.variants.cadd.AC$SGUL_Exomes_AC) <= 20.000 | filtered.variants.cadd.AC$SGUL_Exomes_AC=='.')

rm(filtered.variants)
rm(filtered.variants.cadd)
rm(filtered.variants.cadd.AC)

#reopen connection to genotype database
con <- DBI::dbConnect(RSQLite::SQLite(), 'Ella_NDD_July_2023_sqlite3.db')
genotype_data_allsamples <- as_tibble(tbl(con, "genotype_data"))
DBI::dbDisconnect(con)

#2 tables at this point: 
#         1. genotype_data_allsamples (sample IDs + primary key)
#         2. filtered.variants.cadd.AC.SGULAC (filtered variants with all consequence columns + primary key)
#primary key common between 2 tables is: CHROM_POS_REF_ALT
#we want to pull all samples with a primary key that matches in each table so all variants are allocated to patient/patients

#genotype data is wide format but for data analysis long format is better
#variants table is already long format
#so first we pivot genotype table to long format before joining
#From Alan:
## identify first and last sample ID in table
First_sample <- colnames(genotype_data_allsamples)[7] #defines column 7 as first sample column - first 6 are "CHROM_POS_REF_ALT", "CHROM", "POS", "REF", "ALT", "ALLELE"
Last_sample <- colnames(genotype_data_allsamples)[length(colnames(genotype_data_allsamples))]
## pivot genotyppe data to 'long' format
geno.long.format <- genotype_data_allsamples %>% 
  tidyr::pivot_longer(
    cols = First_sample:Last_sample, 
    names_to = "Sample", 
    values_to = "Genotype")
#now in long format with sample column with sample ID per row and genotype column with genotype of that chromosomal position recorded for each individual
#long format table = one line per variant/sample/geno 
rm(genotype_data_allsamples)

#Join tables
geno_var_joined <- right_join(geno.long.format, filtered.variants.cadd.AC.SGULAC, by='CHROM_POS_REF_ALT')
#join successful - column which are included from both df are indicated with x (geno.long.format) or y (filtered.variants.cadd.AC.sgulac)

#include only heterozygous
geno_var_joined_geno <- geno_var_joined %>%
  filter(geno_var_joined$Genotype == '0/1')

#Define ID list
patient_ids_to_extract <- c("s9810381FAPA","s9810390ELSA","s9810557AMMO","s9810580AVZE","98-6-695-RO_AK","98-6-752-EBME","98-7-154-YZ_MA","98-7-221-ZAAB","98-7-93-BEKA","s98_8_684_SA_SE","F17_SH78","NDD-IR-16PF16M3","NDD-IR-16PF16M4","NDD-IR-16PF16M5","NDD-IR-18PF18M3","NDD-IR-20PF20M3","NDD-IR-3P_F3M4","NDD-IR-3P_F3M5","RM032","RM101","rs-357C","RS_437D","RS485C","RS488C","RS509C","RS512C","RS_523C","RS_578C","RS_592C","RS_595C","RS_600C","RS_601C","RS_619C","RS_621C","RS-627C","RS_631C","RS-640C","RS-643C","RS-644C","RS-653C","RS-657C","RS-662C","RS-668C","RS-720C","RS-725B","RS-746C","RS-748C","RS-752C","RS-767C","RS-773C","RS-1003CAfZA-MO","RS1019","RS1019","RS-1025CAfFA-BA","RS-1053CAfMO-SA","RS-1095CAfMO-RA","RS-1105CAfSA-NA","RS-1111CAfMO-HA","GWES1112","RS-1113CAfNE-KH","RS-1318C","RS-1420","RS-1543","RS-1548","RS-1578","RS-1610","RS-1705","RS-1841C","RS-1842C","RS-1843C","RS-1846C","RS-1847C","RS-1850C","RS-1852C","RS-1853C","RS-1860C","RS-1861C","RS-1863C","RS-1866C","RS-1867C","RS-1870C","RS-1872C","RS-1873C","RS-1875C","RS-1876C","RS-1877C","RS-1882C","RS-1883C","RS-1887C","RS-1888C","RS-1889C","RS-1890C","RS-1891C","RS-1892C","RS-1896C","RS-1898C","RS-1900C","RS-1904C","RS-1905C","RS-1907C","RS-1908C","RS-1909C","RS-1915C","RS-1916C","RS-1919C","RS-1921C","RS-1929C","RS-1930C","RS-1931C","RS-1932C","RS-1933C","RS-1934C","RS-1936C","RS-1937C","RS-1939C","RS-1940C","RS-1941C","RS-1942C","RS-1944C","RS-1945C","RS-1947C","RS-1952C","RS-1954C","RS-1955C","RS-1958C","RS-1959C","RS-1961C","RS-1966C","RS-1967C","RS-1968C","RS-1970C","RS-1972C","RS-1973C","RS-1975C","RS-1979C","RS-1987C","RS-1990C","RS-208C","RS428C","RS428C","RS438C","RS456C","RS461C","S495C","RS-532","RS536C","RS542C","RS546C","RS-548C","RS552D","RS-554","RS558C","RS561C","RS-563D","RS-585C","RS-608C","RS91C","RS-931CAffMO-MO","RS-938CAffAB-JA","RS-942CAffSA-GH","RS-951CAffEB-TE","RS-954CAffGO-MO","RS-959CAffNE-NA","RS-970CAffAH-AK","S0013A","s02-03-2019","s05-03-2019","s06-03-2019","s10-03-2019","S2076","S2080","S2096","S23035_A","S23453","S25510","S26141","S28449","S29063","S31568","S31975","S32060","S32383","S32519","s32M-III","S33049","S45172","S46397","S48159","s98_7_273","s98_7_288")

#loop to extract each set of patient data into an individual dataframe within a list
# Create an empty list to store dataframes for each patient
patient_dataframes <- list()
# Loop through each patient ID
for (patient_id in patient_ids_to_extract) {
  # Extract rows for the current patient ID
  patient_data <- geno_var_joined_geno[geno_var_joined_geno$Sample == patient_id, ]
  # Store the extracted data in a list
  patient_dataframes[[as.character(patient_id)]] <- patient_data
}

#how to view one patient's data that has been extracted to test it worked
#patient_1_data <- patient_dataframes[["s9810381FAPA"]]

#loop to summarise gene count for each gene within each patient to identify any gene with more than one variant in
#call each patient dataframe from list
for (patient_id in patient_ids_to_extract) {
  # Access the dataframe for the current patient ID
  patient_data <- patient_dataframes[[as.character(patient_id)]]
# Add a new column with the count of unique values in the 'SYMBOL' column
#Filter to remove any gene count below 2
  patient_data <- patient_data %>%
    group_by(SYMBOL) %>%
    mutate(ValueCount = n()) %>%
    filter(ValueCount >= 2)
#Replace the dataframe in the list with the manipulated data
patient_dataframes[[as.character(patient_id)]] <- patient_data
}

#combine data list back into single dataframe to export and intepret 
CH_combined_dataframe <- bind_rows(patient_dataframes)

#Export to excel
install.packages("writexl")
library(writexl)
write_xlsx(CH_combined_dataframe, 'CH_filtered_foranalysis')


#extra code to understand datasets
colnamevar <- colnames(filtered.variants.cadd.AC.SGULAC)
