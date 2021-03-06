
#' @title Get R6 skeleton for a package
#' @name document_package
#' @description Given a package name, find al lthe R6 objects in that package's
#'              namespace and build skeleton Roxygen docs for each one. One file
#'              will be created in \code{out_dir} for each object.
#' @param pkg_name Name of the package to document
#' @param out_dir Directory to write documentation to
#' @importFrom assertthat assert_that is.string
#' @export
document_package <- function(pkg_name, out_dir = file.path(getwd(), "roxy_docsy")){

    assertthat::assert_that(
        assertthat::is.string(pkg_name)
    )

    R6_objects <- find_R6_objects(pkg_name)

    if (length(R6_objects) == 0){
        print(sprintf("No R6 objects found in %s", pkg_name))
        return(invisible(NULL))
    }

    if (!dir.exists(out_dir)){
        dir.create(out_dir)
    }

    for (obj in R6_objects){

        out_file <- file.path(out_dir, paste0(obj$classname, ".R"))
        file.create(out_file)

        cat("\n\n", file = out_file, append = TRUE)

        cat(document_class(obj)
            , file = out_file
            , append = TRUE)
    }

    return(invisible(NULL))
}
