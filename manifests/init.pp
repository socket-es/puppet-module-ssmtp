# ssmtp is used to manage the /etc/ssmtp/ssmtp.conf file.

class ssmtp (
  $root,
  $mailhub          = 'mail',
  $port             = undef,
  $rewritedomain    = undef,
  $hostname         = undef,
  $fromlineoverride = undef,
  $usessl           = false,
  $usetls           = false,
  $usetlscert       = false,
  $tlscert          = undef,
  $debug            = false) {

  include ssmtp::params

  if $port == undef {
    if $usessl == true {
      $_mailhub = "${mailhub}:465"
    } else {
      $_mailhub = $mailhub
    }
  } else {
    $_mailhub = "${mailhub}:${port}"
  }

  package { $ssmtp::params::package: ensure => installed, }

  file { $ssmtp::params::conf:
    ensure  => file,
    require => Package[$ssmtp::params::package],
    content => template('ssmtp/ssmtp.conf.erb'),
  }
}
