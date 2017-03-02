#opts_knit$set(root.dir = '../.')
report <- function(rmd, n_file, open_file = default_open_file,
    report_dir = "reports", rmds_dir = "rmds") {

  if(!require(rmarkdown)) stop("Install rmarkdown package")

  rmd_path <- file.path(rmds_dir, rmd)

  # Generate the file name (without number) based on rmd file
  base_name <- sub(pattern = ".Rmd", replacement = "", x = basename(rmd_path))
  html_name <- paste0(base_name, ".html")

  if(!missing(n_file)){
    # Make nfiles with always 2 digits
    n_file <- ifelse(as.integer(n_file) < 10, paste0("0", n_file), n_file)
    file_name <- paste0(n_file, "-", html_name)
  } else {
      file_name <- html_name
  }
  # Produce the file. Simple wrapper of the render function
  rmarkdown::render(
    input = rmd_path,
    output_format = html_document(
      toc = TRUE,
      toc_depth = 1,
      code_folding = "hide"
    ),
    output_file = file_name,
    output_dir = report_dir,
    envir = new.env()
    )

  if(open_file & Sys.info()[1] == "Darwin") {
    result_path <- file.path(report_dir, file_name)
    system(command = paste("Open", result_path))
  }

}
