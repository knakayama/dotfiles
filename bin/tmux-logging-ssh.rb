#!/usr/bin/env ruby

require "fileutils"
require "date"

def error_msg
  `tmux display-message "Unknown Argument: #{ARGV.to_s}"`
  exit 0
end

def validate_argv_length
  case ARGV.length
  when 1
    ary = validate_arg1 ARGV[0]
  when 2
    ary = validate_arg2 ARGV[0]
  else
    error_msg
  end

  return ary
end

def validate_arg1(arg)
  case arg
  when "k"
    return ["k", "kero"]
  when "c"
    return ["c", "config"]
  when "o"
    return ["o", "ops1"]
  else
    error_msg
  end
end

def validate_arg2(arg)
  case arg
  when "s", "v", "h"
    return ARGV
  else
    error_msg
  end
end

ary      = validate_argv_length
t        = DateTime.now
log_dir  = "#{ENV['HOME']}/.tmuxlog/#{ary[1]}/#{t.strftime('%Y-%m-%d')}"
log_file = "#{log_dir}/#{t.strftime('%H:%M:%S')}.log"
key      = "#{ENV['HOME']}/.ssh/k"

begin
  FileUtils.mkdir_p(log_dir)
rescue
  `tmux display-message "Can not create #{log_dir}"`
  exit 0
end

case ary[0]
when "k", "c", "o"
  `tmux new-window -n "#{ary[1]}" "ssh #{ary[1]}" \\; pipe-pane "cat >> #{log_file}"`
when "s"
  `tmux new-window -n "#{ary[1].split(/\./)[0]}" "ssh -i #{key} -t kero 'sudo ssh #{ary[1]}'" \\; pipe-pane "cat >> #{log_file}"`
when "v", "h"
  `tmux split-window "-#{ary[0]}" "ssh -i #{key} -t kero 'sudo ssh #{ary[1]}'" \\; pipe-pane "cat >> #{log_file}"`
else
  error_msg
end

