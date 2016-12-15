FROM apolloclark/kali-linux-web-cli
MAINTAINER apolloclark@gmail.com

# install Gauntlt
COPY install_gauntlt.sh /root/install_gauntlt.sh
COPY run_gauntlt.sh /root/run_gauntlt.sh
RUN chmod +x /root/run_gauntlt.sh && \
    chmod +x /root/install_gauntlt.sh
    
RUN /root/install_gauntlt.sh
EXPOSE 8008

CMD ["/bin/bash", "-l"]
