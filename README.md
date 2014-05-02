ClearStats package and web app
------------------------------

ClearStats provides clear and well-argued statistical analysis and results based 
on pre-packaged best practices. The goal is to make powerful, statistical tools
available also to non-statisticians. Also includes web apps for common tasks 
such as comparing two data sets. These web apps are implemented as OpenCPU apps.

To install in R:

    library(devtools)
    install_bitbucket("clearstats", "robertfeldt")

    library(opencpu)
    opencpu$browse("library/clearstats/www")

Use the same function locally:

    library(clearstats)
    ?ClearStats

For more information about OpenCPU apps, see [opencpu.js](https://github.com/jeroenooms/opencpu.js#readme)
