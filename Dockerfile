# Set the base image to Ubuntu
FROM ubuntu:14.04


# Update the repository sources list
RUN apt-get update

################## BEGIN INSTALLATION ######################
# Install opejdk
RUN apt-get install -y default-jdk

# install git and maven
RUN  apt-get install -y  git maven


# Create the default data directory
RUN mkdir -p /data/

# switch to new directory

WORKDIR /data

# perform git clone
RUN git clone https://github.com/shrikantjk/HclWebApp.git

# switch to HclWebApp directory
WORKDIR /data/HclWebApp

# use maven to package
RUN mvn package

 
# install tomcat7
RUN apt-get install -y tomcat7

# switch to HclWebApp directory
WORKDIR /data/HclWebApp/target/

# copy war file
RUN cp /data/HclWebApp/target/HclWebApp.war /var/lib/tomcat7/webapps/



# Expose the default port
EXPOSE 8080

# Default port to execute the entrypoint 
CMD ["--port 8080"]

# Set default container command
ENTRYPOINT /bin/bash


##################### INSTALLATION END #####################
