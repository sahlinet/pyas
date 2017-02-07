FROM philipsahli/centos:latest

RUN yum install -y postgresql-devel python-virtualenv libevent-devel gcc libffi-devel openssl-devel wget tar sudo sqlite-devel make

# Add Custom Python Installation
RUN curl -O https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz && tar -zxf Python-* && cd Python-* && ./configure --prefix=/usr/local --enable-unicode=ucs4 && make && make install && cd .. && rm -rf Python*

RUN /usr/local/bin/python -V

RUN wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz && tar -xvf setuptools-1.4.2.tar.gz && cd setuptools-1.4.2 && /usr/local/bin/python2.7 setup.py install && cd .. && rm -rf setuptools*
RUN curl https://bootstrap.pypa.io/get-pip.py | /usr/local/bin/python2.7 -

RUN /usr/local/bin/pip install virtualenv

# nginx
RUN yum install -y yum-utils && yum-config-manager --save --setopt=epel.skip_if_unavailable=true && yum install -y moreutils pwgen
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && yum -y install nginx

RUN yum remove -y postgresql-devel libevent-devel gcc openssl-devel wget make && yum clean all
