class syslog-ng {

    package { syslog-ng:
        ensure => installed
    }

    file { "syslog-ng.conf":
        name => "/etc/syslog-ng/syslog-ng.conf",
        require => Package["syslog-ng"],
        content => template("syslog-ng/syslog-ng-client.conf.erb"),
    }

    service { syslog-ng:
        require => [ File["syslog-ng.conf"], Package["syslog-ng"] ],
        subscribe => File["syslog-ng.conf"],
        enable => true,
        ensure => running
    }
}
