FROM centos:7

RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    yum makecache

# utils
RUN yum install -y epel-release && \
  yum install -y unzip \
  which \
  make \
  wget \
  zip \
  bzip2 \
  gcc \
  gcc-c++ \
  curl-devel \
  autoconf \
  expat-devel \
  gettext-devel \
  openssl-devel \
  perl-devel \
  zlib-devel \
  python-pip \
  java-1.8.0-openjdk && \
  yum -y clean all --enablerepo='*'

RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz && \
    tar zxvf git-2.9.5.tar.gz && \
    cd git-2.9.5 && \
    make configure && \
    ./configure prefix=/usr/local/git/ && \
    make && \
    make install && \
    mv /usr/local/git/bin/git /usr/bin/ && \
    cd ..&& \
    rm -rf git-2.9.5.tar.gz git-2.9.5 && \
    git version

RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x jq-linux64 && \

    mv jq-linux64 /usr/bin/jq

RUN wget https://download.samba.org/pub/rsync/src/rsync-3.0.6.tar.gz && \
    tar -zxvf rsync-3.0.6.tar.gz    && \
    cd rsync-3.0.6 && \
    ./configure --prefix=/usr/local/rsync   && \
    make    && \
    make install    && \
    rm -rf rsync-3.0.6.tar.gz rsync-3.0.6


ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# USER jenkins
WORKDIR /home/jenkins

#ENV SONAR_SCANNER_VERSION 3.3.0.1492

#RUN curl -o sonar_scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
#    unzip sonar_scanner.zip && rm sonar_scanner.zip \
#    && rm -rf sonar-scanner-$SONAR_SCANNER_VERSION-linux/jre && \
#    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /home/jenkins/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin/sonar-scanner && \
#    mv /home/jenkins/sonar-scanner-$SONAR_SCANNER_VERSION-linux /usr/bin
#
#ENV PATH $PATH:/usr/bin/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin

COPY ./ ./
RUN chmod +x ./hack/install_utils.sh && ./hack/install_utils.sh && rm -rf ./*

CMD ["docker","version"]
