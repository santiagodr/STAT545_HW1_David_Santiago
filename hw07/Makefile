all: 

bird_func_dat.txt Measurements of passerine birds.xlsx:
  Rscript 1_download_data.R

bird_data_clean.csv: 1_download_data 
	Rscript 2_read_join_filter_data.R
  
clean:
	rm dataset.zip *.xlsx *.txt
  
