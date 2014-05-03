start:
	Rscript ./helpscripts/install_packages.R
	Rscript ./helpscripts/install_clearstats_and_open_in_browser.R

update:
	Rscript ./helpscripts/install_clearstats.R

compare2:
	Rscript ./helpscripts/install_clearstats.R
	Rscript ./helpscripts/install_packages_for_shiny_apps.R
	R -e "shiny::runApp('./shiny_apps/compare_2_datasets')"

clearstats.tar.gz:
	tar cvf clearstats.tar ../clearstats/*
	gzip clearstats.tar

clean:
	rm -rf *.tar *.tar.gz *.tgz
