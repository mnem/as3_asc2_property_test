desc "Build the swf"
task 'build' do 
  out_swf = File.join BUILD_CONFIG[:output], 'PrivateSah.swf'
  main_src = 'src/Main.as'
  src_dir  = main_src.pathmap '%d'

  mkdir_p out_swf.pathmap '%d'
  compile_swf out_swf, main_src, src_dir
end

task :default => ['build']
