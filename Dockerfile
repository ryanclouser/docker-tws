FROM ubuntu:18.04
MAINTAINER Ryan Clouser (me@ryanclouser.com)

ENV DEBIAN_FRONTEND noninteractive
ENV USER docker
ENV DISPLAY :0
ENV ARGS ""
ENV PASSWORD "a"
ENV PROFILE ""
ENV VERSION "latest"

USER root

# Create docker user
RUN useradd -ms /bin/bash docker
WORKDIR /home/docker

# Update
RUN apt update && apt upgrade -qy && apt dist-upgrade -qy
RUN apt install wget ca-certificates tightvncserver fluxbox xterm xautomation -qy
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

# IB Gateway
USER docker
RUN wget -q https://download2.interactivebrokers.com/installers/tws/$VERSION-standalone/tws-$VERSION-standalone-linux-x64.sh
RUN chmod +x tws-$VERSION-standalone-linux-x64.sh && ./tws-$VERSION-standalone-linux-x64.sh -q && rm -f tws-$VERSION-standalone-linux-x64.sh

# Copy profile settings
USER root
COPY jts.ini /home/$USER/Jts/
RUN mkdir /home/$USER/Jts/$PROFILE
COPY tws.xml /home/$USER/Jts/$PROFILE/
COPY start.sh /home/$USER/
RUN chmod +x /home/$USER/start.sh
RUN chown $USER:$USER /home/$USER/Jts/jts.ini; chown $USER:$USER /home/$USER/start.sh; chown -R $USER:$USER /home/$USER/Jts/$PROFILE

# VNC
USER docker
RUN mkdir -p /home/$USER/.vnc
RUN set -xe && (echo $PASSWORD | vncpasswd -f > /home/$USER/.vnc/passwd)
RUN chmod 0600 /home/$USER/.vnc/passwd

EXPOSE 7496
EXPOSE 7497
EXPOSE 5900

CMD tightvncserver $DISPLAY -geometry 1920x1080; ./start.sh
