# coding: utf-8

require 'rake/clean'

HOME  = ENV['HOME']
PWD   = File.dirname(__FILE__)
FILES = Dir.glob('*[a-z]', File::FNM_DOTMATCH).grep(/(?:\.(?!(?:md|\.bundle|lock|git(?:ignore|modules)?)$)|bin)/)

def create_symlink(src_file, dst_file)
  File.symlink(src_file, dst_file) unless File.exist?(dst_file)
end

CLEAN.concat(FILES.map { |p| File.join(HOME, p) })

desc 'Setup all'
task setup: [:symlink]

desc 'Create symlinks'
task :symlink do
  FILES.each do |file_name|
    src_file = File.join(PWD, file_name)
    dst_file = File.join(HOME, file_name)

    # if dst_file already exists and is not symlink, then backup it
    if File.exist?(dst_file) && !File.symlink?(dst_file)
      mv dst_file, dst_file + '.' + Time.now.strftime('%Y-%m-%d-%H:%M:%S')
    end

    create_symlink(src_file, dst_file)
  end
end
