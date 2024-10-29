FROM amazonlinux
MAINTAINER shiva
RUN yum update -y
RUN yum -y install python3-pip
RUN pip3 install boto3
RUN pip3 install requests
RUN yum install unzip -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
ENV GOLD_API_ACCESS_TOKEN
COPY config /root/.aws/
COPY credentials /root/.aws/

COPY gold-market-price.py .
CMD ["python3","gold-market-price.py"]
