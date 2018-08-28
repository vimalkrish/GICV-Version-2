
Docker – Grafana – InfluxDB – Consul-Template – Consul – Git2Consul – Vault

The above application are experimented in Mac Docker engine

Docker Code Repo: https://github.com/vimalkrish/GICV-Version-2

Git2consul Repo: https://github.com/vimalkrish/git2consul_data


*Enabled Https for Grafana

*disabled grafana Signup

*Created dashboard via JSON file

*Manage Grafana Configuration in Consul using Consul-template

*Manage Consul Key/Value in git2consul 

*store the secret keys in Vault


Grafana login stored in Vault

Grafana Login:

https://127.0.0.1

user: admin

password: admin

-----------------

InfluxDB database

Database: influx

User: admin

Password: admin

------------------

To start the docker containers

Clone the git repository

#git clone git@github.com:vimalkrish/GICV-Version-2.git

#cd GICV-Version-2/grafana

#docker compose up -d

Now you can see 5 container running
1 – Consul
2 – Grafana, consul-template
3 – Vault
4 – influxdb
5 – git2consul

Check all the services are started

#docker ps

Applications:
Grafana: https://127.0.0.1
InfluxDB Server: 127.0.0.1 Port: 8086
Consul Server: http://127.0.0.1:8500
Vault Server: 127.0.0.1 port: 8200

Vault key and Token

Unseal Key 1: 59FY/8cK6psyRFtsywxINKfGlvod7Nzl4YXeY8IDABJx

Unseal Key 2: KQv6dfT6zHxix9wgz3YxWBdgRAXdfeoiz6pigh8qNmdZ

Unseal Key 3: HLZtZ004U19s6gy3h1gBxWZUDLUTDqN4/5H0MkM1LibO

Unseal Key 4: XDy2vhx6P1oE3bKD416bV5hxWfvMmw6jUpmvLWVzJ/nK

Unseal Key 5: AyHJKldJfziPiYULVtmeAyy3VqBeZoZBF1qr9XI3KrvT

Initial Root Token: 533a50d5-b0b2-f98e-c2d2-d94217de977e

Login to vault container and initialize it

#vault init

Unseal Vault using 3 keys

#vault operator unseal

#vault operator unseal

#vault operator unseal

Init the root token

#vault login

From the host environment (i.e. outside of the docker image):

#alias vault='docker exec -it CONTAINER-ID vault "$@"'

#vault read secret/grafana



--------------------------------------------------------------------
Telegraf

Install telegraf in local laptop and send the metrics to InfluxDB

Command to Install in MAC

brew install telegraf

update the configuration file /usr/local/etc/telegraf.conf

add the url “http://localhost:8086” and Read metrics, cpu, memory and disk

once the influxdb container is up, start the telegraf service

#telegraf -config /usr/local/etc/telegraf.conf

--------------------------------------------------------------------

Consul

Consul is a distributed service mesh to connect, secure, and configure services across any runtime platform and public or private cloud

In this project consul container is used for configuration management and KV

Create the directory /consul/config/

Create the configuration file /consul/config/config.json

--------------------------------------------------------------------

Vault:

It is to store secures, stores, and tightly controls access to tokens, passwords, certificates, API keys

Our Grafana secrets are stored in vault container

Used file backed storage /vault/file

Configuration File /vault/config/vault.json

Update the configuration file 

--------------------------------------------------------------------

Grafana:

Data visualization & Monitoring with support for Graphite, InfluxDB, Prometheus, Elasticsearch and many more databases.

In our project Grafana and consul template running in same container

Grafana conf file /etc/Grafana/“grafana.ini”

Template file /etc/Grafana/“grafana.ini.ctmpl”

Used Nginx for SSL 

/etc/nginx

/etc/nginx/sites-enabled/default

Certificates stored in 

/ etc/nginx/cert.crt
/etc/nginx/cert.key

Supervisor -
Used supervisor to run the services

Configuration file -> /etc/supervisor/conf.d/supervisord.conf


Consul-template command

#/bin/consul-template -consul-addr 'consul:8500' -template '/etc/grafana/grafana.ini.ctmpl:/etc/grafana/grafana.ini'

--------------------------------------------------------------------

InfluxDB

InfluxDB is an open-source time series database developed written in Go by InfluxData. InfluxDB is optimized for fast, high-availability storage and retrieval of time series data for metrics analysis

Created a Database and user

user=admin
password=admin
database=influx


--------------------------------------------------------------------

Troubleshooting:

If the git2consul container is not up, please run "docker-compose up -d" once again to bring it up

I have tried this task in Mac Laptop Docker engine, please use "localhost" for all configurations


--------------------------------------------------------------------

 



