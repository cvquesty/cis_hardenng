require 'spec_helper'

describe 'cis_hardening::services::special' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      # Check for main class
      it {
        is_expected.to contain_class('cis_hardening::services::special')
      }

      # 2.2.1 - Time Synchronization
      # Ensure Time Synchronization is in use - Section 2.2.1.1
      it {
        is_expected.to contain_package('ntp').with(
          'ensure' => 'present',
        )
      }
      
      # Ensure ntp is configured - Section 2.2.1.3
      it {
        is_expected.to contain_file('/etc/ntp.conf').with(
          'ensure'  => 'present',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/cis_hardening/etc_ntp_conf',
        ).that_requires('Package[ntp]')
      }

      it {
        is_expected.to contain_file('/etc/sysconfig/ntpd').with(
          'ensure'  => 'present',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'source'  => 'puppet:///modules/cis_hardening/etc_sysconfig_ntpd',
        ).that_requires('File[/etc/ntp.conf]')
      }

      it {
        is_expected.to contain_file_line('ntp_options').with(
          'ensure' => 'present',
          'path'   => '/usr/lib/systemd/system/ntpd.service',
          'line'   => 'ExecStart=/usr/sbin/ntpd -u ntp:ntp $OPTIONS',
          'match'  => '^ExecStart=/usr/sbin/ntpd -u ntp:ntp $OPTIONS',
        )
      }
      
      # Ensure X Window System is not installed - Section 2.2.2
      it {
        is_expected.to contain_package('xorg-x11-server-Xorg').with(
          'ensure' => 'absent',
        )
      }

      # Ensure Avahi Server is not installed - Section 2.2.3
      it {
        is_expected.to contain_service('avahi-daemon').with(
          'enable' => false,
        )
      }

      it {
        is_expected.to contain_service('avahi-autoipd').with(
          'ensure' => 'absent',
        )
      }

      # Ensure CUPS is not installed - Section 2.2.4
      it {
        is_expected.to contain_package('cups').with(
          'ensure' => 'absent',
        )
      }

      # Ensure DHCP Server is not installed - Section 2.2.5
      it {
        is_expected.to contain_package('dhcp').with(
          'ensure' => 'absent',
        )
      }

      # Ensure LDAP Server is not installed - Section 2.2.6
      it {
        is_expected.to contain_package('openldap-servers').with(
          'ensure' => 'absent',
        )
      }

      # Ensure nfs-utils is not installed or the nfs-server service is masked - Section 2.2.7
      it {
        is_expected.to contain_package('nfs-utils').with(
          'ensure' => 'absent',
        )
      }

      # Ensure rpcbind is not installed or the rpcbind services are masked - Section 2.2.8
      it {
        is_expected.to contain_package('rpcbind').with(
          'ensure' => 'absent',
        )
      }

      # Ensure DNS Server is not installed - Section 2.2.9
      it {
        is_expected.to contain_package('bind').with(
          'ensure' => 'absent',
        )
      }

      # Ensure FTP Server is not installed - Section 2.2.10
      it {
        is_expected.to contain_package('vsftpd').with(
          'ensure' => 'absent',
        )
      }

      # Ensure HTTP Server is not installed - Section 2.2.11
      it {
        is_expected.to contain_package('httpd').with(
          'ensure' => 'absent',
        )
      }

      # Ensure IMAP and POP3 Server are not installed - Section 2.2.12
      it {
        is_expected.to contain_package('dovecot').with(
          'ensure' => 'absent',
        )
      }

      # Ensure Samba is not installed - Section 2.2.13
      it {
        is_expected.to contain_package('samba').with(
          'ensure' => 'absent',
        )
      }

      # Ensure HTTP Proxy Server is not installed - Section 2.2.14
      it {
        is_expected.to contain_package('squid').with(
          'enable' => false,
        )
      }

      # Ensure SNMP Server is not enabled - Section 2.2.14
      it {
        is_expected.to contain_service('snmpd').with(
          'enable' => false,
        )
      }

      # Ensure MTA is configured for local-only mode - Section 2.2.15
      it {
        is_expected.to contain_file_line('smptp_local_only_mode').with(
          'ensure' => 'present',
          'path'   => '/etc/postfix/main.cf',
          'line'   => 'inet_interfaces = loopback-only',
          'match'  => '^inet_interfaces\ =',
        )
      }

      # Ensure NIS Server is not enabled - Section 2.2.16
      it {
        is_expected.to contain_service('ypserv').with(
          'enable' => false,
        )
      }

      # Ensure RSH Server is not enabled - Section 2.2.17
      it {
        is_expected.to contain_service('rsh.socket').with(
          'enable' => false,
        )
      }

      it {
        is_expected.to contain_service('rlogin.socket').with(
          'enable' => false,
        )
      }

      it {
        is_expected.to contain_service('rexec.socket').with(
          'enable' => false,
        )
      }

      # Ensure Telnet Server is not enabled - Section 2.2.18
      it {
        is_expected.to contain_service('telnet.socket').with(
          'enable' => false,
        )
      }

      # Ensure tftp Server is not enabled - Section 2.2.19
      it {
        is_expected.to contain_service('tftp.socket').with(
          'enable' => false,
        )
      }

      # Ensure Rsync Service is not enabled - Section 2.2.20
      it {
        is_expected.to contain_service('rsyncd').with(
          'enable' => false,
        )
      }

      # Ensure Talk server is not enabled - Section 2.2.21
      it {
        is_expected.to contain_service('ntalk').with(
          'enable' => false,
        )
      }

      # Ensure manifest compiles with all dependencies
      it {
        is_expected.to compile.with_all_deps
      }
    end
  end
end
