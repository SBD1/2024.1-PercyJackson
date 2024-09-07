FROM ubuntu:20.04

RUN apt-get update && apt-get install python3 python3-pip -y
RUN pip3 install --upgrade pip
WORKDIR /app

COPY ./requirements.txt /app/requirements.txt

RUN pip3 install -r requirements.txt

COPY ./src /app/src

WORKDIR /app/src

COPY ./src/main.py /app/src
