FROM apolloclark/kali-linux-web-cli
MAINTAINER apolloclark@gmail.com

EXPOSE 8008
WORKDIR /root

# install Gauntlt
COPY . /root/gauntlt/
RUN chmod +x /root/gauntlt/run_gauntlt.sh && \
    chmod +x /root/gauntlt/install_gauntlt.sh && \
    /root/gauntlt/install_gauntlt.sh

# run Gauntlt
RUN /root/gauntlt/run_gauntlt.sh

CMD ["/bin/bash", "-l"]
