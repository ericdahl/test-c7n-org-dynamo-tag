FROM python:3.7

RUN pip3 install c7n-org==0.5.4  c7n==0.8.45.0

ENV AWS_DEFAULT_REGION us-east-1

ADD ./c7n /c7n
ADD ./c7n-org /c7n-org