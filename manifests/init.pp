class syslogng (
  $syslog_port    = undef,
  $syslog_domain  = undef,
  $remote_log_dir = undef,
  $master         = false,
  $client         = true,
  $chain_hostnames= undef,
  $time_reopen    = undef,
  $time_reap      = undef,
  $sync           = undef,
  $log_fifo_size  = '2048',
  $create_dirs    = 'yes',
  $owner          = undef,
  $group          = undef,
  $perm           = undef,
  $dir_owner      = undef,
  $dir_group      = undef,
  $dir_perm       = undef,
  $use_dns        = undef,
  $log_msg_size   = undef,
  $stats_freq     = '0',
  $bad_hostname   = '^gconfd$',
  $use_fqdn       = 'yes'
) {

    package { syslog-ng:
        ensure => installed
    }

    file { "syslog-ng.conf":
        path    => "/etc/syslog-ng/syslog-ng.conf",
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
