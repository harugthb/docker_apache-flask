################################################################## 
#                                                                #
# pull image                                                     #
#                                                                #
##################################################################

FROM centos:centos7


################################################################## 
#                                                                #
# set args in Dockerfile                                         #
#                                                                #
##################################################################

ARG PROJECT_ROOT_DIR="/var/www/projects"
ARG APPLICATION_DIR="test"
ARG WORK_DIR=${PROJECT_ROOT_DIR}


################################################################## 
#                                                                #
# install requirements                                           #
#                                                                #
##################################################################

## commonly used commands
RUN yum -y install which

## libs, httpd, etc..
RUN yum -y groupinstall "development tools"
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
RUN yum -y install  httpd-devel

## python3
RUN yum -y install python-devel
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u python36u-libs python36u-devel python36u-pip
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

## python modules
RUN pip3 install mod-wsgi=="4.6.5"
RUN pip3 install Flask=="1.0.2"


################################################################## 
#                                                                #
# distribute src                                                 #
#                                                                #
##################################################################

RUN mkdir -p ${PROJECT_ROOT_DIR}/${APPLICATION_DIR}
WORKDIR $WORK_DIR
COPY src/flask.conf /etc/httpd/conf.d/
COPY src/adapter.wsgi ${PROJECT_ROOT_DIR}/${APPLICATION_DIR}/
COPY src/run.py ${PROJECT_ROOT_DIR}/${APPLICATION_DIR}/


################################################################## 
#                                                                #
# start service                                                  #
#                                                                #
##################################################################

RUN systemctl enable httpd
CMD ["/sbin/init"]


################################################################## 
#                                                                #
# expose port                                                    #
#                                                                #
##################################################################

EXPOSE 8080
