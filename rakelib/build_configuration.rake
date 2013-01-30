require 'yaml'
require 'rake/clean'

def load_build_configuration
  main_configuration = {}
  user_configuration = {}

  main_configuration = YAML::load(File.read('build.yml')) if File.exists? 'build.yml'
  user_configuration = YAML::load(File.read('build.user.yml')) if File.exists? 'build.user.yml'

  main_configuration.merge user_configuration
end

BUILD_CONFIG = load_build_configuration

begin
  CLEAN.add BUILD_CONFIG[:output]
rescue Exception => e
  puts 'Not adding standard output dir to clean. Could not find the key'
end
