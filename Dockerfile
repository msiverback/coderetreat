FROM ubuntu
RUN apt-get update
#install git
RUN apt-get install -y git

run apt-get install -y tree

#install emacs
RUN apt-get install -y emacs

# install Ruby 
RUN apt-get install -y ruby bundler
RUN /bin/bash -l -c "gem install codersdojo"
RUN /bin/bash -l -c "gem install zip"
RUN /bin/bash -l -c "gem install rspec"

#install Python
RUN apt-get install -y python3

#install C
RUN apt-get install -y gcc
RUN apt-get install -y libcunit1 libcunit1-doc libcunit1-dev

#install java
RUN apt-get install -y default-jdk

# setting up the dojo
RUN mkdir /coderetreat
ADD . /coderetreat
WORKDIR /coderetreat

