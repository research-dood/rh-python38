FROM ubuntu:latest 

EXPOSE 8080
USER 0 

RUN apt update -y &&\
    apt install -y libgeos-dev &&\
    apt install -y software-properties-common &&\
    apt install -y python3.8 &&\
    apt install -y python3-pip &&\
    apt install -y git &&\
    mkdir /home/data_from_repo && git clone 
    





