class icinga::plugins::checkiostat {
  $package_deps = 'sysstat'
  $package_name = $::operatingsystem ? {
    /CentOS|RedHat/ => 'nagios-plugins-iostat',
    /Debian|Ubuntu/ => 'nagios-plugin-check-iostat',
  }

  package {
    $package_deps:
      ensure => present;

    $package_name:
      ensure => present;
  }

  file {
    "${::icinga::includedir_client}/iostat.cfg":
      ensure  => present,
      notify  => Service[$icinga::service_client],
      require => Package[$package_name],
      content => template('icinga/plugins/iostat.cfg.erb');
  }
}
