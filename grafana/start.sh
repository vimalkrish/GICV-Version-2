#!/usr/bin/env sh
/bin/consul-template -consul-addr 'consul:8500' -template '/etc/grafana/grafana.ini.ctmpl:/etc/grafana/grafana.ini' 
