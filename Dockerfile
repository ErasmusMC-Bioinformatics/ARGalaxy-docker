FROM bgruening/galaxy-stable:18.09

RUN apt update
RUN apt install -y bc

# For changeo/python3
ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh miniconda3.sh
RUN bash miniconda3.sh -b -p ~/miniconda3
RUN ln -s -f ~/miniconda3/bin/python3 /usr/bin/python3

# fix lsb_release
RUN sed -i 's%/usr/bin/python3%/usr/bin/python2.7%g' /usr/bin/lsb_release

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

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8080

CMD ["/usr/bin/startup"]