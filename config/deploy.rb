require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'pfadismn.ch'
set :deploy_to, '/srv/www/pfadismn.ch.git'
set :repository, 'file:///srv/git/pfadismn.ch.git'
set :branch, 'master'
set :user, 'deploy'
set :password, '4UWeswumUY3B'
set :rvm_path, '/usr/local/rvm/scripts/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/email.yml', 'log', 'public/photos', 'var']


# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-1.9.3]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
end

namespace :rails do
  task :'tmp_create' do
    queue %{
      echo "-----> Creating tmp/"
      #{echo_cmd %[#{rake} tmp:create]}
    }
  end
end

namespace :filesystem do
  task :'cleanup' do
    queue %{
      echo "-----> Resetting Permissions tmp/"
      chown -R :www-data .
    }
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    queue 'RAILS_ENV="production" bundle exec rake assets:precompile'
    #invoke :'rails:assets_precompile'
    invoke :'rails:tmp_create'
    invoke :'filesystem:cleanup'

    to :launch do
      queue 'touch tmp/restart.txt'
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

