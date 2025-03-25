############################################
## Script written by Dr. Ryan McShane     ##
## www.github.com/math-mcshane            ##
## www.ryanmcshane.com                    ##
############################################

## This script will prepare your machine
##  for STAT234.

# Making sure correct version of R is installed before proceeding
page = readLines("https://cran.rstudio.com/bin/windows/base/release.html")
win_exe = regmatches(x = page, m = regexpr(pattern = "R-[0-9.]+.+-win\\.exe", text = page))
R_version = regmatches(x = win_exe, m = regexpr(pattern = "[0-9.]+", text = win_exe))
machine_R_version = paste0(R.Version()$major, ".", R.Version()$minor)
R_not_updated = package_version(machine_R_version) < package_version(R_version)
if (R_not_updated) {
  message = paste0("Please install R ", R_version, " and then re-run this script!\n",
         "You may also need to tell RStudio to use R ", R_version,
         ":\nTools -> Global Options -> R version -> Change")
  stop(message)
}

stat234_setup = function(install_r_paks = TRUE, update_r_paks = TRUE, install_tinytex = TRUE, install_latex_paks = TRUE) {

  if (install_r_paks){
    cat("Installing necessary R packages.\n")
    if (!any(installed.packages()[,1] == "pak")) install.packages("pak")
    stat234_R_paks = c("tinytex", "quarto", "tidyverse", "mosaic", "kableExtra",
                       "cowplot", "GGally", "janitor", "gridExtra", "GLMsData",
                       "openintro", "Stat2Data", "palmerpenguins", "mosaicData",
                       "nlme", "survival", "fivethirtyeight", "formatR")
    pak::pkg_install(stat234_R_paks)
  }

  if (update_r_paks) {
    cat("Updating installed R packages.\n")
    drm_git_repo = "https://raw.githubusercontent.com/math-mcshane/DrM_Assets_Pub/"
    update_script = "refs/heads/master/r_scripts/update_r_packages.R"
    source(paste0(drm_git_repo, update_script))
  }

  if (install_tinytex) {
    cat("Installing Tex Live Manager via R's tinytex package.\n")
    operating_system = capture.output(sessionInfo())[3] |>
      stringr::str_extract(c("Windows", "Ubuntu", "macOS")) |>
      purrr::discard(is.na)
    if (!(operating_system %in% c("Windows", "macOS"))) {
      tl_location = substr(x = tinytex::tlmgr_version("raw")[2], start = 27, stop = 44)
      if (is.null(tl_location)) {
        tinytex::install_tinytex(bundle = "TinyTeX-0")
      } else if (is.na(tl_location)) {
        tinytex::install_tinytex(bundle = "TinyTeX-0")
      } else if (tl_location == "/usr/share/texlive") {
        tinytex::install_tinytex(bundle = "TinyTeX-0", dir = "/cloud/project/tt")
      } else {
        if (tinytex::is_tinytex()) {
          cat("TinyTeX already installed; proceeding to LaTeX packages.\n")
        } else {
          tinytex::install_tinytex(bundle = "TinyTeX-0")
        }
      }
    } else {
      if (tinytex::is_tinytex()) {
        cat("TinyTeX already installed; proceeding to LaTeX packages.\n")
      } else {
        tinytex::install_tinytex(bundle = "TinyTeX-0")
      }
    }
    if (!tinytex::is_tinytex()) stop("TinyTeX installation failed!\n")
  }


  if (install_latex_paks) {
    if (!tinytex::is_tinytex()) stop("TinyTeX not installed!\n")

    cat("Installing LaTeX packages via R's tinytex package.\n")
    latex_paks = c("adjustbox", "amscls", "amsfonts", "amsmath", "anyfontsize",
                   "atbegshi", "atveryend", "auxhook", "avantgar", "babel", "babel-english",
                   "beamer", "bibtex", "bigintcalc", "bitset", "blindtext", "bookman",
                   "bookmark", "booktabs", "caption", "charter", "cm", "cm-super",
                   "cmextra", "collectbox", "collection-basic", "collection-fontsrecommended",
                   "colorprofiles", "colortbl", "courier", "ctablestack", "currfile",
                   "dehyph", "doublestroke", "dvipdfmx", "dvips", "ec", "enctex",
                   "enumitem", "environ", "epstopdf", "epstopdf-pkg", "etex", "etex-pkg",
                   "etexcmds", "etoolbox", "euenc", "euro", "euro-ce", "eurosym",
                   "everyshi", "extractbb", "fancyhdr", "fancyvrb", "filehook",
                   "filemod", "firstaid", "float", "fontspec", "footmisc", "fp",
                   "fpl", "framed", "geometry", "gettitlestring", "gincltex", "glyphlist",
                   "gothic", "graphics", "graphics-cfg", "graphics-def", "grfext",
                   "helvetic", "hycolor", "hyperref", "hyph-utf8", "hyphen-base",
                   "hyphen-english", "hyphenex", "ifplatform", "iftex", "inconsolata",
                   "infwarerr", "intcalc", "jknapltx", "knuth-lib", "knuth-local",
                   "koma-script", "kpathsea", "kvdefinekeys", "kvoptions", "kvsetkeys",
                   "l3backend", "l3kernel", "l3packages", "lastpage", "latex", "latex-amsmath-dev",
                   "latex-bin", "latex-fonts", "latex-tools-dev", "latexconfig",
                   "latexmk", "letltxmacro", "listings", "lm", "lm-math", "ltxcmds",
                   "lua-alt-getopt", "lua-uni-algos", "luahbtex", "lualatex-math",
                   "lualibs", "luaotfload", "luatex", "luatexbase", "makecell",
                   "makeindex", "manfnt-font", "marvosym", "mathpazo", "mdwtools",
                   "metafont", "mflogo", "mflogo-font", "mfware", "modes", "multirow",
                   "natbib", "ncntrsbk", "nicematrix", "palatino", "pdfcol", "pdfescape",
                   "pdflscape", "pdftex", "pdftexcmds", "pgf", "plain", "preprint",
                   "psnfss", "pxfonts", "qualitype", "refcount", "rerunfilecheck",
                   "rsfs", "scheme-infraonly", "selnolig", "soul", "standalone",
                   "stringenc", "symbol", "tabu", "tcolorbox", "tex", "tex-gyre",
                   "tex-gyre-math", "tex-ini-files", "texlive-common", "texlive-en",
                   "texlive-msg-translations", "texlive-scripts", "texlive-scripts-extra",
                   "texlive.infra", "threeparttable", "threeparttablex", "tikzfill",
                   "times", "tipa", "titlesec", "titling",
                   "tools", "translator", "trimspaces", "txfonts", "ulem",
                   "unicode-data", "unicode-math", "uniquecounter", "url", "utopia",
                   "varwidth", "wasy", "wasy-type1", "wasysym", "wrapfig", "xcolor",
                   "xdvi", "xetex", "xetexconfig", "xkeyval", "xpatch", "xunicode",
                   "yfonts", "yfonts-otf", "yfonts-t1", "zapfchan", "zapfding")
    other_latex_paks = c("tlgpg", "tlgs", "tlperl", "tlshell")
    tinytex::tlmgr_install(latex_paks)
  }

}





