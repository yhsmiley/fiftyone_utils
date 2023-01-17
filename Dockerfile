# docker build -t fiftyone .

# FROM ubuntu:18.04
FROM ubuntu:20.04

ENV cwd="/home/"
WORKDIR $cwd

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt -y update

RUN apt-get install -y \
    software-properties-common \
    build-essential \
    libcurl4 \
    openssl

# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata python3-tk

# upgrade python to version 3.8 (IMPT: remove python3-dev and python3-pip if already installed)
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get install -y python3.8-dev python3.8-venv python3-pip
RUN apt -y update
# Set python3.8 as the default python
RUN python3.8 -m venv /venv
ENV PATH=/venv/bin:$PATH

RUN apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && apt-get -y autoremove

RUN rm -rf /var/cache/apt/archives/

### APT END ###

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir --upgrade setuptools wheel

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# # add a new user "user"
# RUN useradd user
# # change to non-root privileges
# USER user
