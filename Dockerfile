FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive
# Add Sury PHP repository for PHP 7.4 support on Debian 12
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt -y install curl wget gnupg2 lsb-release ca-certificates apt-transport-https software-properties-common && \
  curl https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/php.gpg && \
  sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
  apt-get update

RUN \
  apt -y install build-essential git curl wget libnewt-dev libssl-dev \
  libncurses5-dev subversion libsqlite3-dev libjansson-dev libxml2-dev uuid-dev \
  default-libmysqlclient-dev htop sngrep lame ffmpeg mpg123
RUN \
  apt -y install git vim curl wget libnewt-dev libssl-dev libncurses5-dev \
  subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev expect
# install php
RUN \
  apt -y install build-essential openssh-server apache2 cron \
  mariadb-client bison flex php7.4 php7.4-curl php7.4-cli php7.4-common php7.4-mysql php7.4-gd \
  php7.4-mbstring php7.4-intl php7.4-xml php-pear curl sox libncurses5-dev libssl-dev mpg123 unzip\
  libxml2-dev libnewt-dev sqlite3 libsqlite3-dev pkg-config automake libtool autoconf git \
  unixodbc-dev uuid uuid-dev libasound2-dev libogg-dev libvorbis-dev libicu-dev libcurl4-openssl-dev \
  odbc-mariadb libical-dev libneon27-dev libsrtp2-dev libspandsp-dev sudo subversion libtool-bin \
  python-dev-is-python3 unixodbc vim wget libjansson-dev software-properties-common nodejs npm ipset iptables fail2ban php-soap libapache2-mod-php7.4
# install asterisk for 16.30
RUN \
   wget -O /usr/src/asterisk-16.30.0.tar.gz https://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-16.30.0.tar.gz && \
  tar xvf /usr/src/asterisk-16.30.0.tar.gz -C /usr/src/ && \
  cd /usr/src/asterisk-16.30.0/ && \ 
  contrib/scripts/get_mp3_source.sh && \
  contrib/scripts/install_prereq install && \
  ./configure --libdir=/usr/lib64 --with-pjproject-bundled --with-jansson-bundled && \
  make menuselect.makeopts && \
  menuselect/menuselect --enable app_macro menuselect.makeopts && \
  make menuselect && \
  make && \
  make install && \
  make samples && \
  make config && \
  ldconfig
# create user asterisk and permissions
RUN \
  groupadd asterisk && \
  useradd -r -d /var/lib/asterisk -g asterisk asterisk && \
  usermod -aG audio,dialout asterisk && \
  chown -R asterisk:asterisk /etc/asterisk && \
  chown -R asterisk:asterisk /var/lib/asterisk && \
  chown -R asterisk:asterisk /var/log/asterisk && \
  chown -R asterisk:asterisk /var/spool/asterisk && \
  chown -R asterisk:asterisk /usr/lib64/asterisk  && \
  sed -i 's|#AST_USER|AST_USER|' /etc/default/asterisk && \ 
  sed -i 's|#AST_GROUP|AST_GROUP|' /etc/default/asterisk && \
  sed -i 's|;runuser|runuser|' /etc/asterisk/asterisk.conf && \
  sed -i 's|;rungroup|rungroup|' /etc/asterisk/asterisk.conf && \
  echo "/usr/lib64" >> /etc/ld.so.conf.d/x86_64-linux-gnu.conf && \
  ldconfig
# configure apache server
RUN \
  sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.4/apache2/php.ini && \
  sed -i 's/\(^memory_limit = \).*/\1256M/' /etc/php/7.4/apache2/php.ini && \
  sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf && \
  sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf && \
  a2enmod rewrite && \
  a2enmod php7.4 && \
  rm /var/www/html/index.html
# configure odbc
COPY odbc.ini /etc/odbc.ini
COPY odbcinst.ini /etc/odbcinst.ini
# configure ssl
COPY ./default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN \
    a2ensite default-ssl && \
    a2enmod ssl
# install freepbx fix for 16.0  
RUN \
  wget -O /usr/local/src/freepbx-16.0-latest.tgz http://mirror.freepbx.org/modules/packages/freepbx/7.4/freepbx-16.0-latest.tgz && \
  tar zxvf /usr/local/src/freepbx-16.0-latest.tgz -C /usr/local/src && \
  rm /usr/src/asterisk-16.30.0.tar.gz && \
  rm /usr/local/src/freepbx-16.0-latest.tgz && \
  apt-get clean
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

#for localhost ssl
RUN mkdir /etc/apache2/certs -p
RUN \
    openssl req -x509 -newkey rsa:4096 \
    -keyout /etc/apache2/certs/server.key \
    -out /etc/apache2/certs/server.crt \
    -sha256 -days 365 -nodes -subj "/C=US/ST=State/L=City/O=Org/CN=localhost"

######################################################################################################
ARG UNIMRCP_USER
ARG UNIMRCP_PASS

RUN mkdir -p /etc/apt/auth.conf.d \
    && echo "machine unimrcp.org login ${UNIMRCP_USER} password ${UNIMRCP_PASS}" > /etc/apt/auth.conf.d/unimrcp.conf \
    && chmod 600 /etc/apt/auth.conf.d/unimrcp.conf \
    && echo "deb [arch=amd64 trusted=yes] https://unimrcp.org/repo/apt/ focal main asterisk-16" > /etc/apt/sources.list.d/unimrcp.list \
    # 加入 dpkg 的強制選項：--force-confold 會自動幫您保留舊檔！
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        --allow-unauthenticated \
        unimrcp-client \
        asterisk-app-unimrcp \
        asterisk-res-speech-unimrcp 
#    && rm -rf /var/lib/apt/lists/* \
#    && rm -f /etc/apt/auth.conf.d/unimrcp.conf

#res_speech_unimrcp.so  搭配/opt/unimrcp/conf/unimrcpclient.xml     (缺檔案會造成無法載入)
# app_unimrcp.so    搭配 /etc/asterisk/mrcp.conf  (缺檔案會造成無法載入)
COPY ./unimrcpclient.xml /opt/unimrcp/conf/unimrcpclient.xml
COPY ./mrcp.conf /etc/asterisk/mrcp.conf
######################################################################################################

#VOLUME [ "/var/lib/asterisk", "/etc/asterisk", "/usr/lib64/asterisk", "/var/www/html", "/var/log/asterisk" ]

#EXPOSE 443 4569 4445 5060 5060/udp 5160/udp 18000-18100/udp

CMD ["/run-httpd.sh"]

