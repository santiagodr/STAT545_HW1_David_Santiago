all: automating_data_pipelines_hw07.md

clean:
	rm dataset.zip *.xlsx *.txt *.csv 
	
bird_func_dat.txt Measurements of passerine birds.xlsx:
	Rscript 1_download_data.R

bird_data_clean.csv: bird_func_dat.txt Measurements of passerine birds.xlsx 2_read_join_filter_data.R
	Rscript 2_read_join_filter_data.R

fig1_spbydiet.png fig2_sample_diet_use.png fig3_trait_distribution_per_diet.png fig4_bill_mass.png fig5_tarsus_mass.png: 3_analysis.R bird_data_clean.csv
	Rscript 3_analysis.R   

automating_data_pipelines_hw07.md: fig1_spbydiet.png fig2_sample_diet_use.png fig3_trait_distribution_per_diet.png fig4_bill_mass.png fig5_tarsus_mass.png automating_data_pipelines_hw07.Rmd
	Rscript -e 'rmarkdown::render("automating_data_pipelines_hw07.Rmd")'
	
