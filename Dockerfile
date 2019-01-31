FROM bgruening/galaxy-stable:18.09

RUN apt update
RUN apt install -y bc

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