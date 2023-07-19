FROM python:3.10-slim

ARG NB_USER=pdfplumber
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

RUN apt-get -q update && apt-get -qy dist-upgrade
RUN apt-get -qy install gcc

COPY . ${HOME}
RUN pip install --no-cache --upgrade pip
RUN pip install -r ${HOME}/config/requirements.txt
RUN pip install --no-cache -U "jupyter-server<2.0.0"

RUN chown -R ${NB_UID} ${HOME}
WORKDIR ${HOME}
USER ${USER}
