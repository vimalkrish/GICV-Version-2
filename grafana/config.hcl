//config.hcl
consul  { "consul:8500" }
token { "abcd1234" }

template {
  source = "/etc/grafana/grafana.ini.ctmpl"
  destination = "/etc/grafana/grafana.ini"
}
