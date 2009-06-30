require 'test/unit'

# Load the environment
unless defined? RADIANT_ROOT
  ENV["RAILS_ENV"] = "test"
  case
  when ENV["RADIANT_ENV_FILE"]
    require ENV["RADIANT_ENV_FILE"]
  when File.dirname(__FILE__) =~ %r{vendor/radiant/vendor/extensions}
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../../")}/config/environment"
  else
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
  end
end

class Test::Unit::TestCase
  def self.use_transactional_fixtures=(value); end
  def self.use_instantiated_fixtures=(value); end
  def self.fixture_path=(value); end
end

require "#{RADIANT_ROOT}/test/test_helper"

require 'dataset'
class Test::Unit::TestCase
  include Dataset
  datasets_directory "#{RADIANT_ROOT}/spec/datasets"
  Dataset::ContextClassMethods.datasets_database_dump_path = File.expand_path(datasets_database_dump_path = File.join(File.dirname(__FILE__), "..", "tmp"))
end
