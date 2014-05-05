ClearStats package and web app
------------------------------

ClearStats provides clear and well-argued statistical analysis and results based 
on pre-packaged best practices. The goal is to make powerful, statistical tools
available also to non-statisticians. Also includes web apps for common tasks 
such as comparing two data sets. These web apps are implemented as OpenCPU apps.

To install in R:

    library(devtools)
    install_github("ClearStats", "robertfeldt")

To start the OpenCPU web app:

    library(opencpu)
    opencpu$browse("library/ClearStats/www")

To run the publically available version on the public OpenCPU server point your browser to:

	http://robertfeldt.ocpu.io/ClearStats/www/

To run from your local git repo:

    make start

And to reinstall after you have changed something (do NOT run "make start" more than once; it will start multiple R sessions for OpenCPU):

    make update

and then reload in your browser.

To use the R package without the web app just load into R and check docs:

    library(ClearStats)
    ?ClearStats

There are also simpler Shiny web apps used for protoyping, which you can start like:

	make compare2

etc. For details see the Makefile.

For more information about OpenCPU apps, see [opencpu.js](https://github.com/jeroenooms/opencpu.js#readme)

# Acknowledgements

This work was partly funded by The Knowledge Foundation (KKS) through the project 20130085 Testing of Critical System Characteristics (TOCSYC), and by Vinnova (Swedish Innovation Agency) through the project Test Innovation Engine Sweden (TIES).

Thanks to Jeroen Ooms for OpenCPU.