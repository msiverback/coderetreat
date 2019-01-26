FROM ubuntu
RUN apt-get update
#install git
RUN apt-get install -y git
RUN apt-get install -y apt-utils
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
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN apt-get install -y curl

# Allow the host to use gradle cache, otherwise gradle will always download plugins & artifacts on every build
VOLUME ["/root/.gradle/caches/"]

# Download and install Gradle
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-2.5-bin.zip -o gradle-2.5-bin.zip && \
    unzip gradle-2.5-bin.zip && \
    rm gradle-2.5-bin.zip

# Export some environment variables
ENV GRADLE_USER_HOME=./.gradle/
ENV GRADLE_HOME=/usr/local/gradle-2.5
ENV PATH=$PATH:$GRADLE_HOME/bin

# setting up the dojo
RUN mkdir /coderetreat
ADD . /coderetreat
WORKDIR /coderetreat

#install haskell
RUN curl -sSL https://get.haskellstack.org/ | sh

CMD ["bash"]
