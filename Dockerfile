# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

USER $NB_UID

ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info
# --jars /home/jovyan/graphframes-0.7.0-spark2.4-s_2.11.jar --py-files /home/jovyan/graphframes-0.7.0-spark2.4-s_2.11.jar
# ENV PYSPARK_SUBMIT_ARGS --master local[*] pyspark-shell --jars /home/jovyan/graphframes-0.7.0-spark2.4-s_2.11.jar --py-files /home/jovyan/graphframes-0.7.0-spark2.4-s_2.11.jar

RUN conda install --quiet --yes 'conda-forge::neo4j-python-driver'  && \
    pip install graphframes && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

COPY graphframes-0.7.0-spark2.4-s_2.11.jar /home/$NB_USER/graphframes-0.7.0-spark2.4-s_2.11.jar
COPY graphframes-0.7.0-spark2.4-s_2.11.jar /usr/local/spark/jars
