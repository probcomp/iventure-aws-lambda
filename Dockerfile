FROM            centos:7
MAINTAINER      MIT Probabilistic Computing Project

RUN             yum -y -q update
RUN             yum -y -q upgrade

RUN             yum -y -q groupinstall "Development Tools"
RUN             yum -y -q install epel-release
RUN             yum -y -q install gcc
RUN             yum -y -q install git
RUN             yum -y -q install python-devel
RUN             yum -y -q install python-pip

RUN             pip install -U pip
RUN             pip install virtualenv

RUN             virtualenv /venv
RUN             ln -s venv/bin/activate /

RUN             . /activate && pip install Cython
RUN             . /activate && pip install numpy

# Install third-party libraries needed for the handler

RUN             cd /root && git clone http://github.com/probcomp/cgpm
RUN             . /activate && cd /root/cgpm && python setup.py build && pip install .

RUN             cd /root && git clone http://github.com/probcomp/crosscat
RUN             . /activate && cd /root/crosscat && python setup.py build && pip install .

RUN             cd /root && git clone http://github.com/probcomp/bayeslite-apsw
RUN             . /activate && cd /root/bayeslite-apsw && python setup.py build && pip install .

RUN             cd /root && git clone http://github.com/probcomp/bayeslite
RUN             . /activate && cd /root/bayeslite && python setup.py build && pip install .
