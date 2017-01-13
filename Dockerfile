FROM            centos:7
MAINTAINER      MIT Probabilistic Computing Project

RUN             yum -y -q update
RUN             yum -y -q upgrade

RUN             yum -y -q groupinstall "Development Tools"
RUN             yum -y -q install epel-release
RUN             yum -y -q install gcc
RUN             yum -y -q install python-devel
RUN             yum -y -q install python-pip

RUN             pip install -U pip
RUN             pip install virtualenv

RUN             virtualenv /venv
RUN             ln -s venv/bin/activate /

# Install third-party libraries needed for the handler

RUN             . /activate && pip install bayeslite
