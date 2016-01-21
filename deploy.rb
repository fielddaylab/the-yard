#!/usr/bin/env ruby

# Enter login details here
require "#{ENV['HOME']}/fdllogins" # I store mine outside of the repo; edit as necessary
url        = $fdl_logins[:theyardgames][:url]
username   = $fdl_logins[:theyardgames][:username]
password   = $fdl_logins[:theyardgames][:password]
remote_dir = $fdl_logins[:theyardgames][:remote_dir]

require 'net/sftp'

def log(s)
  STDERR.puts s
end

def mkdir_f(sftp, dir)
  sftp.mkdir! dir
rescue Net::SFTP::StatusException
  # directory already exists
end

def upload_rf(sftp, from, to)
  log "Uploading #{from} to #{to}"
  Dir.entries(from).each do |ent|
    next if %w{. .. .DS_Store .gitignore .git .gitmodules
      deploy.rb Gruntfile.coffee package.json .sass-cache
      Makefile README.md .sublime-grunt.cache
      node_modules shared
      }.include? ent
    full_from = "#{from}/#{ent}"
    full_to = "#{to}/#{ent}"
    if File.file?(full_from)
      begin
        sftp.remove! full_to
      rescue Net::SFTP::StatusException
        # file doesn't already exist
      end
      sftp.upload! full_from, full_to
    else
      mkdir_f sftp, full_to
      upload_rf sftp, full_from, full_to
    end
  end
end

Net::SFTP.start(url, username, password: password) do |sftp|
  log " => Connected #{username}@#{url} via SFTP."
  log " => Uploading repo to #{remote_dir}..."
  upload_rf sftp, File.dirname(__FILE__), remote_dir
  log ' => Done!'
end
