FROM grafana/grafana:4.4.2

RUN apt-get update && apt-get install -y curl gettext-base telnet supervisor nginx openssl && rm -rf /var/lib/apt/lists/*

WORKDIR /etc/grafana
COPY datasources ./datasources

WORKDIR /etc/grafana
COPY grafana.ini ./grafana.ini

WORKDIR /etc/grafana
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt -subj "/C=IN/ST=Karnataka/L=Bangalore/O=Grafana/OU=IT Department/CN=localhost"

RUN mkdir -p mkdir /opt/template/logs
ADD https://releases.hashicorp.com/consul-template/0.19.5/consul-template_0.19.5_linux_amd64.tgz /tmp/consul-template.tgz
RUN cd /tmp && tar xvfz /tmp/consul-template.tgz && mv consul-template /bin/consul-template 

WORKDIR /etc/nginx/sites-enabled
COPY default ./default

WORKDIR /etc/grafana
COPY grafana.ini.ctmpl ./grafana.ini.ctmpl

WORKDIR /etc/grafana
COPY config.hcl ./config.hcl
COPY start.sh ./start.sh
RUN chmod u+x start.sh
RUN mkdir -p /etc/supervisor/conf.d/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /app
COPY entrypoint.sh ./
RUN chmod u+x entrypoint.sh

WORKDIR /app
COPY dashboard.json ./
COPY add_dashboard.sh ./
RUN chmod u+x add_dashboard.sh

ENTRYPOINT ["/usr/bin/supervisord"]


