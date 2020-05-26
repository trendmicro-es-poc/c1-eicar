FROM centos:7

RUN mkdir /demo_files
COPY sample.jpg /demo_files

WORKDIR /demo_files

RUN echo "Descargando fichero EICAR"
ADD https://secure.eicar.org/eicarcom2.zip eicarcom2.zip

ENTRYPOINT sleep infinity
