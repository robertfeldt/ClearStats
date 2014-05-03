#!/bin/sh
Rscript ./helpscripts/install_clearstats.R
Rscript ./helpscripts/install_packages_for_shiny_apps.R
R -e "shiny::runApp('./shiny_apps/orig_example')"