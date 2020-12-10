FROM nwnxee/unified
RUN apt-get update \
	&& apt-get -y install gpg-agent \
	&& wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
	&& echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list \
	&& apt-get update \
    && apt-get -y install --no-install-recommends lib32z1 vim apache2 php5.6 php5.6-mysql php5.6-mcrypt screen expect cron zip unzip \
    && apt-get -y install --no-install-recommends python3 python3-flask python3-flask-restful libapache2-mod-wsgi-py3 \
    && mkdir -p /var/lock/apache2 /var/run/apache2 \
    && touch /var/log/cron.log

#CMD ["cron"]
COPY 000-default.conf /etc/apache2/sites-available/
COPY php.ini /etc/php/5.6/apache2/
COPY start-apache.sh /usr/bin/
RUN chmod 777 /usr/bin/start-apache.sh
RUN chown www-data.www-data /usr/bin/start-apache.sh
RUN chown -R www-data.www-data /nwn
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
NWN_ARCH=linux-x86 \
NWN_TAIL_LOGS=n \
NWN_EXTRA_ARGS= \
MONO_VERSION=5.16.0.179 \
APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 \
NWNX_CORE_LOAD_PATH=/nwn/nwnx/ \
NWN_LD_PRELOAD=/nwn/nwnx/NWNX_Core.so \
NWNX_SERVERLOGREDIRECTOR_SKIP=n \
NWNX_CORE_LOG_LEVEL=7 \
NWNX_SERVERLOGREDIRECTOR_LOG_LEVEL=6 \
NWNX_JVM_CLASSPATH=/nwn/nwnx/org.nwnx.nwnx2.jvm.jar \
NWNX_ADMINISTRATION_SKIP=y \
NWNX_BEHAVIOURTREE_SKIP=y \
NWNX_CHAT_SKIP=y \
NWNX_CREATURE_SKIP=n \
NWNX_DAMAGE_SKIP=y \
NWNX_DATA_SKIP=y \
NWNX_DIALOG_SKIP=y \
NWNX_EVENTS_SKIP=y \
NWNX_ITEM_SKIP=y \
NWNX_JVM_SKIP=y \
NWNX_LUA_SKIP=y \
NWNX_METRICS_INFLUXDB_SKIP=y \
NWNX_MONO_SKIP=y \
NWNX_OBJECT_SKIP=n \
NWNX_PLAYER_SKIP=n \
NWNX_PROFILER_SKIP=y \
NWNX_SPELLCHECKER_SKIP=y \
NWNX_REDIS_SKIP=y \
NWNX_RUBY_SKIP=y \
NWNX_SQL_SKIP=n \
NWNX_THREADWATCHDOG_SKIP=y \
NWNX_TIME_SKIP=y \
NWNX_TRACKING_SKIP=y \
NWNX_TWEAKS_SKIP=y \
NWNX_UTIL_SKIP=y \
NWNX_WEAPON_SKIP=y \
NWNX_WEBHOOK_SKIP=y \
NWN_DMPASSWORD= \
NWN_RELOADWHENEMPTY=1 \
NWN_PAUSEANDPLAY=0 \
NWN_PUBLICSERVER=1 \
NWN_PORT=5121 \
NWN_SERVERNAME= \
NWNX_SQL_DATABASE= \
NWNX_SQL_PASSWORD= \
NWNX_SQL_USERNAME= \
NWNX_SQL_HOST= \
NWNX_SQL_TYPE=MYSQL 
#CMD ["/usr/bin/apache2"]
ENTRYPOINT ["/bin/bash", "/usr/bin/start-apache.sh"]
#ENTRYPOINT ["/bin/bash", "/usr/sbin/cron", "&&",  "apache2ctl", "-D", "FOREGROUND"]
#ENTRYPOINT ["/bin/bash", "/nwn/run-server.sh"]
