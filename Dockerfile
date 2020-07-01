FROM centos:6

RUN mkdir /demo_files
COPY sample.jpg /demo_files
COPY eicar_com.zip /demo_files

WORKDIR /demo_files


ENTRYPOINT sleep infinity
