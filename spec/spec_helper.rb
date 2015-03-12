dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, 'lib')

require 'puppetlabs_spec_helper/module_spec_helper'
require 'facter/core/execution'
require 'facter'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

# Add fixture lib dirs to LOAD_PATH. Work-around for PUP-3336
Dir["#{fixture_path}/modules/*/lib"].entries.each do |lib_dir|
  $LOAD_PATH << lib_dir
  # Load custom facters
  Dir[File.expand_path(File.join(lib_dir, 'facter/*.rb'))].each {|file| require file}
end #


RSpec.configure do |c|
  c.mock_with :rspec
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
end

at_exit { RSpec::Puppet::Coverage.report! }

# We need this because the RAL uses 'should' as a method.  This
# allows us the same behaviour but with a different method name.
class Object
    alias :must :should
end
