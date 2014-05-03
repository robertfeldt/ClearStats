ClearStats package and web app
------------------------------

ClearStats provides clear and well-argued statistical analysis and results based 
on pre-packaged best practices. The goal is to make powerful, statistical tools
available also to non-statisticians. Also includes web apps for common tasks 
such as comparing two data sets. These web apps are implemented as OpenCPU apps.

To install in R (this will work once we make the bitbucket repo public):

    library(devtools)
    install_bitbucket("clearstats", "robertfeldt")

    library(opencpu)
    opencpu$browse("library/clearstats/www")

To run from the local library:

    make start

And to reinstall after you have changed something (do NOT run start.sh more than once; it will start multiple R sessions for OpenCPU):

    make update

To use the R package without the web app just load into R and check docs:

    library(clearstats)
    ?clearstats

There are also simpler Shiny web apps used for protoyping, which you can start like:

	make compare2

etc. For details see the Makefile.

For more information about OpenCPU apps, see [opencpu.js](https://github.com/jeroenooms/opencpu.js#readme)
