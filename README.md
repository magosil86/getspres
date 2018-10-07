
[![Travis-CI Build Status](https://travis-ci.org/magosil86/getspres.svg?branch=master)](https://travis-ci.org/magosil86/getspres)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/magosil86/getspres/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/magosil86/getspres.svg)](https://github.com/magosil86/getspres/issues)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/getspres)](https://cran.r-project.org/package=getspres)
[![CRAN_Logs_Rstudio](https://cranlogs.r-pkg.org/badges/grand-total/getspres)](http://cran.rstudio.com/web/packages/getspres/index.html) 
<!-- []() <img src="https://user-images.githubusercontent.com/8364031/46570331-0c8f0180-c952-11e8-923d-536448190113.gif" align="right" /> -->


## _getspres_ : _SPRE_ Statistics for Exploring Heterogeneity in Meta-Analysis


One useful way of identifying overly influential outlier studies in meta-analyses and their direction of effect is through the calculation of SPRE (standardised predicted random-effects) statistics. These precision-weighted residuals can be used in genetic association meta-analyses, for example, to point out outlier sutides showing outsized effects that are likely to inflate genetic signals (average genetic effect estimates) at variants of interest. 

**_getspres_** facilitates calculation of _SPRE_ statistics in R and provides forest plots showing corresponding _SPRE_ statistic values for participating studies in meta-analyses. 

The advantage of using the **_getspres_** package is that it provides a quantitative and visual view of heterogeneity at individual genetic variants in meta-analyses.


### Installation

```{r}
# To install the release version from CRAN:
install.packages("getspres")

# Load libraries
library(getspres)  # for calculating SPRE statistics


# To install the development version from GitHub:

# install devtools
install.packages("devtools")

# install getspres
library(devtools)
devtools::install_github("magosil86/getspres")

# Load libraries
library(getspres)  # for calculating SPRE statistics
```

### Usage

Load the getspres package in your current R session, and try some examples in the [example workflow](https://github.com/magosil86/getmstatistic/blob/master/vignettes/getmstatistic-tutorial.md)

```{r}
# Load libraries
library(getspres)  # for calculating SPRE statistics
```
For an overview of available functions in **_getspres_**, type `?getspres` and `?plotspres` at the R prompt.


For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Getting help

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.


### Citation

### References

Harbord, R. M., & Higgins, J. P. T. (2008). Meta-regression in Stata. Stata Journal 8: 493‚Äì519.

Wolfgang Viechtbauer (2010). Conducting meta-analyses in R with the
metafor package. Journal of Statistical Software, 36(3), 1-48. URL
http://www.jstatsoft.org/v36/i03/.

Magosi LE, Goel A, Hopewell JC, Farrall M, on behalf of the CARDIoGRAMplusC4D Consortium (2017) 
Identifying systematic heterogeneity patterns in genetic association meta-analysis studies. 
PLoS Genet 13(5): e1006755. https://doi.org/10.1371/journal.pgen.1006755.


### Authors

<a >Lerato E. Magosi</a> <small class="roles"> </small> <a  href="https://orcid.org/0000-0003-4757-117X" target="orcid.widget"><img src="https://members.orcid.org/sites/default/files/vector_iD_icon.svg" class="orcid" alt="ORCID" height="16"></a>, <a >Jemma C. Hopewell</a> <small class="roles"> </small> <a href="https://orcid.org/0000-0003-4757-117X" target="orcid.widget"><img src="https://members.orcid.org/sites/default/files/vector_iD_icon.svg" class="orcid" alt="ORCID" height="16"></a> and 
<a >Martin Farrall</a> <small class="roles"> </small> <a href="https://orcid.org/0000-0003-4757-117X" target="orcid.widget"><img src="https://members.orcid.org/sites/default/files/vector_iD_icon.svg" class="orcid" alt="ORCID" height="16"></a>


### Maintainer

Lerato E. Magosi lmagosi@well.ox.ac.uk or magosil86@gmail.com

### Citation

### Code of conduct

Contributions are welcome. Please observe the [Contributor Code of Conduct]() when participating in this project.

### License

[MIT](https://opensource.org/licenses/mit-license.php) + file [License]().


```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```
