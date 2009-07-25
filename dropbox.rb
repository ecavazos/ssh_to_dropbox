require 'dir_sync'

# a simple script to copy my ssh keys to my local dropbox folder 
# if the keys exist, then it will only copy the files that
# need to updated

source = '/Users/Emilio/.ssh'
destination = '/Users/Emilio/Dropbox/ssh_macbook'

raise "Could not find #{source} directory." unless File.directory?(source)

if !DirSync.sync(source, destination)
  puts "SSH keys are current and don't need to be backed up."
  exit
end

puts 'SSH keys backed up successfully.'
