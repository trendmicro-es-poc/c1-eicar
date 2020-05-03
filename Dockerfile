FROM ubuntu
LABEL maintainer "Iñaki Zárate <izapps@pm.me>"

RUN apt-get -y install wget

RUN echo "Descargando ficheros EICAR"
RUN wget --no-check-certificate https://www.eicar.org/download/eicar.com.txt
RUN wget --no-check-certificate https://secure.eicar.org/eicar_com.zip
RUN wget --no-check-certificate https://secure.eicar.org/eicarcom2.zip

ENTRYPOINT sleep infinity
