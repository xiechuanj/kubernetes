FROM xiechuan/oraclejdk131:1.0.0
MAINTAINER xiechuan  <xiechuanj@gmail.com>

COPY *.py ./
RUN  python get-pip.py && rm -rf get-pip.py
RUN  pip install -U django djangorestframework
WORKDIR /root
RUN git clone https://github.com/xiechuanj/apiDjangoDemo.git
WORKDIR /root/apiDjangoDemo/src
CMD python manage.py runserver 0.0.0.0:8000
