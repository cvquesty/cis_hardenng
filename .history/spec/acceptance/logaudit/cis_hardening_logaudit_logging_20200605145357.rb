require 'spec_helper_acceptance'

describe service('rsyslog') do
    it { should be_instaled}
end