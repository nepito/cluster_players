FROM islasgeci/base:1.0.0
COPY . /workdir
RUN pip install typer
RUN Rscript -e "install.packages(c('comprehenr', 'optparse', 'patchwork', 'umap'), repos='http://cran.rstudio.com')"
