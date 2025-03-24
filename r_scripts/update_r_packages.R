############################################
## Script written by Dr. Ryan McShane     ##
## www.github.com/math-mcshane            ##
## www.ryanmcshane.com                    ##
############################################

## This script will update every R package
##  you have already installed to its
## newest version.
## It will also check required dependencies
##  and install those if they are not
##  already installed.

if (!any(installed.packages()[,1] == "pak")) install.packages("pak")
pak::pak("tidyverse")
no_vec_coalesce = function(data) {
  pak_table = {{data}}
  columns_available = pak::pkg_list() |>
    tibble::as_tibble() |>
    within(data = _, list())
  make_own = lapply(
    X = c("remotetype", "remoteusername", "remoterepo"),
    FUN = exists,
    where = columns_available
  ) |>
    do.call(what = c, args = _) |>
    all()

  if (exists("remotepkgref", where = columns_available)) {
    cat("Using remotepkgref.\n")
    package_vector = ifelse(
      test = pak_table[["repository"]] != "CRAN" | pak_table[["repository"]] |> is.na(),
      yes = pak_table[["remotepkgref"]],
      no = pak_table[["package"]]
    ) |>
      purrr::discard(is.na)
  } else if (make_own) {
    cat("Using wrangled remotepkgref.\n")
    pak_table = pak_table |>
      dplyr::mutate(remotepkgref = paste0(
        remotetype,
        "::",
        remoteusername,
        "/",
        remoterepo)
      )
    package_vector = ifelse(
      test = pak_table[["repository"]] != "CRAN" | pak_table[["repository"]] |> is.na(),
      yes = pak_table[["remotepkgref"]],
      no = pak_table[["package"]]
    ) |>
      purrr::discard(is.na)
  } else {
    cat("Using vanilla package list.\n")
    package_vector = pak_table[["package"]] |> purrr::discard(is.na)
  }
  return(package_vector)
}

update_paks = function() {
  package_vector = pak::pkg_list() |>
    tibble::as_tibble() |>
    no_vec_coalesce()
  pak::meta_update()
  pak::pkg_install(package_vector, upgrade = TRUE, ask = FALSE)
  pak::cache_clean()
}
update_paks()
