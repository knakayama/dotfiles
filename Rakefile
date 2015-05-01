# coding: utf-8

require 'rake/clean'

HOME          = ENV['HOME']
PWD           = File.dirname(__FILE__)
FILES         = Dir.glob('*[a-z]', File::FNM_DOTMATCH).grep(/(?:\.(?!(?:md|git(?:ignore)?)$)|bin)/)
NEOBUNDLE_DIR = "#{ENV['HOME']}/.vim/bundle/neobundle.vim"
TPM_DIR       = "#{ENV['HOME']}/.tmux/plugins/tpm"

def create_symlink(src_file, dst_file)
  File.symlink(src_file, dst_file) unless File.exist?(dst_file)
end

CLEAN.concat(FILES.map { |p| File.join(HOME, p) })

desc 'Setup all'
task setup: [:symlink, :git_clone]

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

desc 'Clone some repogitories'
task :git_clone do
  sh "git clone https://github.com/Shougo/neobundle.vim #{NEOBUNDLE_DIR}" \
    unless File.exist?(NEOBUNDLE_DIR)
  sh "git clone https://github.com/tmux-plugins/tpm.git #{TPM_DIR}" \
    unless File.exist?(TPM_DIR)
end
