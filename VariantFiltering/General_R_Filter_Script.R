#set working directory to files window on session drop down
setwd("/homes/homedirs-pg-research/sghms/student/users/m2007653/R_Studio/Iranian_Exomes/July2023/Results")

install.packages("tidyverse")
library(tidyverse)
tidyverse_update() #make sure tidyverse up to date
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

#remove all clinsig outcomes that include 'benign'
#as clinsig is messy and phenoype specific I will not include this filter. 
#Maybe the variant is benign in one disease but pathogenis in our patient
#applying this filter removes 1,898 variants
###install.packages("stringr")
###library(stringr)
###filtered.variants.cadd.clinsig <- filtered.variants.cadd %>%
###  filter(!str_detect(CLIN_SIG, "benign"))

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

#End of filtering variant file - removed CADD Phred <20, removed common or artifact variants, have code for clinsig but not applied
#Filtered file 161303

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

#join tables - now want to join variant and geno table so we can see who is carrying what variant in what phase from our filtered patho variant list
geno_var_joined <- left_join(geno.long.format, filtered.variants.cadd.AC.SGULAC, by='CHROM_POS_REF_ALT')
#join successful - column which are included from both df are indicated with x (geno.long.format) or y (filtered.variants.cadd.AC.sgulac)
#too many large files at this point for R to work, need to remove other larger files
rm(geno.long.format)
rm(filtered.variants.cadd.AC.SGULAC)

#extract all homozygous data into a file 
geno.joined.homo <- geno_var_joined %>%
  filter(geno_var_joined$Genotype == '1/1')

#extract all heterozygous data into a file 
geno.joined.het <- geno_var_joined %>%
  filter(geno_var_joined$Genotype == '0/1' | geno_var_joined$Genotype == '1/0')

#remove NA rows from variant files
geno.joined.homo.NAremoved <- geno.joined.homo %>% drop_na(ALT.y)
geno.joined.het.NAremoved <- geno.joined.het %>% drop_na(ALT.y)

rm(geno.joined.het)
rm(geno.joined.homo)

#export to excel - initially did as workspace not saving likely as not enough H drive space
install.packages("writexl")
library(writexl)
write_xlsx(geno.joined.homo.NAremoved, 'homo_variants_allsamples_filtered_excel_2')
write_xlsx(geno.joined.het.NAremoved, 'het_variants_allsamples_filtered_excel_2')


#Extra code to help understand dataframes:
#to see how many categories are in a column in dataframe
clinsigcat.postfilter <- unique(filtered.variants.cadd.clinsig$CLIN_SIG) 
numberOfCategories <- length(categories)

caddac.postfilter <- unique(filtered.variants.cadd.AC.SGULAC$SGUL_Exomes_AC) 
numberOfCategories <- length(categories)

geno.joined <- unique(geno_var_joined$Sample) 
numberOfCategories <- length(geno.joined)

geno.joined <- unique(geno_var_joined$Genotype) 
numberOfCategories <- length(geno.joined)

geno.joined.homozygous <- unique(geno.joined.homo$ALT.x) 
numberOfCategories <- length(geno.joined.homozygous)

geno.joined.heterozygous <- unique(geno.joined.het$Genotype) 
numberOfCategories <- length(geno.joined.heterozygous)

variants.test.con <- unique(variants.test$Consequence) 
numberOfCategories <- length(variants.test.con)

colnamegeno <- colnames(geno.long.format)
colnamevar <- colnames(filtered.variants.cadd.AC.SGULAC)
colnamejoined <- colnames(geno_var_joined)
