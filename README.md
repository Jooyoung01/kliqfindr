# kliqfindr - KliqueFinder Algorithm in R

[![Build Status](https://travis-ci.org/jtbates/kliqfindr.svg?branch=master)](https://travis-ci.org/jtbates/kliqfindr)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

## WARNING

This is pre-release software under development and is not intended for general use at this time.

## Installation

This package is not on CRAN and does not yet have pre-compiled binaries. Installation therefore involves compiling Fortran code from source and requires command line tools outside of R. You will need R 3.3.x or later.<br />
> Direct Links: <br />
Proper R version : [3.6.2 (2019-12-12)](https://cran.r-project.org/bin/windows/base/old/3.6.2/R-3.6.2-win.exe)<br />
R tools : [Rtools 35](https://cran.r-project.org/bin/windows/Rtools/Rtools35.exe)<br />
1. Install the command line tools for your operating system.
    1. Windows
        1. Install the [Windows command line tools](https://cran.r-project.org/doc/manuals/R-admin.html#The-command-line-tools). Use the [Rtools35.exe](https://cran.r-project.org/bin/windows/Rtools/Rtools35.exe) installer from [Rtools downloads](https://cran.r-project.org/bin/windows/Rtools/).
    2. Mac OS X
        1. Install Xcode Command Line Tools. Use the following install command in the terminal
            ```
            $ xcode-select --install
            ```
            Only the Command Line Tools (220MB) are needed. A full install of Xcode (7.1GB) is not necessary.
        2. Install GNU Fortran for MacOS X from https://github.com/fxcoudert/gfortran-for-macOS/releases.
    3. Debian-based Linux
        1. Install the r-base-dev package. Use the following install command in the terminal
            ```
            $ sudo apt-get install r-base-dev
            ```
2. Install the [devtools](https://github.com/hadley/devtools) package. In R
    ```
    > install.packages('devtools')
    ```
3. Install the current development version of kliqfindr from GitHub with devtools. In R
    ```
    > devtools::install_github("jtbates/kliqfindr")
    ```
 
 ### Troubleshooting
 
 More information on troubleshooting installation issues is available [on the wiki](https://github.com/jtbates/kliqfindr/wiki/Troubleshooting-install-issues).
 
