#' Query ressource classes
#' @description This function get data from the `resource_classes` endpoint.
#' @param base_req base request, typically result of `create_base_request`
#' @param query_string in this case harded coded to `resource_classes`
#' @param per_page integer, number of items to fetch, default set to `99999`
#' @param get_all boolean: if `TRUE` (or not null, to be precise) all `ressource_classes` will be fetched
#' @param vocabulary_prefix string, get all classes for special vocabulary, e.g. `dcterms`, `foaf`
#' @param term string, search for terms, e.g. `dcterms:title`, `foaf:Person`
#'
#' @export
#' @rdname query_ressource_classes
#'
#' @importFrom attempt stop_if_all
#' @importFrom httr2 req_url_path_append
#' @importFrom httr2 req_url_query
#' @importFrom httr2 req_perform
#' @importFrom httr2 resp_body_json
#' @importFrom cli cli_inform
#'
#' @return the results from the search
#' @examples
#' \dontrun{
#' query_ressource_classes(req, vocabulary_prefix = "dcterms")
#' query_ressource_classes(req, get_all = TRUE)
#' }
query_ressource_classes <- function(base_req, per_page = 99999, query_string = "resource_classes", get_all = NULL, vocabulary_prefix = NULL, term = NULL) {
  args <- list(per_page = per_page, get_all = get_all, vocabulary_prefix = vocabulary_prefix, term = term)

  # Check that at least one argument is not null
  attempt::stop_if_all(args, is.null, "You need to specify at least one argument")
  # Chek for internet
  check_internet()

  if (!is.null(get_all)) {
    # Create the request
    req <- base_req |>
      httr2::req_url_path_append(query_string) |>
      httr2::req_url_query(per_page = per_page)

    cli::cli_inform("{.url {req$url}}")

    resp <- req |> httr2::req_perform()
  } else {
    # Create the request
    req <- base_req |>
      httr2::req_url_path_append(query_string) |>
      httr2::req_url_query(!!!args)

    cli::cli_inform("{.url {req$url}}")

    resp <- req |>
      httr2::req_perform()
  }
  # Check the result
  check_status(resp)

  # extract json
  resp |>
    httr2::resp_body_json(simplifyVector = TRUE)
}
