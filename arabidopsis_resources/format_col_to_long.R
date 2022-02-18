# Format .col to long table
library(tidyverse)

aracyc_17<- read_tsv("~/arabidopsis_resources/aracyc17_pathways.col",comment = '#')  %>% 
  #dplyr::select(-contains("GENE-ID")) %>% 
  pivot_longer(contains("GENE-NAME"), values_to = "gene_name", names_to ="drop") %>% 
  pivot_longer(contains("GENE-ID"), values_to = "gene_id", names_to ="drop2") %>% 
  dplyr::select(-contains("drop")) %>% 
  unique() 

aracyc_17 %<>% mutate(gene = case_when(str_detect(gene_name, "AT[0-5|M|C]G[0-9]+") ~ gene_name,
                      TRUE ~ gene_id)) %>% 
  dplyr::select(term = NAME, gene) %>% 
  filter(!is.na(gene)) %>% 
  unique()

aracyc_17 %>% write_csv("~/arabidopsis_resources/aracyc17_formatted.csv")
