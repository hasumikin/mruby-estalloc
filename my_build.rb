MRuby::CrossBuild.new('my_build') do |conf|
  conf.toolchain :gcc

  conf.cc.flags << "-m32"
  conf.cc.flags << "-O0"
  conf.cc.flags << "-g3"
  conf.linker.flags << "-m32"

  conf.cc.defines << "POOL_ALIGNMENT=4"

  conf.gem core: "mruby-bin-mruby"
  conf.gem core: "mruby-io"
end

