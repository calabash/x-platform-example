#!/usr/bin/env ruby
require 'fileutils'
require 'open3'

target_dir = File.expand_path("~/.calabash")

if File.directory?(target_dir)
  puts "Error: #{target_dir} already exists. Aborting."
  exit(false)
end

target_gems = %w(cucumber calabash-android calabash-cucumber).join " "
install_opts = "--no-ri --no-rdoc"
env = "GEM_HOME=~/.calabash"
install_cmd = "#{env} gem install #{target_gems} #{install_opts}"

puts "Creating #{target_dir}."
FileUtils.mkdir target_dir

puts "Installing Calabash... This will take a few minutes"
puts "Running:\n #{install_cmd}"

pid = fork { exec(install_cmd) }
puts "Please wait..."
_, status = Process.waitpid2(pid)


unless status.success?
  puts "Error while running command: #{install_cmd}."
  exit(1)
end

puts "Done!"

puts "To uninstall delete #{target_dir}"

puts ""
puts "Now run these commands to setup your env in this shell (or add to .bash_profile):"

puts <<EOF

export GEM_HOME=~/.calabash
export GEM_PATH=~/.calabash
export PATH="$PATH:$HOME/.calabash/bin"
EOF
