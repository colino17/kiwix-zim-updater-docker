FROM alpine:latest

# ENVIRONMENT
ENV SCRIPT_FLAGS="-d -u -w -c -S"
ENV TZ="Canada/Atlantic"

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates coreutils gnutls-utils curl wget grep bash tzdata

# TIMEZONE
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ADD SCRIPT
RUN wget https://raw.githubusercontent.com/jojo2357/kiwix-zim-updater/main/kiwix-zim-updater.sh -O /kiwix-zim-updater.sh
RUN chmod +x /kiwix-zim-updater.sh

# VOLUMES
VOLUME /zim

# CRON
ADD crontab /
RUN crontab crontab

# CMD
CMD ["crond", "-f"]
