FROM redis:3.2-alpine  
#RUN  mkdir -p  /opt/k8s-redis
#ENV "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"


COPY ["redis.conf", "/opt/k8s-redis/"] 


COPY ["docker-entrypoint.sh", "/usr/local/bin/"]


RUN chmod +x /usr/local/bin/docker-entrypoint.sh
#ENTRYPOINT ["docker-entrypoint.sh"]
