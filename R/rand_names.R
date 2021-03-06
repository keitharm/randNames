#' Random name generator
#'
#' This function grabs a list of random names from the random user generator
#'
#' The return object contains the following fields: seed,  user.password,
#' user.sha256, user.cell, user.name.title, user.location.city,
#' user.picture.medium, user.gender, user.salt, user.registered, user.SSN,
#' user.name.first, user.location.state, user.picture.thumbnail,  user.email,
#' user.md5, user.dob, user.version, user.name.last, user.location.zip,
#' user.NINO,  user.username, user.sha1, user.phone, user.nationality,
#' user.location.street,  user.picture.large.
#'
#' @param n Number of names required. Free users get 100 max (and 1000 per day).
#'   Purchase an key here: \url{https://randomapi.com/pricing}
#' @param seed A random string to ensure same results
#' @param gender male or female
#' @param nationality Currently only takes \code{US} or \code{GB}
#' @param key An API key for more requests. Free plan can tap out after 1000 requests (100 max per request).
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr tbl_df rbind_all
#' @export
#' @examples
#' library(dplyr)
#' 5 %>%
#' rand_names %>%
#' select(first = user.name.first, last = user.name.last)
#'
#'  # x <- 5 %>%
#'  #   rand_names %>%
#'  # filter(user.gender == "female") %>%
#'  #  select(user.name.first, user.name.last)
rand_names <- function(n = 1, seed = NULL, gender = NULL, nationality = NULL, key = NULL) {
  ee_compact <- function(l) Filter(Negate(is.null), l)
  args <- ee_compact(as.list(c(results = n, seed = seed, gender = gender, nationality = nationality, key = key)))
  if(n > 0) {
      x <- jsonlite::fromJSON(httr::content(httr::GET("http://api.randomuser.me/", query = args), as = "text"), flatten = TRUE)
    }
  tbl_df(rbind_all(x))
}
