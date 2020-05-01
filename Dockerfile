FROM centos
LABEL maintainer "Iñaki Zárate <izapps@pm.me>"

RUN yum install -y wget

RUN echo "Descargando ficheros EICAR" && \
    wget --no-check-certificate https://www.eicar.org/download/eicar.com.txt \
    wget --no-check-certificate https://secure.eicar.org/eicar_com.zip \
    wget --no-check-certificate https://secure.eicar.org/eicar_com2.zip

ENTRYPOINT sleep infinity
