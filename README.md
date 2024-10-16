
# omekasapi

<!-- badges: start -->
 [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of omekasapi is to offer some functions to interact with [Omeka S API](https://omeka.org/s/docs/developer/api/).

## Installation

You can install the development version of omekasapi like so:

``` r
# install.packages("credentials")
credentials::set_github_pat()
# install.packages("devtools")
devtools::install_github("cutterkom/omekasapi")
```

## Examples

### Interact with vocabularies 

``` r
library(omekasapi)

api_url <- https://myomekas.org/api

base_req <- create_base_url(
  api_url, 
  key_identity=Sys.getenv("OMEKA_FORUM_KEY_ID"),
  key_credential=Sys.getenv("OMEKA_FORUM_KEY_CRED")) 
  
base_req |>
  query_ressource_classes(get_all = TRUE) 
  
```

