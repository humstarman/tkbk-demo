FROM python:3.7
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y python-pip
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc 
RUN mkdir /workspace
WORKDIR /workspace
ADD ./manifest /workspace/
ADD ./scripts /workspace/scripts/
