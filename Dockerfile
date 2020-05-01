FROM centos
LABEL maintainer "Iñaki Zárate <izapps@pm.me>"

RUN yum install -y wget

RUN echo "Descargando ficheros EICAR"
RUN wget --no-check-certificate https://www.eicar.org/download/eicar.com.txt
RUN wget --no-check-certificate https://secure.eicar.org/eicar_com.zip
RUN wget --no-check-certificate https://secure.eicar.org/eicarcom2.zip

ENTRYPOINT sleep infinity
