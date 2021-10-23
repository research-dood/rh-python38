FROM registry.access.redhat.com/ubi8/python-38 

# Add application sources with correct permissions for OpenShift 
USER 0 

# Install the dependencies 
RUN pip install # Run the application 

CMD python manage.py runserver 0.0.0.0:8080
