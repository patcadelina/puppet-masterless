# Class: cron_puppet
#
# This class enables puppet to run masterless.
#
# Parameters: N/A
#
# Actions:
#   - Create git hook
#   - Run `puppet apply` when there are changes
#
# Requires: N/A
#
# Sample Usage:
#   include cron_puppet
#
class cron_puppet {
    file { 'post-hook':
        ensure => file,
        path   => '/etc/puppet/.git/hooks/post-merge',
        source => 'puppet:///modules/cron-puppet/post-merge',
        mode   => '0755',
        owner  => root,
        group  => root,
    }
    cron { 'puppet-apply':
        ensure  => present,
        command => 'cd /etc/puppet ; /usr/bin/git pull',
        user    => root,
        minute  => '*/30',
        require => File['post-hook'],
    }
}
