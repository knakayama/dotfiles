#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'
require 'date'

opts = {}
opt = OptionParser.new
opt.on('-c', '--create', 'Create symlink') { |v| opts[:c] = v }
opt.on('-r', '--remove', 'Remove symlink') { |v| opts[:r] = v }
opt.on('-f', '--force', 'Force to create/remove symlink') { |v| opts[:f] = v }
opt.parse!(ARGV)

def create_target_list
    target_list = []
    excludes = Regexp.new('^(\.git(ignore|modules)?|README\.md|tmux-scripts)$')

    Dir.open(File.expand_path("~/dotfiles")) do |dir|
        dir.each do |target|
            next if target == '.' || target == '..'
            next if excludes =~ target
            target_list.push(target)
        end
    end

    return target_list
end

def create_symlink(force=nil)
    target_list = create_target_list

    target_list.each do |target|
        target_home_path = File.expand_path("~/#{target}")
        target_dotfiles_path = File.expand_path("~/dotfiles/#{target}")

        puts "create symlink #{target}"
        if force
            FileUtils.symlink(target_dotfiles_path, target_home_path, :force => true)
        else
            if File.exists?(target_home_path)
                time = DateTime.now.strftime("%Y-%m-%d-%H:%M:%S")
                FileUtils.mv(target_home_path, target_home_path + ".#{time}")
            end
            FileUtils.symlink(target_dotfiles_path, target_home_path)
        end
    end
end

def remove_symlkink(force=nil)
    target_list = create_target_list

    target_list.each do |target|
        target_home_path = File.expand_path("~/#{target}")

        if File.symlink?(target_home_path)
            puts "remove symlink #{target}"
            if force
                FileUtils.rm_rf(target_home_path, :secure => true)
            else
                FileUtils.rm_r(target_home_path, :secure => true)
            end
        end
    end
end

if opts[:c]
    create_symlink(opts[:f])
elsif opts[:r]
    remove_symlkink(opts[:f])
else
    puts opt.help
    exit 1
end

