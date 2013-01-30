require 'open3'

def playerglobal_lib
  fail "Missing :flash_sdk key in build configuration" unless BUILD_CONFIG.key? :flash_sdk
  fail "Missing :playerglobal_version key in build configuration" unless BUILD_CONFIG.key? :playerglobal_version

  path = File.join BUILD_CONFIG[:flash_sdk], 'frameworks', 'libs', 'player', BUILD_CONFIG[:playerglobal_version], 'playerglobal.swc'

  fail "Missing playerglobal.swc. Expected to find #{path}" unless File.exists? path

  return path
end

def shared_libs
  BUILD_CONFIG[:libs] || []
end

def shared_srcs
  BUILD_CONFIG[:srcs] || []
end

def compile_actionscript sdk_home, compiler, swf_module, main_src, swf_version, source_paths, library_paths, arguments
  executable = "\"#{File.join sdk_home, compiler}\""

  arguments ||= []
  arguments = [arguments] unless arguments.kind_of?(Array)
  command = [executable] + arguments + [
    "-swf-version=#{swf_version}",
    "-o \"#{swf_module}\"",
  ]

  library_paths ||= []
  library_paths = [library_paths] unless library_paths.kind_of?(Array)
  library_paths << playerglobal_lib
  library_paths << shared_libs
  library_paths.flatten!
  command << library_paths.map {|fn| "-library-path+=\"#{fn}\""}

  source_paths ||= []
  source_paths = [source_paths] unless source_paths.kind_of?(Array)
  source_paths << shared_srcs
  source_paths.flatten!
  command << source_paths.map {|fn| "-source-path+=\"#{fn}\""}

  command << main_src

  options = {}
  if RakeFileUtils.verbose_flag == :default
    options[:verbose] = false
  else
    options[:verbose] ||= RakeFileUtils.verbose_flag
  end

  ENV['AIR_SDK_HOME'] = sdk_home
  ENV['FLEX_SDK_HOME'] = sdk_home

  command = (command.flatten).join(' ')
  puts "Compiling #{swf_module}"
  result = nil
  output = ''
  Open3.popen2(command, {:err => [:child, :out]}) do |i, o, th|
    output = o.read
    result = th.value
  end

  if not result.success?
    puts command
    puts output
    fail "Compilation failed: #{result}"
  end
end

def compile_swf swf_module, main_src, source_paths, library_paths = nil, arguments = nil
  fail "Missing :flash_sdk key in build configuration" unless BUILD_CONFIG.key? :flash_sdk
  fail "Missing :swf_version key in build configuration" unless BUILD_CONFIG.key? :swf_version
  compile_actionscript BUILD_CONFIG[:flash_sdk], 'bin/amxmlc', swf_module, main_src, BUILD_CONFIG[:swf_version], source_paths, library_paths, arguments
end

def compile_swc swf_module, sources, source_paths = nil, library_paths = nil, arguments = nil
  fail "Missing :flash_sdk key in build configuration" unless BUILD_CONFIG.key? :flash_sdk
  fail "Missing :swf_version key in build configuration" unless BUILD_CONFIG.key? :swf_version

  sources = [sources] unless sources.kind_of?(Array)

  arguments ||= []
  arguments = [arguments] unless arguments.kind_of?(Array)
  arguments << sources.map {|fn| "--include-sources+=\"#{fn}\""}

  compile_actionscript BUILD_CONFIG[:flash_sdk], 'bin/acompc', swf_module, '', BUILD_CONFIG[:swf_version], source_paths, library_paths, arguments
end
