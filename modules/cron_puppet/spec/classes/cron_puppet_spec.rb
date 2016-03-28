require 'spec_helper'

describe 'cron_puppet' do
  it { should contain_file('post-hook') }
  it { should contain_cron('puppet-apply').that_requires('File[post-hook]') }
end
