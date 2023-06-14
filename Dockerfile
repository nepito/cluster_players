FROM islasgeci/base:1.0.0
COPY . /workdir
RUN Rscript -e "install.packages(c('comprehenr', 'patchwork', 'umap'), repos='http://cran.rstudio.com')"
