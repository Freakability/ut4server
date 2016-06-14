FROM debian:latest
MAINTAINER freakability@freakability.de

RUN apt-get update

# get the link for UTBUILD from https://forums.unrealtournament.com/showthread.php?12011-Unreal-Tournament-Pre-Alpha-Playable-Build
ENV UTBUILD=""

RUN groupadd -f ut
RUN useradd -g ut -d /home/ut -m -s /bin/bash ut
RUN apt-get -y install wget unzip; /usr/bin/wget $UTBUILD -O temp.zip; /usr/bin/unzip temp.zip -d /home/ut/; rm temp.zip

RUN chmod a+x /home/ut/LinuxServer/Engine/Binaries/Linux/* /home/ut/LinuxServer/UnrealTournament/Binaries/Linux/*
RUN chown -R ut:ut /home/ut/
WORKDIR /home/ut
USER ut

VOLUME ["/home/ut/LinuxServer/UnrealTournament/Saved/Config/LinuxServer"]
VOLUME ["/home/ut/LinuxServer/UnrealTournament/Saved/Logs"]

EXPOSE 7777/udp 14000/udp 7787/udp

# standalone server
#CMD ["/home/ut/LinuxServer/Engine/Binaries/Linux/UE4Server-Linux-Shipping","UnrealTournament","DM-DeckTest?Game=DM?MaxPlayers=20?MaxSpectators=15?maxreadywait=45?mutator=InstaGib","-log"]

# HUB
CMD ["/home/ut/LinuxServer/Engine/Binaries/Linux/UE4Server-Linux-Shipping","UnrealTournament","ut-entry?game=lobby?maxplayers=200","-log"]
