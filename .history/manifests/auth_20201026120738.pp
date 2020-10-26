# @summary A manifest to configure Authentication and Authrization
# according to CIS hardening guidelines
#
# Section 5 - Access, Authentication, and Authorization
#
# Enforces CIS recommendations for Authentication and Authorization  
# according to published hardening guidelines for CentOS 7.x systems
# 
class cis_hardening::auth {

  include cis_hardening::auth::accounts   # Section 
  include cis_hardening::auth::cron
  include cis_hardening::auth::pam
  include cis_hardening::auth::ssh        # Section 5.2 - 
  include cis_hardening::auth::su

}
