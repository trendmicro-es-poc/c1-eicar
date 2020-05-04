FROM centos:6
LABEL maintainer "Iñaki Zárate <izapps@pm.me>"

RUN yum install -y wget

RUN mkdir /eicar_files
WORKDIR /eicar_files

RUN echo "Descargando ficheros EICAR"
ADD https://www.eicar.org/download/eicar.com.txt
ADD https://secure.eicar.org/eicar_com.zip
ADD https://secure.eicar.org/eicarcom2.zip

ENTRYPOINT sleep infinity
