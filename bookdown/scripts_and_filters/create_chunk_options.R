# check for basic packages required
if (!("bookdown" %in% installed.packages()))
  install.packages("knitr", repos = "http://cran.rstudio.com")

# check if the right packages are installed to create the chunk options
if (!("knitr" %in% installed.packages()))
  install.packages("knitr", repos = "http://cran.rstudio.com")

if (!("kableExtra" %in% installed.packages()))
  install.packages("kableExtra", repos = "http://cran.rstudio.com")

library(kableExtra)


##### add chunk options for PDF output ####
# for guidance on how to create your own chunk options see
# https://ulyngs.github.io/blog/posts/2019-02-01-how-to-create-your-own-chunk-options-in-r-markdown/


# add chunk option 'vspace_output' that can be used to add white space after each R command's output
hook_output_def = knitr::knit_hooks$get('output')
knitr::knit_hooks$set(output = function(x, options) {
  if (!is.null(options$vspace_output)) {
    end <- paste0("\\vspace{", options$vspace_output, "}")
    stringr::str_c(hook_output_def(x, options), end)
  } else {
    hook_output_def(x, options)
  }
})


hook_chunk = knitr::knit_hooks$get('chunk')
knitr::knit_hooks$set(chunk = function(x, options) {
  txt = hook_chunk(x, options)
  # add chunk option 'quote_author' which adds \qauthor{...} to the end of a chunk.
  # This is used to give the author of the cute quotes you can add to chapter openings
  if (!is.null(options$quote_author)) {
    latex_quote <- paste0("\\\\qauthor\\{", options$quote_author, "\\}\\1")
    txt <- gsub('(\\\\end\\{savequote\\})', latex_quote, txt)
  } 
  
  # add chunk option 'fig.notes' which adds \begin{justify}\scriptsize\textit{Notes: }...\end{justify} to figures
  if (!is.null(options$fig.notes)) {
    latex_fignote <- paste0("\\\\begin\\{justify\\}\\\\scriptsize\\\\textit\\{Notes:\\} ", options$fig.notes, "\\\\end\\{justify\\}\\1")
    txt <- gsub('(\\\\end\\{figure\\})', latex_fignote, txt) 
  }
  
  # add chunk option 'table.notes' which adds \begin{justify}\scriptsize\textit{Notes: }...\end{justify} to tables
  if (!is.null(options$table.notes)) {
    latex_tabnote <- paste0("\\\\begin\\{justify\\}\\\\scriptsize\\\\textit\\{Notes:\\} ", options$table.notes, "\\\\end\\{justify\\}\\1")
    txt <- gsub('(\\\\end\\{table\\})', latex_tabnote, txt)
  }
  
  # add chunk option 'table.font.size' which adds the specified latex font size in front of \begin{tabular}
  if (!is.null(options$table.font.size)) {
    txt <- gsub('(\\\\begin\\{tabular\\})', paste0('\\\\', options$table.font.size, '\\1'), txt)
  }
  
  return(txt)  # pass to default hook
})