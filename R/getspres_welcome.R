.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to getspres \n see https://magosil86.github.io/getspres/ for examples and documentation")
}


.onLoad <- function(libname, pkgname) {
  op <- options()
  op.getspres <- list(
    getspres.path = "",
    getspres.install.args = "",
    getspres.name = "Lerato E. Magosi",
    getspres.desc.author = '"Lerato E. Magosi <magosil86@gmail.com> [aut, cre]"',
    getspres.desc.license = "MIT",
    getspres.desc.suggests = NULL,
    getspres.desc = list()
  )
  toset <- !(names(op.getspres) %in% names(op))
  if(any(toset)) options(op.getspres[toset])

  invisible()
}