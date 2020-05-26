FROM centos:7
# RUN mkdir /demo_files
# COPY sample.jpg /demo_files

# WORKDIR /demo_files
# RUN echo "Descargando ficheros EICAR"
# ADD https://www.eicar.org/download/eicar.com.txt eicar.com.txt
# ADD https://secure.eicar.org/eicar_com.zip eicar_com.zip
# ADD https://secure.eicar.org/eicarcom2.zip eicarcom2.zip

RUN yum install -y wget

RUN echo "Downloading EICAR file" && \
    wget --no-check-certificate https://www.eicar.org/download/eicar.com.txt

ENTRYPOINT sleep infinity
