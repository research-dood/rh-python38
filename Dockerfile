FROM registry.access.redhat.com/ubi8/python-38 

 
USER 0 

# Install the dependencies 
RUN pip3 install pandas 


