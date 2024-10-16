#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
check_internet <- function(){
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' @importFrom httr2 resp_status
check_status <- function(res){
  stop_if_not(.x = resp_status(res),
              .p = ~ .x == 200,
              msg = "The API returned an error")
}

#' Create base url for Omeka S installation
#' The API of a Omeka S installation can be found at the URL `https://youromekeas.domain/api`.
#' To access (private) data you need a `key_identity` and `key_credential`, you get both in the Omeka S backend.
#' @param omeka_url The URL of the Omeka S installation
#' @param key_identity your `key_identity`, preferably saved in `.Renviron`
#' @param key_credential your `key_credential`, preferably saved in `.Renviron`
#' @importFrom httr2 request
#' @importFrom httr2 req_url_query
#' @export
create_base_req <- function(omeka_url, key_identity, key_credential) {
  req <- httr2::request(omeka_url) |>
    httr2::req_url_query(
      key_identity=key_identity,
      key_credential=key_credential)
  req
}






