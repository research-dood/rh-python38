FROM ubuntu:latest 

EXPOSE 8080
USER 0 

RUN apt update &&\
    apt install libgeos-dev &&\
    apt install software-properties-common &&\
    apt install python3.8 &&\
    apt install python3-pip 
    
    
ENTRYPOINT ["python3"]



