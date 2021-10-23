FROM registry.access.redhat.com/ubi8/python-38 

EXPOSE 8080
USER 0 

####
# This Dockerfile is used in order to build a container that runs the Spring Boot application
#
# Build the image with:
#
# docker build -f docker/Dockerfile -t python/sample-basic .
#
# Then run the container using:
#
# docker run -i --rm -p 8081:8081 python/sample-basic
####

WORKDIR /projects

RUN python3 -m venv venv
RUN . venv/bin/activate

# optimize image caching
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8081
CMD [ "waitress-serve", "--port=8081", "app:app"]


