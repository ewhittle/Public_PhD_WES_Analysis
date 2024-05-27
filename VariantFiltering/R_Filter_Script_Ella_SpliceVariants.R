#set working directory to files window on session drop down
setwd("/homes/homedirs-pg-research/sghms/student/users/m2007653/R_Studio/Iranian_Exomes/July2023/Results")

install.packages("tidyverse")
library(tidyverse)
#tidyverse_update() #make sure tidyverse up to date
con <- DBI::dbConnect(RSQLite::SQLite(), 'Ella_NDD_July_2023_sqlite3.db')

#defining variant filter criteria:
#SQL databse tables: variant_data and genotype_data
MAF.threshold = 0.01
selected.consequences = c("intron_variant&non_coding_transcript_variant",                                                                                 
                          "non_coding_transcript_exon_variant",                                                                                           
                          "splice_region_variant&splice_polypyrimidine_tract_variant&intron_variant&non_coding_transcript_variant",                       
                          "splice_donor_variant&non_coding_transcript_variant",                                                                           
                          "splice_polypyrimidine_tract_variant&intron_variant&non_coding_transcript_variant",                                                                                                                                                        
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
                          "intron_variant",                                                                                                               
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

#Want to add extra filter to variants to keep splice scores over 80
#Columns 18, 20, 22 and 24 hold scores we need to filter 
filtered.variants.cadd.AC.SGULAC.spliceAG <- filtered.variants.cadd.AC.SGULAC %>%
  filter(as.numeric(filtered.variants.cadd.AC.SGULAC$SpliceAI_pred_DS_AG) >= 0.80) #131 meet threshold 
  
filtered.variants.cadd.AC.SGULAC.spliceAL <- filtered.variants.cadd.AC.SGULAC %>%
  filter(as.numeric(filtered.variants.cadd.AC.SGULAC$SpliceAI_pred_DS_AL) >= 0.80) #344 meet threshold 

filtered.variants.cadd.AC.SGULAC.spliceDG <- filtered.variants.cadd.AC.SGULAC %>%
  filter(as.numeric(filtered.variants.cadd.AC.SGULAC$SpliceAI_pred_DS_DG) >= 0.80) #96 meet threshold

filtered.variants.cadd.AC.SGULAC.spliceDL <- filtered.variants.cadd.AC.SGULAC %>%
  filter(as.numeric(filtered.variants.cadd.AC.SGULAC$SpliceAI_pred_DS_DL) >= 0.80) #549 meet threshold

#Join all 4 output dataframes together 
install.packages("plyr")
library(plyr)
variants.filtered.splice.bound <- rbind(filtered.variants.cadd.AC.SGULAC.spliceAG, filtered.variants.cadd.AC.SGULAC.spliceAL, filtered.variants.cadd.AC.SGULAC.spliceDG, filtered.variants.cadd.AC.SGULAC.spliceDL)

rm(filtered.variants.cadd.AC.SGULAC.spliceAG)
rm(filtered.variants.cadd.AC.SGULAC.spliceAL)
rm(filtered.variants.cadd.AC.SGULAC.spliceDG)
rm(filtered.variants.cadd.AC.SGULAC.spliceDL)
rm(filtered.variants.cadd.AC.SGULAC)

#reopen connection to genotype database
con <- DBI::dbConnect(RSQLite::SQLite(), 'Ella_NDD_July_2023_sqlite3.db')
genotype_data_allsamples <- as_tibble(tbl(con, "genotype_data"))
DBI::dbDisconnect(con)

#2 tables at this point: 
#         1. genotype_data_allsamples (sample IDs + primary key)
#         2. variants.filtered.splice.bound (filtered variants with all consequence columns + primary key)
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
geno_var_joined <- right_join(geno.long.format, variants.filtered.splice.bound, by='CHROM_POS_REF_ALT')
#join successful - column which are included from both df are indicated with x (geno.long.format) or y (filtered.variants.cadd.AC.sgulac)

geno_var_joined_geno <- geno_var_joined %>%
  filter(geno_var_joined$Genotype == '0/1' | geno_var_joined$Genotype == '1/0' | geno_var_joined$Genotype == '1/1')

#removes dulpicates for variants that had >80 score in multiple columns 
geno_var_joined_geno_dup <- geno_var_joined_geno[!duplicated(geno_var_joined_geno), ]

#Export to excel
install.packages("writexl")
library(writexl)
write_xlsx(geno_var_joined_geno_dup, 'splice_variants_het')


#extra code to understand datasets
colnamevar <- colnames(filtered.variants.cadd.AC.SGULAC)
