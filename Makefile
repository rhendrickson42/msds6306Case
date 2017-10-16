################
# install Rtools
# https://cran.r-project.org/bin/windows/Rtools/
#
# note: possible issues: be sure R_LIBS_USER is set correctly
#       ex: 
# R_HOME=d:/R/R-3.4.2/x64
# R_LIBS_USER=C:/Users/ < username > /Documents/R/win-library/3.4
# use > Sys.getenv()  -- to check
# 

CURRENT_DIR = .
RDIR = $(CURRENT_DIR)/scripts
MARKDOWN_DIR = $(CURRENT_DIR)/markdown

RSOURCE = $(wildcard $(RDIR)/*.R)
MARKDOWN_SOURCE = $(wildcard $(MARKDOWN_DIR)/*.Rmd)
ROOTMARKDOWN_SOURCE = $(wildcard $(CURRENT_DIR)/*.Rmd)


OUT_FILES = $(RSOURCE:.R=.Rout)
MARKDOWN_OUT_FILES = $(MARKDOWN_SOURCE:.Rmd=.html)
ROOTMARKDOWN_OUT_HTML_FILES = $(ROOTMARKDOWN_SOURCE:.Rmd=.html)
ROOTMARKDOWN_OUT_MD_FILES = $(ROOTMARKDOWN_SOURCE:.Rmd=.md)

all: $(OUT_FILES) $(MARKDOWN_OUT_FILES) $(ROOTMARKDOWN_OUT_HTML_FILES)

$(RDIR)/%.Rout: $(RDIR)/%.R
	Rscript $<
	@echo done...

$(MARKDOWN_DIR)/%.html: $(MARKDOWN_DIR)/%.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<')"
	@echo done...
	
$(CURRENT_DIR)/%.html: $(CURRENT_DIR)/%.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<')"
	@echo done...

clean:
	rm -fv $(OUT_FILES)
	rm -fv $(MARKDOWN_OUT_FILES)
	rm -fv $(ROOTMARKDOWN_OUT_HTML_FILES)
	rm -fv $(ROOTMARKDOWN_OUT_MD_FILES)
	