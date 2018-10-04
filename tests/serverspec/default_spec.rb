require "spec_helper"
require "serverspec"

package = "cncjs"
service = "cncjs"
user    = "cncjs"
group   = "cncjs"
home    = "/home/#{user}"
service = "cncjs"
ports = [8000]

case os[:family]
when "freebsd"
  home = "/usr/home/#{user}"
end
root_dir = "#{home}/cncjs"
config = "#{home}/.cncrc"

describe group(group) do
  it { should exist }
end

describe user(user) do
  it { should exist }
  it { should belong_to_group group }
  it { should belong_to_primary_group group }
  it { should have_home_directory home }
end

describe file(root_dir) do
  it { should be_directory }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(config) do
  it { should be_file }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  its(:content_as_json) { should include("ports") }
  its(:content_as_json) { should include("watchDirectory" => "/path/to/dir") }
end


describe service(service) do
  it { should be_enabled }
  it { should be_running }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
