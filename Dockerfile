# docker build -t fiftyone .

FROM ubuntu:18.04

ENV cwd="/home/"
WORKDIR $cwd

RUN apt-get -y update
# RUN apt-get -y upgrade
RUN apt -y update

RUN apt-get install -y \
    software-properties-common \
    build-essential \
    libcurl4 \
    openssl \
    python3-dev \
    python3-pip

RUN apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && apt-get -y autoremove

RUN rm -rf /var/cache/apt/archives/

### APT END ###

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir --upgrade setuptools wheel

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt
