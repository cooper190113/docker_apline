FROM alpine:3.8
LABEL maintainer="cmcc"

RUN echo "https://mirrors.aliyun.com/alpine/v3.8/main" > /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.8/community" >> /etc/apk/repositories

WORKDIR /service

ENV JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk"
ENV PATH $PATH:$JAVA_HOME/bin

RUN set -x ; \
	addgroup -g 10050 zabbix ; \
	adduser -S -D -H -h /dev/null -s /sbin/nologin -G zabbix -u 10050 zabbix ;\
	echo '%zabbix ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers ; \
	addgroup -g 10051 www-data ; \
	adduser -S -D -H -h /dev/null -s /sbin/nologin -G www-data -u 10051 www-data ;\
	echo '%www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers ; \
	addgroup -g 10052 vnfadmin ; \
	adduser -S -D -H -h /dev/null -s /sbin/nologin -G vnfadmin -u 10052 vnfadmin ;\
	echo '%vnfadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers ; \
    apk --no-cache upgrade ; \
	apk --no-cache add \
		bash \
		openssl \
		openrc \
		nano \
		vim \
		g++ make \
		nodejs \
		npm \
		bzip2 \
		curl \
		grep \
		less \
		sudo \
		tzdata \
		wget \
		openjdk8 && rm -rf /tmp/* /var/cache/apk/* \
		; \
	rm -rf /var/cache/apk/* ; \
	rm -rf /etc/logrotate.d/acpid ; \
	cp -R /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
	echo 'Asia/Shanghai' > /etc/timezone ; \
	curl -sL https://rpm.nodesource.com/setup_6.x
	
# Set up tomcat
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.30/bin/apache-tomcat-8.5.30.tar.gz && tar --strip-components=1 -xf apache-tomcat-8.5.30.tar.gz && rm -f apache-tomcat-8.5.30.tar.gz && rm -rf webapps && mkdir -p webapps/ROOT
RUN echo 'export CATALINA_OPTS="$CATALINA_OPTS -Xms64m -Xmx256m -XX:MaxPermSize=64m"' > /service/bin/setenv.sh
ENV CATALINA_HOME /service

EXPOSE 8080
#ENTRYPOINT ["./bin/startup.sh"]
CMD ["sh","./bin/catalina.sh", "-g", "daemon off;"]
#ADD instance-run.sh .
#CMD [ "./instance-run.sh" ]
