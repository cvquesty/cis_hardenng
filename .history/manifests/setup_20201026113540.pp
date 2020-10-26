# @summary A manifest to configure initial hardening according to CIS
# CIS hardening guidelines
#
# Section 1 - Initial Setup
#
# Enforces CIS v. 3.0.0 recommendations for initial setup according to published 
# hardening guidelines for CentOS 7.x systems
#
class cis_hardening::setup {

  include cis_hardening::setup::updates
  include cis_hardening::setup::secboot
  include cis_hardening::setup::prochardening
  include cis_hardening::setup::fim
  include cis_hardening::setup::filesystem        # Section 1.1
  include cis_hardening::setup::banners
  include cis_hardening::setup::accessctl

}
