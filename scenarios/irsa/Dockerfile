FROM public.ecr.aws/amazonlinux/amazonlinux:2
LABEL maintainer="shiva"
RUN yum -y update && \
    yum -y install unzip curl shadow-utils && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip && \
    yum clean all
RUN useradd -m appuser && chown -R appuser:appuser /home/appuser
USER appuser
WORKDIR /home/appuser
RUN mkdir -p /home/appuser/.aws && chmod 700 /home/appuser/.aws
ENV S3_BUCKET_NAME=hdhgvjbjh
CMD ["sh", "-c", "aws s3 cp s3://$S3_BUCKET_NAME/ /home/appuser --recursive"]
