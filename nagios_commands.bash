alias nagcon="ssh -t nagios.dishonline.com /usr/bin/nagcon -f /var/log/nagios/status.dat"

function nagios_cmd {
        export cmd=$1
        export host=$2
        export nagios_host=$3
        export line="[`date +%s`] $cmd\;$host"
        echo $line
        ssh ec2-user@$nagios_host "echo $line > /var/log/nagios/rw/nagios.cmd"
}

function nagios_disable {
        export host=$1
   		export nagios_host="nagios.dishonline.com"
        nagios_cmd DISABLE_HOST_SVC_NOTIFICATIONS $host $nagios_host
        nagios_cmd DISABLE_HOST_NOTIFICATIONS $host $nagios_host
}

function nagios_enable {
        export host=$1
   		export nagios_host="nagios.dishonline.com"
        nagios_cmd ENABLE_HOST_SVC_NOTIFICATIONS $host $nagios_host
        nagios_cmd ENABLE_HOST_NOTIFICATIONS $host $nagios_host
}

function nagios_downtime {
        # takes a host out of nagios for 2 hours of downtime
        export host=$1
  		export nagios_host="nagios.dishonline.com"
        export whoami=`whoami`
        export thedate=`date +%s`
        export nextdate=`date -v+2H +%s`
        nagios_cmd SCHEDULE_HOST_DOWNTIME "$host\;$thedate\;$nextdate\;1\;0\;7200\;$whoami\;Taking host $host down for two hours for maintenance" $nagios_host
        nagios_cmd SCHEDULE_HOST_SVC_DOWNTIME "$host\;$thedate\;$nextdate\;1\;0\;7200\;$whoami\;Taking host $host down for two hours for maintenance" $nagios_host
}

function nagios_acknowledge {
        # takes a host out of nagios for 2 hours of downtime
        export host=$1
        export service=$2
  		export nagios_host="nagios.dishonline.com"
        export whoami=`whoami`
        export thedate=`date +%s`
        export nextdate=`date -v+2H +%s`
        nagios_cmd ACKNOWLEDGE_SVC_PROBLEM "$host\;$service\;1\;1\;0\;$whoami\;ACK $host:$service is broken - working on it now" $nagios_host
}

function nagios_downtime_prod {
        nagios_downtime prod-appserv01
        nagios_downtime prod-appserv02
        nagios_downtime prod-appserv03
        nagios_downtime prod-appserv07
        nagios_downtime prod-appserv08
        nagios_downtime prod-appserv09
        nagios_downtime prod-appserv10
        nagios_downtime prod-appserv11
        nagios_downtime prod-appserv12
        nagios_downtime prod-appserv13
        nagios_downtime prod-appserv14
        nagios_downtime prod-appserv15
        nagios_downtime prod-appserv16
        nagios_downtime prod-appserv17
        nagios_downtime prod-appserv18
        nagios_downtime prod-secure01
        nagios_downtime prod-secure02
        nagios_downtime prod-secure03
        nagios_downtime prod-secure04
        nagios_downtime mapi-slave01
        nagios_downtime mapi-slave02
        nagios_downtime mapi-slave03
        nagios_downtime mapi-slave04
        nagios_downtime prod-dishonline-rds-slave-app1a
        nagios_downtime prod-dishonline-rds-slave-app2a
        nagios_downtime prod-dishonline-rds-slave-app1
        nagios_downtime prod-dishonline-rds-slave-app2
        nagios_downtime prod-dishonline-rds-slave-app3
        nagios_downtime prod-dishonline-rds-slave-app4
        nagios_downtime prod-mapi-haproxy
        nagios_downtime prod-mapi-memcache01
        nagios_downtime prod-cron
}

alias nag-disable="nagios_disable $1"
alias nag-enable="nagios_enable $1"
alias nag-downtime="nagios_downtime $1"
alias nag-downtime-prod="nagios_downtime_prod"

alias nag-ack="nagios_acknowledge $1 $2"
