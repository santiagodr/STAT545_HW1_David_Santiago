# Download raw data from internet

library(downloader)
# Wilman etal. 2014 Elton Traits 1.0: Species-level foraging attributes 
# of the world's birds and mammals. Ecology 95:2027
download.file(url = "http://www.esapubs.org/archive/ecol/E095/178/BirdFuncDat.txt", destfile = "bird_func_dat.txt")

# Ricklefs 2017 Passerine morphology: external measurements of approximately one-quarter
# of passerines bird species. Ecology 98(5): 1472
download.file(url = "http://onlinelibrary.wiley.com/store/10.1002/ecy.1783/asset/supinfo/ecy1783-sup-0002-DataS1.zip?v=1&s=361647dd673d04c9b0838931cda1cf28e1f6eb1f", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")

