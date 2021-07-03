FROM openjdk:8-jre-alpine
WORKDIR /minecraft-server

EXPOSE 25565 

RUN apk update && \
    apk upgrade -a || apk fix && \
    apk add curl bash bash-completion vim tar rsync && \
    rm -rf /var/cache/apk/*

ENV MINECRAFT_VERSION 1.16.5
ENV FORGE_VERSION 36.1.4
ENV FORGE_URL http://files.minecraftforge.net/maven/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar

RUN curl --create-dirs -sLo ./forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar ${FORGE_URL} && \
    mkdir mods && \
    mkdir config && \
    mkdir global_data_packs && \
    mkdir scripts && \
    mkdir scripts && \
    java -jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar --installServer && \
    rm -f forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar.log

COPY tmp/BetterMinecraftServerFORGE/mods/* ./mods
COPY tmp/BetterMinecraftServerFORGE/config/* ./config
COPY tmp/BetterMinecraftServerFORGE/global_data_packs/* ./global_data_packs
COPY tmp/BetterMinecraftServerFORGE/scripts/* ./scripts
COPY tmp/BetterMinecraftServerFORGE/server.properties .
COPY tmp/BetterMinecraftServerFORGE/server-icon.png .
COPY tmp/BetterMinecraftServerFORGE/eula.txt .

ENTRYPOINT java -Xmx5G -Xms5G -jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}.jar nogui