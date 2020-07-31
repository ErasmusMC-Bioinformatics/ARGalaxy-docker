#FROM bgruening/galaxy-stable:18.09
FROM bgruening/galaxy-stable:20.05

RUN rm /etc/apt/sources.list.d/*

RUN apt update
RUN apt install -y bc file

# For changeo/python3
ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh miniconda3.sh
RUN bash miniconda3.sh -b -p ~/miniconda3

# fix lsb_release
#run ls -l /usr/bin/python2.7
#RUN sed -i 's%/usr/bin/python3%/usr/bin/python2.7%g' /usr/bin/lsb_release
#RUN lsb_release -a

RUN ~/miniconda3/bin/pip install numpy scipy matplotlib ipython jupyter pandas sympy nose biopython presto changeo
ADD https://bitbucket.org/kleinstein/changeo/downloads/changeo-0.4.4.tar.gz changeo-0.4.4.tar.gz
RUN tar -xzf changeo-0.4.4.tar.gz
ENV PATH="${PATH}:/galaxy-central/changeo-0.4.4/bin"

ENV GALAXY_CONFIG_BRAND "ARGalaxy"
ENV GALAXY_CONFIG_CONDA_ENSURE_CHANNELS "iuc,conda-forge,bioconda,imperial-college-research-computing,defaults"
ENV GALAXY_CONFIG_SANITIZE_ALL_HTML "False"
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL "True"
ENV GALAXY_CONFIG_CONDA_AUTO_INIT "True"

WORKDIR /galaxy-central

ADD tools.yaml $GALAXY_ROOT/tools.yaml

RUN install-tools $GALAXY_ROOT/tools.yaml

ADD welcome.html $GALAXY_CONFIG_DIR/web/welcome.html
ADD welcome_image001.jpg $GALAXY_CONFIG_DIR/web/welcome_image001.jpg
ADD welcome_image002.png $GALAXY_CONFIG_DIR/web/welcome_image002.png

RUN ln -s -f ~/miniconda3/bin/python3 /usr/bin/python3

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8080

CMD ["/usr/bin/startup"]
